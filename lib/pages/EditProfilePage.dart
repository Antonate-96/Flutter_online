import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutteronline/redux/appReducer.dart';
import 'package:flutteronline/redux/profile/profileAction.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:flushbar/flushbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfilePage extends StatefulWidget {
  EditProfilePage({Key key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  bool _autoavlidate = false;
  bool isLoading = false;
  SharedPreferences prefs;

  _initPrefs() async{
    prefs = await SharedPreferences.getInstance();
  }

  @override
  void initState() { 
    super.initState();
    _initPrefs();
  }

  _updateProfile(Map <String, dynamic> values) async{
    setState(() {
      isLoading = true;
    });
    //print(values);

    //get token
    var tokenString = prefs.getString('token');
    var token = convert.jsonDecode(tokenString);

    var url = 'https://api.codingthailand.com/api/editprofile';
    var response = await http.post(url, 
      headers: {
        'Content-Type':'application/json',
        'Authorization':'Bearer  ${token['access_token']}'
      },
      body: convert.jsonEncode({
        'name' : values['name'],
        
      })
    );
    if(response.statusCode == 200){
      setState(() {
        isLoading = false;
      });

      //get profile to prefs
      var profile = response.body;
      await _saveProfile(profile);


      //goto home page
      //Navigator.pushNamedAndRemoveUntil(context, 'homestack/home', (Route<dynamic> route) => false);
      

    }else{
      setState(() {
        isLoading = false;
      });
      var feedback = convert.jsonDecode(response.body);
      Flushbar(
        title: '${feedback['message']}',
        message: 'An error has occurred from the system. ${feedback['status_code']}',
        backgroundColor: Colors.redAccent,
        icon: Icon(
          Icons.error,
          size: 28.0,
          color: Colors.blue[300],
          ),
        duration: Duration(seconds: 3),
        leftBarIndicatorColor: Colors.white,
      )..show(context);
    }

  }

  Future<void> _saveProfile(String profile) async{
    
    //save user profile to prefs
    var profileUpdate = convert.jsonDecode(profile);
    await prefs.setString('profile', convert.jsonEncode(profileUpdate['data']['user']));

    //call action
    final store = StoreProvider.of<AppState>(context);
    store.dispatch(getProfileAction(profileUpdate['data']['user']));



  }

  @override
  Widget build(BuildContext context) {
    Map user = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(title: Text('edit profile')),
      body: SingleChildScrollView(
            child: Column(children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(10, 40, 10, 10),
            child: FormBuilder(
              key: _fbKey,
              initialValue: {
                'name': user['name'],
              },
              autovalidate: _autoavlidate,
              child: Column(
                children: <Widget>[
                  FormBuilderTextField(
                    attribute: "name",
                    maxLines: 1,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: "Name: ",
                      labelStyle: TextStyle(color: Colors.black87),
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                      errorStyle: TextStyle(color: Colors.red)
                    ),
                    validators: [
                      FormBuilderValidators.required(errorText: 'Fill in name'),
                    ],
                  ),

                  SizedBox(height: 30),

                  SizedBox(
                    width: 200,
                    child: RaisedButton(
                      onPressed: (){
                        if (_fbKey.currentState.saveAndValidate()) {
                          _updateProfile(_fbKey.currentState.value);
                        }else{
                          setState(() {
                            _autoavlidate = true;
                          });
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                        Text('update', style: TextStyle(fontSize: 20, color: Colors.white)),
                        isLoading == true ? CircularProgressIndicator() : Text(''),
                      ],),
                      padding: EdgeInsets.all(30),
                      color: Colors.deepPurple,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ])),
    );
  }
}