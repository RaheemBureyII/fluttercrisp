import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class ChatWidget extends StatefulWidget {
  ChatWidget({Key? key, this.backgroundColor=Colors.white,this.phone, this.name, this.company, this.email, required this.webid,this.onLoad, this.onAgentMessage,this.sessiondata,required this.website, this.closebuttoncolor=Colors.white}) : super(key: key);
  final  backgroundColor;
  final  closebuttoncolor;
  final name;
  final company;
  final phone;
  final email;
  final webid;
  final website;
  final Map<String,dynamic>? sessiondata;
  final Function? onLoad;
  final Function? onAgentMessage;
  @override
  State<ChatWidget> createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  late HeadlessInAppWebView headlessInAppWebView;
  late int index;
  @override
  void initState(){
    index=0;
    headlessInAppWebView=HeadlessInAppWebView(
      initialOptions: InAppWebViewGroupOptions(
          crossPlatform: InAppWebViewOptions(
            preferredContentMode: UserPreferredContentMode.MOBILE,
            mediaPlaybackRequiresUserGesture: false,
            disableHorizontalScroll: true,

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

        var result = await controller.callAsyncJavaScript(
            functionBody: function);

      },
      onWebViewCreated: (controller)async{

        controller.addJavaScriptHandler(handlerName: 'UploadInfo', callback: (args) async {
          print("in there");

          Map<String,dynamic> data={
            "company":widget.company,
            "webid":widget.webid,
            "name":widget.name,
            "email":widget.email,
            "phone":widget.phone,
            "session_data":widget.sessiondata
          };
          final json = jsonEncode(data);
          return json;
        });
        controller.addJavaScriptHandler(handlerName: 'onLoad', callback: (args) async {
          widget.onLoad?.call();
        });
        controller.addJavaScriptHandler(handlerName: 'onAgentMessage', callback: (args) async {
          widget.onAgentMessage?.call(args[0]);
        });
      },

    );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: widget.backgroundColor,
        body: SafeArea(
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width>559?559:double.infinity,
              child: Stack(
                children: [

                  InAppWebView(
                    initialOptions: InAppWebViewGroupOptions(
                        crossPlatform: InAppWebViewOptions(
                          preferredContentMode: UserPreferredContentMode.MOBILE,
                          mediaPlaybackRequiresUserGesture: false,
                          disableHorizontalScroll: true,

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
                      headlessInAppWebView.dispose();
                      final String functionBody1 = function;
                      var result = await controller.callAsyncJavaScript(
                          functionBody: function);

                    },
                    onWebViewCreated: (controller)async{

                      controller.addJavaScriptHandler(handlerName: 'UploadInfo', callback: (args) async {
                        print("in there");

                        Map<String,dynamic> data={
                          "company":widget.company,
                          "webid":widget.webid,
                          "name":widget.name,
                          "email":widget.email,
                          "phone":widget.phone,
                          "session_data":widget.sessiondata
                        };
                        final json = jsonEncode(data);
                        return json;
                      });
                      controller.addJavaScriptHandler(handlerName: 'onLoad', callback: (args) async {
                        setState(() {
                          index=1;
                        });
                        widget.onLoad?.call();
                      });
                    },
                  ),
                  index!=1?Container(width:double.infinity,height:double.infinity,color:Colors.white,child: Center(child: CircularProgressIndicator(),),):Container(),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children:[ IconButton(onPressed: (){
                        headlessInAppWebView.run();
                        Get.back();
                        //changestate(false);
                      }
                          , icon: Icon(Icons.close_outlined,color: widget.closebuttoncolor,size: MediaQuery.of(context).size.width*0.06,))])
                ],
              ),
            ),
          ),
        )
    );
  }
}

String function ="""

                   document.body.innerHTML='<div></div>';
                    var jsondata;
                      var webid;
                       
                     
                       const args = ["we in there like swimwear"];
                       window.flutter_inappwebview.callHandler('UploadInfo', ...args).then(function(result) {
                                     jsondata=JSON.parse(result);
                                      webid=jsondata.webid;
                                      loadup();
                                   });;
                      
          
                      window.CRISP_RUNTIME_CONFIG = {
                        lock_maximized       : true,
                        cross_origin_cookies : true
                      };
                      function onagenmessage(message){
                      const args = [message.content];
                          window.flutter_inappwebview.callHandler('onAgentMessage',...args);
                      }
                      function onstart(){
                      const args = ["started"];
                          window.flutter_inappwebview.callHandler('onLoad',...args);
                      }
                      
                      function loadup(){
                      //onstart();
                      
                       window.\$crisp=[];window.CRISP_WEBSITE_ID=webid;(function(){d=document;s=d.createElement("script");s.src="https://client.crisp.chat/l.js";s.async=1;d.getElementsByTagName("head")[0].appendChild(s);})();
                      }
                      
                       window.CRISP_READY_TRIGGER =function(){
                       
                          if(\$crisp.is("chat:opened")===true){
                          \$crisp.push(["set", "user:email", [jsondata.email]]);
                          \$crisp.push(["set", "user:nickname", [jsondata.name]]);
                          \$crisp.push(["set", "user:phone", [jsondata.phone]]);
                          \$crisp.push(["set", "user:company", [jsondata.company]]);
                          \$crisp.push(["set", "session:data", [jsondata.session_data!=undefined?Object.entries(jsondata.session_data):[]]]);
                          \$crisp.push(["on", "message:received", onagenmessage])
                          onstart();
                          }
                       }
                       
                       //loadup();
                       //window.\$crisp=[];window.CRISP_WEBSITE_ID="1fe61c88-a23f-40f2-aa2b-1e4a554edcde";(function(){d=document;s=d.createElement("script");s.src="https://client.crisp.chat/l.js";s.async=1;d.getElementsByTagName("head")[0].appendChild(s);})();
                      // document.onreadystatechange = () => {
                      //  if (document.readyState === 'complete') {
                      //    setTimeout(loadup,200);
                      //    //window.\$crisp=[];window.CRISP_WEBSITE_ID=jsondata.webid;(function(){d=document;s=d.createElement("script");s.src="https://client.crisp.chat/l.js";s.async=1;d.getElementsByTagName("head")[0].appendChild(s);})();
                      //
                      //  }
                      // };
                  
                  

                  """;

