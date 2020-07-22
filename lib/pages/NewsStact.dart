import 'package:flutter/material.dart';
import 'package:flutteronline/pages/NewsPage.dart';
import 'package:flutteronline/pages/WebViewPage.dart';

class NewsStack extends StatefulWidget {
  NewsStack({Key key}) : super(key: key);

  @override
  _NewsStackState createState() => _NewsStackState();
}

class _NewsStackState extends State<NewsStack> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: 'newsstack/news',
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case 'newsstack/news':
            builder = (BuildContext _) => NewsPage();
            break;
          case 'newsstack/webview':
            builder = (BuildContext _) => WebViewPage();
            break;
          
          default:
            throw Exception('Invalid route: ${settings.name}');
        }
        return MaterialPageRoute(builder: builder, settings: settings);
      },
    );
  }
}