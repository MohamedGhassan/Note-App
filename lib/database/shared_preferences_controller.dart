import 'package:shared_preferences/shared_preferences.dart';


class SharedPreferencesController {
  static late SharedPreferences shared;
  static init() async{
    shared = await SharedPreferences.getInstance();
  }

  static Future<bool> setData({
    required String key,
    required dynamic value
  }) async{
    if(value is String) return shared.setString(key, value);
    if(value is int) return shared.setInt(key, value);
    if(value is bool) return shared.setBool(key, value);
    return shared.setString(key, value);
  }

  static dynamic getData({
    required String key,
  }) {
    return shared.get(key);
  }
  static Future<bool>removeData({
    required String key
  }) {
    return shared.remove(key);
  }

  String get locale {
    return shared.getString('locale') ?? 'en';
  }

  static Future setLocale(String locale) async {
    await shared.setString('locale', locale);
  }

  // bool model = (SharedPreferencesController.getData(key: "mood") == null)
  //     ? true
  //     : SharedPreferencesController.getData(key: "mood");
  //
  // void changMood(value) {
  //   print("HELLLLLLLLLO");
  //   model = value;
  //   SharedPreferencesController.setData(key: "mood", value: model).then((value) {
  //     print("SUCCESS");
  //   });
  //   print('l mood is $model');
  // }
}












// import 'package:shared_preferences/shared_preferences.dart';
//
// class SharedPreferencesController {
//   SharedPreferencesController._() {
//     initSharedPreferences();
//   }
//
//   static SharedPreferencesController? _instance;
//   static late SharedPreferences _sharedPreferences;
//
//   static SharedPreferencesController? get instance {
//     if (_instance != null) {
//       print("Instance: Created Before");
//       return _instance;
//     }
//     print("Instance: First Time");
//     _instance = SharedPreferencesController._();
//     return _instance;
//   }
//
//   Future initSharedPreferences() async {
//     _sharedPreferences = await SharedPreferences.getInstance();
//   }
//
//   String get locale {
//     return _sharedPreferences.getString('locale') ?? 'en';
//   }
//
//   Future setLocale(String locale) async {
//     await _sharedPreferences.setString('locale', locale);
//   }
//
//   static Future<bool?> setData({required String key, required dynamic value}) async{
//     if(value is String) return _sharedPreferences.setString(key, value);
//     if(value is int) return _sharedPreferences.setInt(key, value);
//     if(value is bool) return _sharedPreferences.setBool(key, value);
//     return _sharedPreferences.setString(key, value);
//   }
//
//   static dynamic getData({
//     required String key,
//   }) {
//     return _sharedPreferences.get(key);
//   }
//   static Future<bool>removeData({required String key}) async{
//     return _sharedPreferences.remove(key);
//   }
//
// // bool model = (SharedPreferencesController.getData(key: "mood") == null)
// //     ? true
// //     : SharedPreferencesController.getData(key: "mood");
// //
// // void changMood(value) {
// //   print("HELLLLLLLLLO");
// //   model = value;
// //   SharedPreferencesController.setData(key: "mood", value: model).then((value) {
// //     print("SUCCESS");
// //   });
// //   print('l mood is $model');
// // }
// }
