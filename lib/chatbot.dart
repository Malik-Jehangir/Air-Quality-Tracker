import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ChatBot extends StatefulWidget {
  @override
  _ChatBotState createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    //MainString = widget.results;
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text("24/7 Helpline"),
        ),

        //continue with body here
        body: WebView(
          initialUrl: Uri.dataFromString(
                  '<html><body><iframe src="https://webchat.botframework.com/embed/myatrackbotservicechatbot?s=ChspjHS-l3g.eamEVvDGO5phLcR8tPNM9rnP5M0LwDoZixmYcGIsKhQ"  style="width: 100%;  height: 100%;"></iframe></body></html>',
                  mimeType: 'text/html')
              .toString(),
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
        ));
  }
}
