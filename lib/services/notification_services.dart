import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../models/notes.dart';
import '../ui/screen/notification_screen.dart';

class NotifyHelper {
  late BuildContext context;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  String selectedNotificationPayload = '';

  final BehaviorSubject<String> selectNotificationSubject =
      BehaviorSubject<String>();

  initializeNotification(BuildContext context) async {
    this.context = context;
    tz.initializeTimeZones();
    _configureSelectNotificationSubject();
    await _configureLocalTimeZone();
    // await requestIOSPermissions(flutterLocalNotificationsPlugin);
    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@drawable/ic_flutter_notification');

    final InitializationSettings initializationSettings =
        InitializationSettings(
      iOS: initializationSettingsIOS,
      android: initializationSettingsAndroid,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: (String? payload) async {
        if (payload != null) {
          debugPrint('notification payload: ' + payload);
        }
        selectNotificationSubject.add(payload!);
      },
    );
  }

  displayNotification(
      {required String title, required String body, required startTime}) async {
    print('doing test');
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
        'your channel id', 'your channel name',
        channelDescription: 'your channel description',
        importance: Importance.max,
        priority: Priority.high);
    var iOSPlatformChannelSpecifics = const IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: '$title|$body|$startTime',
    );
  }

  cancelNotification(Note t) async {
    await flutterLocalNotificationsPlugin.cancel(t.id!);
    print("task ${t.id} canceld");
  }

  cancelAllNotification() async {
    await flutterLocalNotificationsPlugin.cancelAll();
    print("all task  canceld");
  }

  scheduledNotification(Note task) async {
    print('payload is ${task.title}|${task.note}|${task.startTime}');
    await flutterLocalNotificationsPlugin.zonedSchedule(
      task.id!,
      task.title,
      task.note,
      //tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
      _nextInstanceOfTenAM(task.remind!, task.repeat!, task.date!),
      const NotificationDetails(
        android: AndroidNotificationDetails(
            'your channel id', 'your channel name',
            channelDescription: 'your channel description',
            icon: '@drawable/ic_flutter_notification'),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
      payload: '${task.title}|${task.note}|${task.startTime}|',
    );
  }

  tz.TZDateTime _nextInstanceOfTenAM(int remind, String repeat, String date) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    print("now = $now");
    var fd = DateFormat.yMd().parse(date);
    final tz.TZDateTime nfd = tz.TZDateTime.from(fd, tz.local);
    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, nfd.year, nfd.month, nfd.day);
    print("scheduledDate = $scheduledDate");

    scheduledDate = afterRemind(remind, scheduledDate);

    if (scheduledDate.isBefore(now)) {
      if (repeat == "Daily") {
        scheduledDate =
            tz.TZDateTime(tz.local, now.year, now.month, fd.day + 1);
      }
      if (repeat == "weekly") {
        scheduledDate =
            tz.TZDateTime(tz.local, now.year, now.month, fd.day + 7);
      }
      if (repeat == "Monthly") {
        scheduledDate =
            tz.TZDateTime(tz.local, now.year, (now.month) + 1, fd.day);
      }
      scheduledDate = afterRemind(remind, scheduledDate);
    }

    print("next scheduledDate = $scheduledDate");
    return scheduledDate;
  }

  tz.TZDateTime afterRemind(int remind, tz.TZDateTime scheduledDate) {
    if (remind == 5) {
      scheduledDate = scheduledDate.add(const Duration(minutes: 5));
    }
    if (remind == 10) {
      scheduledDate = scheduledDate.add(const Duration(minutes: 10));
    }
    if (remind == 15) {
      scheduledDate = scheduledDate.add(const Duration(minutes: 15));
    }
    if (remind == 20) {
      scheduledDate = scheduledDate.add(const Duration(minutes: 20));
    }
    return scheduledDate;
  }

  void requestIOSPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();
    final String timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));
  }

/*   Future selectNotification(String? payload) async {
    if (payload != null) {
      //selectedNotificationPayload = "The best";
      selectNotificationSubject.add(payload);
      print('notification payload: $payload');
    } else {
      print("Notification Done");
    }
    Get.to(() => SecondScreen(selectedNotificationPayload));
  } */

//Older IOS
  Future onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    showDialog(
        context: context,
        builder: (context) => Dialog(
              backgroundColor: Colors.red,
              child: Text(body!),
            ));
    //Get.dialog( Text(body!));
  }

  void _configureSelectNotificationSubject() {
    selectNotificationSubject.stream.listen((String payload) async {
      debugPrint('My payload is ' + payload);
      await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => NotificationScreen(payload: payload)));
      //Get.to(() => NotificationScreen(payload:payload));
    });
  }
}
