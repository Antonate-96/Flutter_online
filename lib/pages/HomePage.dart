import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutteronline/redux/appReducer.dart';
import 'package:flutteronline/redux/profile/profileReducer.dart';
import 'package:flutteronline/widgets/logo.dart';
import 'package:flutteronline/widgets/menu.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutteronline/redux/profile/profileAction.dart';
import 'dart:convert' as convert;

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var fromAbout; //dynamic

  _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('profile');
    Navigator.of(context, rootNavigator: true)
        .pushNamedAndRemoveUntil('/login', (route) => false);
  }

  _getProfile() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var profileString = prefs.getString('profile');
    if(profileString != null) {
      // setState(() {
      //   profile = convert.jsonDecode(profileString);
      // });
      //call action
    final store = StoreProvider.of<AppState>(context);
    store.dispatch(getProfileAction(convert.jsonDecode(profileString)));
    }
  }

  @override
      void initState() {
        super.initState();
        _getProfile();
      }

  @override
  Widget build(BuildContext context) {
    //print('home build');
    return Scaffold(
        drawer: Menu(),
        appBar: AppBar(
          centerTitle: true,
          title: const Logo(),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                _logout();
              },
            )
          ],
        ),
        body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/bg.jpg'),
                    fit: BoxFit.cover)),
            child: Column(
              children: <Widget>[
              StoreConnector<AppState, ProfileState>(
                distinct: true,
                converter: (store) => store.state.profileState,
                builder: (context, profilestate) {
                  //print('connector build');
                  return Expanded(
                    flex : 1,
                    child: Center(
                      child: Text('Welcome ${profilestate.profile['name']} '),
                    )
                  );
                },
              ),
              Expanded(
                  flex: 10,
                  child: GridView.count(
                    primary: false,
                    padding: const EdgeInsets.all(20),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 2,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, 'homestack/company');
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.business,
                                    size: 80, color: Colors.purple
                                ),
                                Text('company', style: TextStyle(fontSize: 20))
                              ]),
                          color: Colors.white70,
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.of(context, rootNavigator : true).pushNamed('/map');
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.map, size: 80, color: Colors.purple),
                                Text('map', style: TextStyle(fontSize: 20))
                              ]),
                          color: Colors.white70,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context, rootNavigator : true).pushNamed('/camerastack');
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.camera_alt,
                                    size: 80, color: Colors.purple),
                                Text('camera', style: TextStyle(fontSize: 20))
                              ]),
                          color: Colors.white70,
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          fromAbout = await Navigator.pushNamed(
                              context, 'homestack/about', arguments: {
                            'email': 'codingThailand@gmail.com',
                            'phone': '08888888'
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.person,
                                    size: 80, color: Colors.purple),
                                Text('about ${fromAbout ?? ''}',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 20))
                              ]),
                          color: Colors.white70,
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          Navigator.pushNamed(context, 'homestack/room');
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.room,
                                    size: 80, color: Colors.purple),
                                Text('room',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 20))
                              ]),
                          color: Colors.white70,
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          Navigator.of(context, rootNavigator : true).pushNamed('/customer');
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.person_pin,
                                    size: 80, color: Colors.purple),
                                Text('customer',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 20))
                              ]),
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ))
              ]
            )
        ),
    );
  }
}
