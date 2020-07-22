import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class AboutPage extends StatefulWidget {
  AboutPage({Key key}) : super(key: key);

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {

  Future<Map<String, dynamic>> _getData() async {
    var url = 'https://api.codingthailand.com/api/version';
    var response = await http.get(url);
    if (response.statusCode == 200) {
      //print(response.body);
      final Map<String, dynamic> version = convert.jsonDecode(response.body);
      return version;
    } else {
      //error 400,500
      throw Exception('Failed to load version ${response.statusCode}');
    }
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    Map company = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('เกี่ยวกับเรา'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FutureBuilder<Map<String, dynamic>>(
              future: _getData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(snapshot.data['data']['version']);
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }

                // By default, show a loading spinner.
                return CircularProgressIndicator();
              },
            ),
            Text('CodingThailand.com'),
            SizedBox(height: 30),
            Text('Email : ${company['email']}'),
            Divider(height: 20),
            Text('Tel : ${company['phone']}'),
            RaisedButton(
                child: Text('กลับหน้าหลัก'),
                onPressed: () {
                  Navigator.pop(context, 'About Page');
                }),
            RaisedButton(
                child: Text('ติดต่อเรา'),
                onPressed: () {
                  Navigator.pushNamed(context, 'homestack/contact');
                })
          ],
        ),
      ),
    );
  }
}
