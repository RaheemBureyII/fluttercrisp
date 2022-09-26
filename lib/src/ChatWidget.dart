import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class ChatWidget extends StatefulWidget {
  ChatWidget({Key? key, this.backgroundColor, this.name, this.company, this.email, required this.webid,this.onLoad, this.onAgentMessage,required this.website}) : super(key: key);
  final  backgroundColor;
  final name;
  final company;
  final email;
  final webid;
  final website;
  final Function? onLoad;
  final Function? onAgentMessage;
  @override
  State<ChatWidget> createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: widget.backgroundColor,
        body: SafeArea(
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width>559?559:double.infinity,
              child: InAppWebView(
                initialOptions: InAppWebViewGroupOptions(
                    crossPlatform: InAppWebViewOptions(
                        preferredContentMode: UserPreferredContentMode.MOBILE,
                        mediaPlaybackRequiresUserGesture: false,
                        disableHorizontalScroll: true,
                        disableVerticalScroll: true

                    ),
                    android: AndroidInAppWebViewOptions(
                        useHybridComposition: true
                    ),
                    ios: IOSInAppWebViewOptions(
                      allowsInlineMediaPlayback: true,

                      //allowsInlineMediaPlayback: true,
                    )
                ),
                initialUrlRequest: URLRequest(url: Uri.parse(widget?.website)),
                androidOnPermissionRequest: (controller, origin, resources) async {
                  return PermissionRequestResponse(resources: resources, action: PermissionRequestResponseAction.GRANT);
                },
                onLoadStop: (controller,url)async{
                  var result = await controller.injectJavascriptFileFromAsset(assetFilePath: "assets/index.js");
                },
                onWebViewCreated: (controller){
                  controller.addJavaScriptHandler(handlerName: 'UploadInfo', callback: (args) async {
                    Map<String,dynamic> data={
                      "company":widget.company,
                      "webid":widget.webid,
                      "name":widget.name,
                      "email":widget.email
                    };
                    final json = jsonEncode(data);
                    return json;
                  });
                  controller.addJavaScriptHandler(handlerName: 'onLoad', callback: (args) async {
                    widget.onLoad?.call();
                  });
                  controller.addJavaScriptHandler(handlerName: 'onAgentMessage', callback: (args) async {
                    widget.onAgentMessage?.call();
                  });
                },
              ),
            ),
          ),
        )
    );
  }
}
