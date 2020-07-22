import 'package:flutter/material.dart';

class Footer extends StatefulWidget {
  Footer({Key key}) : super(key: key);

  @override
  _FooterState createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  String companyName = 'CCT';

  void _changeCompanyName(){
    setState(() {
      companyName = 'Flutter';
    });
 
    
  }
  @override
    void initState() { 
      super.initState();
      print('init footer');
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
      Text('$companyName', style: Theme.of(context).textTheme.headline1,),
      RaisedButton(
        onPressed: _changeCompanyName ,
        child: Text('Click!!'),
      )
    ]);
  }
}