import 'package:flutter/material.dart';
import 'package:flutteronline/pages/CameraPage.dart';
import 'package:flutteronline/pages/PicturePage.dart';

class CameraStack extends StatefulWidget {
  CameraStack({Key key}) : super(key: key);

  @override
  _CameraStackState createState() => _CameraStackState();
}

class _CameraStackState extends State<CameraStack> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: 'camerastack/camera',
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case 'camerastack/camera':
            builder = (BuildContext _) => CameraPage();
            break;
          case 'camerastack/picture':
            builder = (BuildContext _) => PicturePage();
            break;
          
          default:
            throw Exception('Invalid route: ${settings.name}');
        }
        return MaterialPageRoute(builder: builder, settings: settings);
      },
    );
  }
}