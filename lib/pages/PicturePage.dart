import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:flushbar/flushbar.dart';

class PicturePage extends StatefulWidget {
  PicturePage({Key key}) : super(key: key);

  @override
  _PicturePageState createState() => _PicturePageState();
}

class _PicturePageState extends State<PicturePage> {
  Map picture;

  @override
  Widget build(BuildContext context) {
    picture = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(title: Text('picture before uplode')),
      body: Container(
        child: Image.file(
          File(picture['path']),
          fit: BoxFit.fill,
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.center,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.file_upload),
        onPressed: () async {
          //convert image to base64
          final bytes = await File(picture['path']).readAsBytes();
          var base64Image = convert.base64Encode(bytes);

          var url = 'https://api.codingthailand.com/api/upload';
          var response = await http.post(url,
              headers: {'Content-Type': 'application/json'},
              body: convert.jsonEncode(
                  {'picture': 'data:image/jpeg;base64,' + base64Image}));

          if (response.statusCode == 200) {
            var feedback = convert.jsonDecode((response.body));
            Flushbar(
              title: '${feedback['data']['message']}',
              message: '${feedback['data']['url']}',
              icon: Icon(
                Icons.info_outline,
                size: 28.0,
                color: Colors.blue[300],
              ),
              duration: Duration(seconds: 3),
              leftBarIndicatorColor: Colors.blue[300],
            )..show(context);
          } else {
            print('error from backend');
          }
        },
      ),
    );
  }
}
