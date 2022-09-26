var jsondata;
var webid;
window.addEventListener("flutterInAppWebViewPlatformReady",  function(event) {
 const args = ["we in there like swimwear"];
 window.flutter_inappwebview.callHandler('myHandlerName', ...args).then(function(result) {
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
 window.$crisp=[];window.CRISP_WEBSITE_ID="1fe61c88-a23f-40f2-aa2b-1e4a554edcde";(function(){d=document;s=d.createElement("script");s.src="https://client.crisp.chat/l.js";s.async=1;d.getElementsByTagName("head")[0].appendChild(s);})();
}
 window.CRISP_READY_TRIGGER =function(){
    if($crisp.is("chat:opened")===true){
    $crisp.push(["set", "user:email", [jsondata.email]]);
    $crisp.push(["set", "user:nickname", [jsondata.name]]);
    $crisp.push(["set", "user:company", [jsondata.company]]);
    $crisp.push(["on", "message:received", onagenmessage])
    }
 }
 loadup();
 //window.$crisp=[];window.CRISP_WEBSITE_ID="1fe61c88-a23f-40f2-aa2b-1e4a554edcde";(function(){d=document;s=d.createElement("script");s.src="https://client.crisp.chat/l.js";s.async=1;d.getElementsByTagName("head")[0].appendChild(s);})();
//document.onreadystatechange = () => {
//  if (document.readyState === 'complete') {
//    setTimeout(loadup,200);
//    //window.$crisp=[];window.CRISP_WEBSITE_ID=jsondata.webid;(function(){d=document;s=d.createElement("script");s.src="https://client.crisp.chat/l.js";s.async=1;d.getElementsByTagName("head")[0].appendChild(s);})();
//
//  }
//};

