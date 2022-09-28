import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class ChatWidget extends StatefulWidget {
  ChatWidget({Key? key, this.backgroundColor, this.name, this.company, this.email, required this.webid,this.onLoad, this.onAgentMessage,this.sessiondata,required this.website}) : super(key: key);
  final  backgroundColor;
  final name;
  final company;
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
                onLoadStart: (controller,url)async{
                  final String functionBody1 = """
                  const style = document.createElement('style');

                  style.textContent = `
                                      button.bg-transparent.spinner {
                      border-color: rgba(228, 228, 231, 1);
                  }
                  .spinner {
                      position: relative;
                      color: transparent !important;
                      pointer-events: none;
                      height: 100vh;
                    width: 100%;
                  }
                  
                  .spinner:after {
                      content: '';
                      z-index: 3;
                      position: absolute !important;
                      top: calc(50% - (1em / 2));
                      left: calc(50% - (1em / 2));
                      display: block;
                      width: 7em;
                      height: 7em;
                      border: 20px solid #ff2c324a;
                      border-radius: 9999px;
                      border-right-color: transparent;
                      border-top-color: transparent;
                      animation: spinAround 500ms infinite linear;
                  }
                  
                  @keyframes spinAround {
                      from {
                          transform: rotate(0deg);
                      }
                      to {
                          transform: rotate(360deg);
                      }
                  }
                  html, body {
                    height: 100%;
                  }
                  body {
                    display: flex;
                  }
                  `;
                  
                  document.head.appendChild(style);
                   document.body.innerHTML='<div class="spinner" style></div>';
                    var jsondata;
                      var webid;
                      
                      window.addEventListener("flutterInAppWebViewPlatformReady",  function(event) {
                       const args = ["we in there like swimwear"];
                       window.flutter_inappwebview.callHandler('UploadInfo', ...args).then(function(result) {
                                     jsondata=JSON.parse(result);
                                      webid=jsondata.webid;
                                   });;
                      });
                      window.CRISP_RUNTIME_CONFIG = {
                        lock_maximized       : true,
                        cross_origin_cookies : true
                      };
                      function onagenmessage(message){
                      const args = [message.content];
                          window.flutter_inappwebview.callHandler('agentsentmessage',...args);
                      }
                      function onstart(){
                      const args = ["started"];
                          window.flutter_inappwebview.callHandler('onstart',...args);
                      }
                      
                      function loadup(){
                      onstart();
                       window.\$crisp=[];window.CRISP_WEBSITE_ID="1fe61c88-a23f-40f2-aa2b-1e4a554edcde";(function(){d=document;s=d.createElement("script");s.src="https://client.crisp.chat/l.js";s.async=1;d.getElementsByTagName("head")[0].appendChild(s);})();
                      }
                       window.CRISP_READY_TRIGGER =function(){
                       //alert("yurr");
                          if(\$crisp.is("chat:opened")===true){
                          \$crisp.push(["set", "user:email", [jsondata.email]]);
                          \$crisp.push(["set", "user:nickname", [jsondata.name]]);
                          \$crisp.push(["set", "user:company", [jsondata.company]]);
                          \$crisp.push(["set", "session:data", [Object.entries(jsondata.session_data)]]);
                          \$crisp.push(["on", "message:received", onagenmessage])
                          }
                       }
                       setTimeout(loadup,1200);
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
                  var result = await controller.callAsyncJavaScript(
                      functionBody: functionBody1);
                },
                onWebViewCreated: (controller){
                  controller.addJavaScriptHandler(handlerName: 'UploadInfo', callback: (args) async {
                    print("in there");
                    Map<String,dynamic> data={
                      "company":widget.company,
                      "webid":widget.webid,
                      "name":widget.name,
                      "email":widget.email,
                      "session_data":widget.sessiondata
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
