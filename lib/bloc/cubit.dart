import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite_app/database/database.dart';
import 'package:sqflite_app/database/shared_preferences_controller.dart';
import '../models/notes.dart';
import '../services/notification_services.dart';
import 'app_states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitLogin());

  static AppCubit get(context) => BlocProvider.of(context);

  bool isDarkMoodEnable = false;
  bool model = (SharedPreferencesController.getData(key: "mood") == null)
      ? true
      : SharedPreferencesController.getData(key: "mood");

  // void changMood(value) {
  //   model = value;
  //   SharedPreferencesController.setData(key: "mood", value: model).then((
  //       value) {
  //     emit(Mood());
  //   });
  //   print('l mood is $model');
  // }
  void changMood( value) {
    model = value;
    SharedPreferencesController.setData(key: "mood", value: model).then((
        value) {
      emit(Mood());
    });
    print('l mood is $model');
  }



  DateTime selectedData = DateTime.now();

  void changSelectedDate(DateTime date) {
    selectedData = date;
    emit(ChangSelectedDate());
    print('l mood is $model');
  }

  DataBase db = DataBase();

  createDataBase() async {
    await db.initDB();
    emit(ScCreateDB());
  }

  NotifyHelper notifyHelper = NotifyHelper();

  initializeNotification(BuildContext context) async {
    await notifyHelper.initializeNotification(context);
    notifyHelper.requestIOSPermissions();
    emit(ScInitNots());
  }

  List<Note> noteList = [Note()];

  getNote() async {
    emit(LoadingGetTasks());
    noteList = [];
    List<Map<dynamic, dynamic>> notes = await db.getTableDataFromDb();
    for (var element in notes) {
      Note n = Note.fromJason(element);
      noteList.add(n);
    }
    emit(ScGetTasks());
  }

  Future<int> addNote(Note n) async {
    int id = await n.insertMeToDb();
    emit(ScAddTask());
    return id;
  }

  void deleteNote(Note note) async {
    db.deleteItemFromDB(note.id!);
    noteList.remove(note);
    emit(ScRemoveTask());
  }

  void updateNote(Note n) async {
    await db.update(n);
    await notifyHelper.cancelNotification(n);
    if (noteList.contains(n)) {
      int i = noteList.indexOf(n);
      noteList[i].isCompleted = 1;
    }
    emit(ScUpdateTask());
  }

  Future<void> deleteAllNote() async {
    db.deleteAll();
    await notifyHelper.cancelAllNotification();
    noteList = [];
    emit(ScRemoveAllTask());
  }
  bool showNote(Note task) {
    return (task.repeat == "Daily" ||
        DateFormat.yMd().format(selectedData) == task.date ||
        (task.repeat == "weekly" &&
            selectedData
                .difference(DateFormat.yMd().parse(task.date!))
                .inDays %
                7 ==
                0) ||
        (task.repeat == "Monthly" &&
            DateFormat
                .yMd()
                .parse(task.date!)
                .day == selectedData.day));
  }

  saveAnddisplayNotification(Note t) {
    noteList.add(t);
    var d = DateFormat.yMd().parse(t.date!);
    notifyHelper.displayNotification(
        title: t.title!, body: t.note!, startTime: t.startTime);
    notifyHelper.scheduledNotification(d.hour, d.minute, t);
    emit(SaveAndDisplayNotification());
  }
}