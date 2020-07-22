class Detail {
  String status;
  int statusCode;
  List<Chapter> chapter;

  Detail({this.status, this.statusCode, this.chapter});

  Detail.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['status_code'];
    if (json['data'] != null) {
      chapter = new List<Chapter>();
      json['data'].forEach((v) {
        chapter.add(new Chapter.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['status_code'] = this.statusCode;
    if (this.chapter != null) {
      data['data'] = this.chapter.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Chapter {
  int chId;
  int courseId;
  String chTitle;
  String chDateadd;
  String chTimetotal;
  int chView;
  String chUrl;

  Chapter(
      {this.chId,
      this.courseId,
      this.chTitle,
      this.chDateadd,
      this.chTimetotal,
      this.chView,
      this.chUrl});

  Chapter.fromJson(Map<String, dynamic> json) {
    chId = json['ch_id'];
    courseId = json['course_id'];
    chTitle = json['ch_title'];
    chDateadd = json['ch_dateadd'];
    chTimetotal = json['ch_timetotal'];
    chView = json['ch_view'];
    chUrl = json['ch_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ch_id'] = this.chId;
    data['course_id'] = this.courseId;
    data['ch_title'] = this.chTitle;
    data['ch_dateadd'] = this.chDateadd;
    data['ch_timetotal'] = this.chTimetotal;
    data['ch_view'] = this.chView;
    data['ch_url'] = this.chUrl;
    return data;
  }
}
