import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutteronline/pages/CameraStact.dart';
import 'package:flutteronline/pages/CustomerPage.dart';
import 'package:flutteronline/pages/HomeStact.dart';
import 'package:flutteronline/pages/LoginPage.dart';
import 'package:flutteronline/pages/MapPage.dart';
import 'package:flutteronline/pages/NewsStact.dart';
import 'package:flutteronline/pages/ProductStact.dart';
import 'package:flutteronline/pages/RegisterPage.dart';
import 'package:flutteronline/redux/appReducer.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutteronline/pages/BarcodePage.dart';

//redux
import 'package:redux/redux.dart';

String token;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  token = prefs.getString('token');

  final store = Store<AppState>(
    appReducer,
    initialState: AppState.initial(),
    middleware: [thunkMiddleware],
  );

  runApp(MyApp(store: store));
}

class MyApp extends StatelessWidget {
  final Store<AppState>store;

  MyApp({this.store});
  
  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
          title: 'CodingThailand',
          theme: ThemeData(
            
            primaryColor: Colors.purple,
            accentColor: Colors.purpleAccent,
            canvasColor: Colors.purple[50],
            textTheme: TextTheme(
              headline1: TextStyle(color: Colors.green, fontSize: 50),
              
            ),
            
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          //home: HomePage(),
          initialRoute: '/',
          routes: {
            //'/': (context) => HomeStack(),
            '/': (context) => token == null ? LoginPage() : HomeStack(),
            '/register': (context) => RegisterPage(),
            '/login' : (context) => LoginPage(),
            '/homestack' : (context) => HomeStack(),
            '/productstack' : (context) => ProductStack(),
            '/newsstack' : (context) => NewsStack(),
            '/customer' : (context) => CustomerPage(),
            '/camerastack' : (context) => CameraStack(),
            '/barcode' : (context) => BarcodePage(),
            '/map' : (context) => MapPage()
            
            
          },
          debugShowCheckedModeBanner: false,
      ),
    );
  }
}

