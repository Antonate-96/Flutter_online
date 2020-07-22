import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;


class RegisterPage extends StatefulWidget {
  RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  bool _autoavlidate = false;
  bool isLoading = false;

  _register(Map <String, dynamic> values) async{
    setState(() {
      isLoading = true;
    });
    //print(values);
    var url = 'https://api.codingthailand.com/api/register';
    var response = await http.post(
      url, 
      headers: {'Content-Type':'application/json'},
      body: convert.jsonEncode({
        'name' : values['name'],
        'email' : values['email'],
        'password' : values['password'],
        'dob' : values['dob'].toString().substring(0,10)
      })
    );
    if(response.statusCode == 201){
      setState(() {
        isLoading = false;
      });
      var feedback = convert.jsonDecode(response.body);
      Flushbar(
        title: '${feedback['message']}',
        message: "Already registered",
        icon: Icon(
          Icons.info_outline,
          size: 28.0,
          color: Colors.blue[300],
          ),
        duration: Duration(seconds: 3),
        leftBarIndicatorColor: Colors.blue[300],
      )..show(context);

      //back login page
      Future.delayed(Duration(seconds : 3),(){
        Navigator.pop(context);
      });

    }else{
      setState(() {
        isLoading = false;
      });
      var feedback = convert.jsonDecode(response.body);
      Flushbar(
        title: '${feedback['errors']['email'][0]}',
        message: "User already exists. Please try again.",
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('register')),
      body: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
            Colors.purple[200],
            Theme.of(context).primaryColor,
          ])),
      child: Center(
        child: SingleChildScrollView(
            child: Column(children: <Widget>[

          Padding(
            padding: EdgeInsets.all(10),
            child: FormBuilder(
              key: _fbKey,
              initialValue: {
                'name':'',
                'email': '',
                'password': '',
                'dob' :DateTime.now(),
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
                      errorStyle: TextStyle(color: Colors.white)
                    ),
                    validators: [
                      FormBuilderValidators.required(errorText: 'Fill in name'),
                    ],
                  ),
                  SizedBox(height: 20),

                  FormBuilderTextField(
                    attribute: "email",
                    maxLines: 1,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: "Email: ",
                      labelStyle: TextStyle(color: Colors.black87),
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                      errorStyle: TextStyle(color: Colors.white)
                    ),
                    validators: [
                      FormBuilderValidators.required(errorText: 'Fill in information'),
                      FormBuilderValidators.email(errorText: 'Invalid email'),
                    ],
                  ),
                  SizedBox(height: 20),

                  FormBuilderTextField(
                    attribute: "password",
                    maxLines: 1,
                    obscureText: true,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: "Password: ",
                      labelStyle: TextStyle(color: Colors.black87),
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                      errorStyle: TextStyle(color: Colors.white)
                    ),
                    validators: [
                      FormBuilderValidators.required(errorText: 'Fill in password'),
                      FormBuilderValidators.minLength(3,errorText: 'Invalid password'),
                    ],
                  ),
                  SizedBox(height: 20),

                  FormBuilderDateTimePicker(
                    attribute: "dob",
                    inputType: InputType.date,
                    format: DateFormat("yyyy-MM-dd"),
                    decoration:
                        InputDecoration(
                          labelText: "Appointment Time",
                          labelStyle: TextStyle(color: Colors.black87),
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                        ),
                  ),


                  SizedBox(height: 30),

                  SizedBox(
                    width: 200,
                    child: RaisedButton(
                      onPressed: (){
                        if (_fbKey.currentState.saveAndValidate()) {
                          //print(_fbKey.currentState.value);
                          _register(_fbKey.currentState.value);
                        }else{
                          setState(() {
                            _autoavlidate = true;
                          });
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                        Text('register', style: TextStyle(fontSize: 20, color: Colors.white)),
                        isLoading == true ? CircularProgressIndicator() : Text(''),
                      ],),
                      padding: EdgeInsets.all(30),
                      color: Colors.deepPurple,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    ),
                  ),

                  SizedBox(height: 20),
                  

                ],
              ),
            ),
          ),
        ])),
      ),
    ));
  }
}
