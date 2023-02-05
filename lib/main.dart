import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite_app/bloc/cubit.dart';
import 'package:sqflite_app/bloc/observer.dart';
import 'package:sqflite_app/database/shared_preferences_controller.dart';
import 'package:sqflite_app/ui/screen/notes_screen.dart';
import 'package:sqflite_app/ui/theme.dart';

import 'bloc/app_states.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesController.init();

  BlocOverrides.runZoned((){ runApp(const MainApp(),);
  }, blocObserver: MyBlocObserver());
}
final navigatorKey = GlobalKey<NavigatorState>();
class MainApp extends StatefulWidget {
  static void changeLocale(BuildContext context, Locale locale)
  {
    _MainAppState? state = context.findAncestorStateOfType<_MainAppState>();
    state?.changeLocale(locale);
  }
  const MainApp({Key? key}) : super(key: key);

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {

  late Locale _locale;
  void changeLocale(Locale locale){
    setState(() {
      _locale = locale;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Intl.defaultLocale ??= "en";
    _locale = Locale(Intl.defaultLocale!);
    print("_locale ${Intl.defaultLocale}");

    SharedPreferences.getInstance().then((value)
    {
      String locale = value.getString('locale')!;
      if(locale == null)
      {
        value.setString('locale', "en");
      }
      Intl.defaultLocale = locale ?? "en";
      _locale = Locale(locale ?? "en");
      print("Locale: $locale");
    });
  }
  // @override

  Widget build(BuildContext context) {
    return  BlocProvider(
      create:  (ctx) =>AppCubit()..createDataBase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder:(context, state) {
          AppCubit cubit=AppCubit.get(context);
          return MaterialApp(
            theme:Themes.light,
            darkTheme: Themes.dark,
            themeMode: cubit.model? ThemeMode.light :ThemeMode.dark ,
            title: 'TODO',
            debugShowCheckedModeBanner: false,
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: [
              const Locale('en', ''), // English, no country code
              const Locale('ar', ''), // Arabic, no country code
            ],
            locale: _locale,
            home: const NotesScreen(),
          );
        },
      ),
    );
  }
}
/*
class MainApp extends StatefulWidget {
  static void changeLocale(BuildContext context, Locale locale) {
    _MainAppState? state = context.findAncestorStateOfType<_MainAppState>();
    state?.changeLocale(locale);
  }

  // static void changeMood(BuildContext context, Locale locale) {
  //   _MainAppState? state = context.findAncestorStateOfType<_MainAppState>();
  //   state?.changeMood(model);
  // }

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  Locale? _locale;

  void changeLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  bool? mdl;
  void changeMood(bool mdl) {
    setState(() {
      mdl = mdl;
    });
  }

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((value) {
      String locale = value.getString('locale')!;
      if (locale == null) {
        value.setString('locale', 'en');
      }
      Intl.defaultLocale = locale ?? 'en';
      _locale = Locale(locale ?? 'en');
      print('Locale: $locale');
    });
    print("Local: ${Intl.defaultLocale}");
  }

  @override
  Widget build(BuildContext context) {
  return BlocProvider(
      create: (context) => AppCubit(),
      child: MaterialApp(
        theme: Themes.light,
        darkTheme: Themes.dark,
        themeMode: model ? ThemeMode.dark : ThemeMode.light,
        //     ? ThemeMode.light
        //     : ThemeMode.dark,
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          Locale('en', ''), // English, no country code
          Locale('ar', ''), // Spanish, no country code
        ],
        locale: _locale,
        debugShowCheckedModeBanner: false,
        initialRoute: '/CreateNoteScreen',
        routes: {
          '/notes_screen': (context) => NotesScreen(),
          '/CreateNoteScreen': (context) => CreateNoteScreen()
        },
        title: 'Flutter Demo',
      ),
    );
  }
}
*/
////////////////////////////////////////////////////////////////////////////////
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:intl/intl.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:sqflite_app/bloc/cubit.dart';
// import 'package:sqflite_app/database/shared_preferences_controller.dart';
// import 'package:sqflite_app/ui/screen/create_note_screen.dart';
// import 'package:sqflite_app/ui/screen/notes_screen.dart';
// import 'package:sqflite_app/ui/theme.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await SharedPreferencesController.instance!.initSharedPreferences();
//   runApp(MainApp());
// }
//
// class MainApp extends StatefulWidget {
//   static void changeLocale(BuildContext context, Locale locale) {
//     _MainAppState? state = context.findAncestorStateOfType<_MainAppState>();
//     state?.changeLocale(locale);
//   }
//
//   // static void changeMood(BuildContext context, Locale locale) {
//   //   _MainAppState? state = context.findAncestorStateOfType<_MainAppState>();
//   //   state?.changeMood(model);
//   // }
//
//   @override
//   _MainAppState createState() => _MainAppState();
// }
//
// class _MainAppState extends State<MainApp> {
//   Locale? _locale;
//
//   void changeLocale(Locale locale) {
//     setState(() {
//       _locale = locale;
//     });
//   }
//
//   bool? mdl;
//   void changeMood(bool mdl) {
//     setState(() {
//       mdl = mdl;
//     });
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     SharedPreferences.getInstance().then((value) {
//       String locale = value.getString('locale')!;
//       if (locale == null) {
//         value.setString('locale', 'en');
//       }
//       Intl.defaultLocale = locale ?? 'en';
//       _locale = Locale(locale ?? 'en');
//       print('Locale: $locale');
//     });
//     print("Local: ${Intl.defaultLocale}");
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => AppCubit(),
//       child: MaterialApp(
//         theme: Themes.light,
//         darkTheme: Themes.dark,
//         themeMode: model ? ThemeMode.dark : ThemeMode.light,
//         //     ? ThemeMode.light
//         //     : ThemeMode.dark,
//         localizationsDelegates: [
//           AppLocalizations.delegate,
//           GlobalMaterialLocalizations.delegate,
//           GlobalWidgetsLocalizations.delegate,
//           GlobalCupertinoLocalizations.delegate,
//         ],
//         supportedLocales: [
//           Locale('en', ''), // English, no country code
//           Locale('ar', ''), // Spanish, no country code
//         ],
//         locale: _locale,
//         debugShowCheckedModeBanner: false,
//         initialRoute: '/notes_screen',
//         routes: {
//           '/notes_screen': (context) => NotesScreen(),
//           '/CreateNoteScreen': (context) => CreateNoteScreen()
//         },
//         title: 'Flutter Demo',
//       ),
//     );
//   }
// }

