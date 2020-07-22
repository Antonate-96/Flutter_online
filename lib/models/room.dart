class Hotel {
  List<Room> room;
  

  Hotel({this.room});

  Hotel.fromJson(List<dynamic> json) {
    if (json != null) {
      room = new List<Room>();
      json.forEach((v) {
        room.add(new Room.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.room != null) {
      data['data'] = this.room.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Room {
  String id;
  String name;
  String status;

  Room({this.id, this.name, this.status});

  Room.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['status'] = this.status;
    return data;
  }
}