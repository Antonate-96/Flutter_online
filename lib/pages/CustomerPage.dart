import 'package:flutter/material.dart';
import 'package:flutteronline/utils/database.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:sqflite/sqflite.dart';

class CustomerPage extends StatefulWidget {
  CustomerPage({Key key}) : super(key: key);

  @override
  _CustomerPageState createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {
  List<Map> customers = [];
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  bool _autoavlidate = false;
  DBHelper dbHelper;
  Database db;

  _getCustomer() async {
    db = await dbHelper.db;
    var cust = await db.rawQuery('SELECT * FROM customers ORDER BY id DESC');
    setState(() {
      customers = cust;
    });
  }

  _insertCustomer(Map values) async {
    db = await dbHelper.db;
    await db
        .rawInsert('INSERT INTO customers (name) VALUES (?)', [values['name']]);
    _getCustomer();
  }

  _updateCustomer(int id, Map values) async {
    db = await dbHelper.db;
    await db.rawUpdate(
        'UPDATE customers SET name=? WHERE id=?', [values['name'], id]);
    _getCustomer();
  }

  _deleteCustomer(int id) async {
    db = await dbHelper.db;
    await db.rawDelete('DELETE FROM customers WHERE id=?', [id]);
    _getCustomer();
  }

  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper();
    _getCustomer();
  }

  _insertFrom() {
    Alert(
        context: context,
        title: "add infromation",
        closeFunction: () {},
        content: Column(
          children: <Widget>[
            FormBuilder(
              key: _fbKey,
              initialValue: {
                'name': '',
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
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        errorStyle: TextStyle(color: Colors.red)),
                    validators: [
                      FormBuilderValidators.required(errorText: 'Fill in name'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        buttons: [
          DialogButton(
            onPressed: () {
              if (_fbKey.currentState.saveAndValidate()) {
                //print(_fbKey.currentState.value);
                _insertCustomer(_fbKey.currentState.value);
                Navigator.of(context).pop();
              } else {
                setState(() {
                  _autoavlidate = true;
                });
              }
            },
            child: Text(
              "add infromation",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }

  _updateFrom(int id, String name) {
    Alert(
        context: context,
        title: "edit",
        closeFunction: () {},
        content: Column(
          children: <Widget>[
            FormBuilder(
              key: _fbKey,
              initialValue: {
                'name': '$name',
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
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        errorStyle: TextStyle(color: Colors.red)),
                    validators: [
                      FormBuilderValidators.required(errorText: 'Fill in name'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        buttons: [
          DialogButton(
            onPressed: () {
              if (_fbKey.currentState.saveAndValidate()) {
                //print(_fbKey.currentState.value);
                _updateCustomer(id, _fbKey.currentState.value);
                Navigator.of(context).pop();
              } else {
                setState(() {
                  _autoavlidate = true;
                });
              }
            },
            child: Text(
              "edit infromation",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('customer'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.person_add),
              onPressed: () {
                _insertFrom();
              },
            )
          ],
        ),
        body: ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              return Dismissible(
                child: ListTile(
                  title: Text('${customers[index]['name']}'),
                  subtitle: Text('${customers[index]['id']}'),
                ),
                key: Key(customers[index]['id'].toString()),
                background: Container(
                  color: Colors.green,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(width: 20),
                      Icon(Icons.edit, color: Colors.white),
                      Text('edit', style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
                secondaryBackground: Container(
                  color: Colors.red,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Icon(Icons.delete, color: Colors.white),
                      Text('delete', style: TextStyle(color: Colors.white)),
                      SizedBox(width: 20),
                    ],
                  ),
                ),
                confirmDismiss: (direction) async {
                  if (direction == DismissDirection.endToStart) {
                    Alert(
                      context: context,
                      type: AlertType.warning,
                      title: "confirm",
                      desc: "Sure to delete your data ${customers[index]['name']}",
                      buttons: [
                        DialogButton(
                          child: Text(
                            "yes",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                            _deleteCustomer(customers[index]['id']);
                          },
                          color: Colors.red,
                        ),
                        DialogButton(
                          child: Text(
                            "cancel",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          onPressed: () => Navigator.pop(context),
                          gradient: LinearGradient(colors: [
                            Color.fromRGBO(116, 116, 191, 1.0),
                            Color.fromRGBO(52, 138, 199, 1.0)
                          ]),
                        )
                      ],
                    ).show();
                  } else {
                    _updateFrom(customers[index]['id'], customers[index]['name']);
                  }
                  return false;
                },
              );
            },
            separatorBuilder: (BuildContext context, int index) => Divider(),
            itemCount: customers.length));
  }
}
