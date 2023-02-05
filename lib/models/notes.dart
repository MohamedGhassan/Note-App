
import '../database/database.dart';

class Note {
  int? id;
  String? title;
  String? note;
  int? isCompleted;
  String? date;
  String? startTime;
  String? endTime;
  int? color;
  int? remind;
  String? repeat;
  DataBase db = DataBase();
  Note(
      {this.id,
        this.color,
        this.date,
        this.endTime,
        this.isCompleted,
        this.note,
        this.remind,
        this.repeat,
        this.startTime,
        this.title});
  Note.fromJason(Map<dynamic, dynamic> task) {
    id = task["id"] as int;
    color = task["color"] as int;
    remind = task["remind"] as int;
    isCompleted = task["isCompleted"] as int;
    repeat = task["repeat"].toString();
    title = task["title"].toString();
    note = task["note"].toString();
    date = task["date"].toString();
    endTime = task["endTime"].toString();
    startTime = task["startTime"].toString();
  }
  Map<String, dynamic> toJson(){
    final Map<String , dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["color"] = this.color;
    data["remind"] = this.remind;
    data["isCompleted"] = this.isCompleted;
    data["repeat"] = this.repeat;
    data["title"] = this.title;
    data["note"] = this.id;
    data["date"] = this.date;
    data["endTime"] = this.endTime;
    data["startTime"] = this.startTime;
    return data;
  }
  Map<String, Object> toMap() {
    return {
      "color": color!,
      "date": date!,
      "endTime": endTime!,
      "isCompleted": isCompleted!,
      "note": note!,
      "remind": remind!,
      "repeat": repeat!,
      "startTime": startTime!,
      "title": title!,
    };
  }

  Future<int> insertMeToDb() async {
    return await db.insertPersonDataToDB(this);
  }

  void setId(int id) {
    this.id = id;
  }
}



// class Note{
//    String? title;
//    String? details;
//    int? id;
//
//
//   Note({this.title, this.details, this.id});
//
//   /// هان بحول Map ل المودل
//   Note.fromMap(Map<String, dynamic> map){
//     ///بالنسبة لid هيساوي أشي اسمه id في map وهكذا...
//     id = map['id'];
//     title = map ['title'];
//     details = map['details'];
//
//   }
//   /// وهان بحول المودل لMap
//   Map<String, dynamic> toMap({withId = false}){
//     Map<String, dynamic> map = Map<String, dynamic>();
//     ///ماب key id بساوي متغير id
//     if(withId) map['id'] = id;
//     map['title'] = title;
//     map['details'] = details;
//     return map;
//   }
// }