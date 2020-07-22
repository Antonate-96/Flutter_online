import 'package:flutter/material.dart';
import 'package:flutteronline/widgets/menu.dart';
import 'package:barcode_scan/barcode_scan.dart';


class BarcodePage extends StatefulWidget{
  BarcodePage({Key key }) : super(key: key);

  @override
  _BarcodePageState createState() => _BarcodePageState();
}
class _BarcodePageState extends State<BarcodePage> {
String resultScan;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Barcode/QR code'),
      ),
      drawer: Menu(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('result : $resultScan'),
            RaisedButton(
              child: Text('Scan'),
              onPressed: ()  async{
                
                var result = await BarcodeScanner.scan();
                setState(() {
                  resultScan = result.rawContent;
                });
              }
            )
          ],
        ),
      ),
    );
  }
}