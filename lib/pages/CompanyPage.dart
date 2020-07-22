import 'package:flutter/material.dart';

class CompanyPage extends StatefulWidget {
  CompanyPage({Key key}) : super(key: key);

  @override
  _CompanyPageState createState() => _CompanyPageState();
}

class _CompanyPageState extends State<CompanyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('information')),
      body: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
            Image(
              image: AssetImage('assets/images/2.jpg'),
              fit: BoxFit.cover,
            ),
            SafeArea(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('CodingThailand',
                        style: TextStyle(
                            fontSize: 32, fontWeight: FontWeight.bold)),
                    Divider(),
                    Text(
                      'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using Content here, content here, making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for lorem ipsum will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).',
                      textAlign: TextAlign.left,
                    ),
                    Divider(),
                    SizedBox(height: 20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Column(children: <Widget>[
                          Icon(Icons.person, color: Colors.purpleAccent)
                        ]),
                        SizedBox(width: 16),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(children: <Widget>[Text('Wei Wuxian')]),
                              Row(children: <Widget>[Text('Lān h̄wạng cī')])
                            ]),
                      ],
                    ),
                    Divider(),
                    Wrap(
                        spacing: 8,
                        children: List.generate(
                            7,
                            (index) => Chip(
                                  label: Text('text ${index + 1}'),
                                  avatar: Icon(Icons.star),
                                  backgroundColor: Colors.purpleAccent,
                                ))),
                    Divider(),
                    buildflutter()
                  ],
                ),
              ),
            )
          ])),
    );
  }

  Row buildflutter() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          CircleAvatar(
            backgroundImage: AssetImage('assets/images/3.jpg'),
            radius: 40,
          ),
          CircleAvatar(
            backgroundImage: AssetImage('assets/images/3.jpg'),
            radius: 40,
          ),
          CircleAvatar(
            backgroundImage: AssetImage('assets/images/3.jpg'),
            radius: 40,
          ),
          SizedBox(
              width: 60,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Icon(Icons.access_alarm),
                    Icon(Icons.accessibility),
                    Icon(Icons.account_balance),
                  ]))
        ]);
  }
}
