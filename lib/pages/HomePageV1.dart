import 'package:flutter/material.dart';
import 'package:flutteronline/widgets/logo.dart';
import 'package:flutteronline/widgets/menu.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var fromAbout; //dynamic

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Menu(),
      appBar: AppBar(
        centerTitle: true,
        title: const Logo(),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'codingthailand.com',
            ),
            Text(
              'from about page is ${fromAbout ?? ''}',
            ),
            RaisedButton(
                child: Text('เกี่ยวกับเรา'),
                onPressed: () async {
                  fromAbout = await Navigator.pushNamed(context, 'homestack/about',
                      arguments: {
                        'email': 'codingThailand@gmail.com',
                        'phone': '08888888'
                      });
                  setState(() {
                    fromAbout = fromAbout;
                  });
                })
          ],
        ),
      ),
    );
  }
}
