import 'package:flutter/material.dart';
import 'package:flutteronline/models/room.dart';
import 'package:flutteronline/widgets/menu.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class RoomPage extends StatefulWidget {
  RoomPage({Key key}) : super(key: key);

  @override
  _RoomPageState createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage> {
  List<Room> room = [];
  bool isLoading = true;

  _getData() async{
    var url = 'https://codingthailand.com/api/get_rooms.php';
    var response = await http.get(url);
    if(response.statusCode == 200){
      //print(response.body);
      final Hotel hotel=  Hotel.fromJson(convert.jsonDecode(response.body));
      setState(() {
        room = hotel.room;
        isLoading = false;
      });
    }else{
      //error 400,500
      print('error from backend ${response.statusCode}');
    }
  }

  @override
  void initState() { 
    super.initState();
    _getData();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Menu(),
      appBar: AppBar(
        centerTitle: true,
        title: Text('room')
      ),
      body: isLoading == true ?  
        Center(
          child: CircularProgressIndicator(), 
        ) : ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(room[index].name),
            subtitle: Text(room[index].status),
          );
        },
        separatorBuilder: (BuildContext context, int index) => Divider(), 
        itemCount: room.length
        )
    );
  }
}
