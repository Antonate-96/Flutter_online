import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  WebViewPage({Key key}) : super(key: key);

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> news = ModalRoute.of(context).settings.arguments;

    return  Scaffold(
      appBar: AppBar(title: Text('${news['name']}')),
      body: WebView(
          initialUrl: '${news['url']}',
          javascriptMode: JavascriptMode.unrestricted,
      )
    );
  }
}