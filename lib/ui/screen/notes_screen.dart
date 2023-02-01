import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:sqflite_app/bloc/app_states.dart';
import 'package:sqflite_app/ui/screen/create_note_screen.dart';
import '../../bloc/cubit.dart';
import '../../database/shared_preferences_controller.dart';
import '../../main.dart';
import '../../models/notes.dart';
import '../size_config.dart';
import '../theme.dart';
import '../widgets/button.dart';
import '../widgets/home_widget.dart';
import '../widgets/task_tile.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({Key? key}) : super(key: key);

  // List<Note> _notes = [];
  // Future<List<Note>>? futureNotes;
  // bool isAllDeleted = false;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    AppCubit cubit = AppCubit.get(context);
    return BlocProvider(
      create: (context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          if (state is ScCreateDB) {
            cubit.initializeNotification(context);
            cubit.getNote();
          }
        },
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
              // color: !cubit.model ? Colors.white : Colors.black,
              /// علامة التعجب بحطها عشان اعكس الشرط تاع المودل
              backgroundColor: !cubit.model
                  ? Theme.of(context).backgroundColor
                  : Colors.white,
              appBar: appBar(context),
              body: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    addTaskBar(context),
                    addDateBar(context),
                    const SizedBox(
                      height: 10,
                    ),
                    showTasks(context),
                  ],
                ),
              ));
        },
      ),
    );
  }
}

AppBar appBar(context) {
  AppCubit cubit = AppCubit.get(context);
  return AppBar(
    elevation: 0.0,
    // color: !cubit.model ? Colors.white : Colors.black,
    backgroundColor:
        !cubit.model ? Theme.of(context).backgroundColor : Colors.white,
    leading: InkWell(
      onTap: ()
      {
        cubit.changMood(!cubit.model);
      },
      child: DayNightSwitcherIcon(
        isDarkModeEnabled: cubit.model,
        onStateChanged: cubit.changMood
      ),
    ),
    // IconButton(
    //   color: cubit.model ? darkHeaderClr : Colors.white,
    //   icon: Icon(
    //     !cubit.model
    //         ? Icons.wb_sunny_outlined
    //         : Icons.nightlight_round_outlined,
    //     size: 24,
    //   ),
    //   onPressed: () {
    //     cubit.changMood(!cubit.model);
    //   },
    // ),
    actions: [
      /// علامة التعجب بحطها عشان اعكس الشرط تاع المودل
      IconButton(
        color: cubit.model ? darkHeaderClr : Colors.white,
        icon: const Icon(
          Icons.cleaning_services_outlined,
          size: 24,
        ),
        onPressed: () {
          showDialog(
              barrierDismissible: true,
              context: context,
              builder: (BuildContext ctx) {
                return AlertDialog(
                  title: const Text(
                    "Remove All Notes",
                    style: TextStyle(color: Colors.white),
                  ),
                  content: const Text(
                    "Are you sure you want to delete all notes?",
                    style: TextStyle(color: Colors.white),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        cubit.deleteAllNote();
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "YES",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "NO",
                        style: TextStyle(color: Colors.green),
                      ),
                    ),
                  ],
                );
              });
        },
      ),
      IconButton(
          color: cubit.model ? darkHeaderClr : Colors.white,
          icon: const Icon(Icons.language),
          onPressed: () {
            String newLocale =
            Intl.defaultLocale == 'en' ? 'ar' : 'en';
            SharedPreferencesController.setLocale(newLocale);
            MainApp.changeLocale(context, Locale(newLocale));
            print('${Intl.defaultLocale}');
          }),
      const Padding(
        padding: EdgeInsets.all(10.0),
        child: CircleAvatar(
          radius: 18,
          backgroundImage: AssetImage(
            "assets/images/person.jpg",
          ),
        ),
      ),
    ],
  );
}

Widget addTaskBar(context) {
  AppCubit cubit = AppCubit.get(context);
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween, /// ما بتفرق لو حذفتها
    crossAxisAlignment: CrossAxisAlignment.end, /// ما بتفرق لو حذفتها
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text(
          //   /// هاد بجيب نفس الي تحت لكن بجيب اول 3 احرف من اسم الشهر
          //   ///YMd لو بدي ما يجيبلي اسم الشهر بس يجيبلي ارقام(اليوم والشهر والسنه) بحطله بس
          //   //DateFormat.yMMMd().format(cubit.selectData),
          //
          //   "${DateFormat.yMMMMd().format(cubit.selectedData)}",
          //   // style: Themes.titleStyle,
          //   style: TextStyle(
          //     fontSize: 18,
          //     fontWeight: FontWeight.bold,
          //     color: !cubit.model ? Colors.white : Colors.black,
          //   ),
          // ),
          const SizedBox(
            height: 5,
          ),
          Text(
            DateFormat.yMMMMd().format(DateTime.now()),
            // style: Themes.supHeadingStyle,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: !cubit.model ? Colors.white : Colors.grey[700],
            ),
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
      const SizedBox(
        width: 10,
      ),
      DefaultButton(
        onPress: () async {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const CreateNoteScreen()));
        },
        label: "+ ${AppLocalizations.of(context)!.button}",
      ),
    ],
  );
}

Widget addDateBar(context) {
  AppCubit cubit = AppCubit.get(context);
  return Container(
    margin: const EdgeInsets.only(top: 10),
    child: DatePicker(
      DateTime.now(),
      initialSelectedDate: DateTime.now(),
      width: 80,
      height: 80,
      selectedTextColor: Colors.white,
      selectionColor: primaryClr,
      dateTextStyle:
          Themes.headingStyle.copyWith(color: Colors.grey, fontSize: 20),
      dayTextStyle:
          Themes.headingStyle.copyWith(color: Colors.grey, fontSize: 16),
      monthTextStyle:
          Themes.headingStyle.copyWith(color: Colors.grey, fontSize: 12),
      onDateChange: (DateTime newDate) {
        cubit.changSelectedDate(newDate);
      },
    ),
  );
}

// Widget noTasks(BuildContext context) {
//   AppCubit cubit = AppCubit.get(context);
//   return Stack(
//     children: [
//       AnimatedPositioned(
//         duration: const Duration(seconds: 2),
//         child: RefreshIndicator(
//           onRefresh: () async {
//             ///await
//             cubit.getNote();
//           },
//           child: SingleChildScrollView(
//             physics: const AlwaysScrollableScrollPhysics(),
//             child: Wrap(
//               direction: SizeConfig.orientation == Orientation.landscape
//                   ? Axis.horizontal
//                   : Axis.vertical,
//               //main
//               alignment: WrapAlignment.center,
//               //cross
//               crossAxisAlignment: WrapCrossAlignment.center,
//               children: [
//                 SizeConfig.orientation == Orientation.landscape
//                     ? const SizedBox(
//                         height: 6,
//                       )
//                     : const SizedBox(
//                         height: 120,
//                       ),
//                 SvgPicture.asset(
//                   "assets/images/task.svg",
//                   color: primaryClr.withOpacity(0.7),
//                   height: 100,
//                   semanticsLabel: "Task",
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 Text(
//                   "You do not have any tasks!\nAdd New tasks to make your days productive",
//                   // style: Themes.supTitleStyle,
//                   style: TextStyle(
//                     color: !cubit.model ? Colors.white : Colors.black,
//                     fontSize: 16,
//                     fontWeight: FontWeight.w400,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//                 SizeConfig.orientation == Orientation.landscape
//                     ? const SizedBox(
//                         height: 120,
//                       )
//                     : const SizedBox(
//                         height: 150,
//                       ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     ],
//   );
// }

Widget showTasks(context) {
  AppCubit cubit = AppCubit.get(context);
  return Expanded(
    child: (cubit.noteList.isEmpty)
        ? noTasks(context)
        : RefreshIndicator(
      onRefresh: () async {
        cubit.getNote();
      },
      child: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        scrollDirection: SizeConfig.orientation == Orientation.portrait
            ? Axis.vertical
            : Axis.horizontal,
        itemCount: cubit.noteList.length,
        separatorBuilder: (BuildContext context, intindix) =>
        const SizedBox(
          height: 10,
        ),
        itemBuilder: (BuildContext context, int indix) {
          Note note = cubit.noteList[indix];
          if (cubit.showNote(note)) {
            var h =
            note.startTime.toString().split(" ")[0].split(":")[0];
            var m =
            note.startTime.toString().split(" ")[0].split(":")[0];
            cubit.notifyHelper.scheduledNotification(
                int.parse(h), int.parse(m), note);
            return AnimationConfiguration.staggeredList(
              position: indix,
              duration: const Duration(seconds: 1),
              child: SlideAnimation(
                horizontalOffset: SizeConfig.screenWidth * 0.75,
                child: FadeInAnimation(
                  child: InkWell(
                    onTap: () {
                      showMyBottomSheet(context, note);
                      print("ok");
                    },
                    child: TaskTile(note: note),
                  ),
                ),
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    ),
  );
}

// import 'package:date_picker_timeline/date_picker_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:intl/intl.dart';
// import 'package:sqflite_app/bloc/cubit.dart';
// import 'package:sqflite_app/database/database.dart';
// import 'package:sqflite_app/ui/screen/create_note_screen.dart';
//
// import '../../database/shared_preferences_controller.dart';
// import '../../main.dart';
// import '../../models/notes.dart';
// import '../size_config.dart';
// import '../theme.dart';
// import 'edit_note_screen.dart';
//
// class NotesScreen extends StatefulWidget {
//
//   @override
//   State<NotesScreen> createState() => _NotesScreenState();
// }
//
// class _NotesScreenState extends State<NotesScreen> {
//   List<Note> _notes = [];
//   Future<List<Note>>? _futureNotes;
//   bool isAllDeleted = false;
//
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     ///شلتها هنا لانه instance بتنعمل مرة وحده بس وانا عاملها في main
//     // SharedPreferencesController.instance;
//     _futureNotes = NoteController.instance!.read();
//   }
//   //
//   // @override
//   // void setState(VoidCallback fn) {
//   //   // TODO: implement setState
//   //   super.setState(fn);
//   //   void changMood(value) {
//   //     model = value;
//   //     SharedPreferencesController.setData(key: "mood", value: model)
//   //         .then((value) {
//   //       print("SUCCESS");
//   //     });
//   //     print('mood is $model');
//   //   }
//   // }
//
//   // static bool model = (SharedPreferencesController.getData(key: "mood") == null)
//   //    ? true
//   //    : SharedPreferencesController.getData(key: "mood");
//
//
//   @override
//   Widget build(BuildContext context) {
//     SizeConfig().init(context);
//     // AppCubit cubit = AppCubit.get(context);
//     return BlocProvider(
//       create: (context) => AppCubit(),
//       child: Scaffold(
//         // backgroundColor: Colors.white,
//         backgroundColor: !model ? Theme.of(context).backgroundColor : Colors.white,
//         appBar: AppBar(
//           elevation: 0,
//           backgroundColor:
//           !model ? Theme.of(context).backgroundColor : Colors.white,
//           leading: IconButton(
//             color: model ? darkHeaderClr : Colors.white,
//             icon: Icon(
//               !model
//                   ? Icons.wb_sunny_outlined
//                   : Icons.nightlight_round_outlined,
//               size: 24,
//             ),
//             onPressed: () {
//               changeMood(!model);
//               // bool model = (SharedPreferencesController.getData(key: "mood") == null)
//               //     ? true
//               //     : SharedPreferencesController.getData(key: "mood");
//               // changMood(model);
//             },
//           ),
//           actions: [
//             IconButton(
//                 icon: Icon(Icons.language),
//                 onPressed: () {
//                   String newLocale = Intl.defaultLocale == 'en' ? 'ar' : 'en';
//                   SharedPreferencesController.instance!.setLocale(newLocale);
//                   MainApp.changeLocale(context, Locale(newLocale));
//                   print('${Intl.defaultLocale}');
//                 }),
//             IconButton(
//                 icon: Icon(Icons.add),
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => CreateNoteScreen(
//                         title: AppLocalizations.of(context)!.helloWorld,
//                       ),
//                     ),
//                   );
//                 }),
//           ],
//         ),
//
//         /// LANGUAGE
//         // floatingActionButton: FloatingActionButton(
//         //   child: Icon(Icons.language),
//         //   onPressed: () {
//         //     String newLocale = Intl.defaultLocale == 'en' ? 'ar' : 'en';
//         //     SharedPreferencesController.instance!.setLocale(newLocale);
//         //     MainApp.changeLocale(context, Locale(newLocale));
//         //     print('${Intl.defaultLocale}');
//         //   },
//         // ),
//         body: Column(
//           children: [
//             addTaskBar(context),
//             addDateBar(context),
//             const SizedBox(
//               height: 10,
//             ),
//             showTasks(context),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Future<bool?> deleteNote(int id, int index) async {
//     bool deleted = await NoteController.instance!.delete(id);
//     if (deleted) {
//       setState(() {
//         _notes.removeAt(index);
//         isAllDeleted = _notes.isEmpty;
//       });
//     }
//     return false;
//   }
//
//   Future getNotes() async {
//     _notes = await NoteController.instance!.read();
//     print("Notes count ${_notes.length}");
//     setState(() {});
//   }
//
//   Widget addTaskBar(context) {
//     return Padding(
//       padding: const EdgeInsets.all(10.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         crossAxisAlignment: CrossAxisAlignment.end,
//         children: [
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   DateFormat.yMMMMd()
//                       .format(NoteController.instance!.selectedData),
//                   style: Themes.titleStyle,
//                 ),
//                 const SizedBox(
//                   height: 5,
//                 ),
//                 Text(
//                   "Today : ${DateFormat.yMMMMd().format(DateTime.now())}",
//                   style: Themes.supTitleStyle,
//                   overflow: TextOverflow.ellipsis,
//                 )
//               ],
//             ),
//           ),
//           const SizedBox(
//             width: 10,
//           ),
//           // DefaultButton(
//           //   onPress: () async {
//           //     Navigator.push(context,
//           //         MaterialPageRoute(builder: (context) => const AddTaskPage()));
//           //   },
//           //   label: "+ Add Task",
//           // ),
//         ],
//       ),
//     );
//   }
//
//   Widget addDateBar(context) {
//     // AppCubit cubit = AppCubit.get(context);
//     return Container(
//       margin: const EdgeInsets.only(top: 10),
//       child: DatePicker(
//         DateTime.now(),
//         initialSelectedDate: DateTime.now(),
//         width: 80,
//         height: 80,
//         selectedTextColor: Colors.white,
//         selectionColor: primaryClr,
//         dateTextStyle:
//         Themes.headingStyle.copyWith(color: Colors.grey, fontSize: 20),
//         dayTextStyle:
//         Themes.headingStyle.copyWith(color: Colors.grey, fontSize: 16),
//         monthTextStyle:
//         Themes.headingStyle.copyWith(color: Colors.grey, fontSize: 12),
//         onDateChange: (DateTime newDate) {
//           // cubit.changSelectedDate(newDate);
//         },
//       ),
//     );
//   }
//
//   Widget noTasks(BuildContext context) {
//     // AppCubit cubit = AppCubit.get(context);
//     return Stack(
//       children: [
//         AnimatedPositioned(
//           duration: const Duration(seconds: 2),
//           child: RefreshIndicator(
//             onRefresh: () async {
//               ///await
//               getNotes();
//             },
//             child: SingleChildScrollView(
//               physics: const AlwaysScrollableScrollPhysics(),
//               child: Wrap(
//                 direction: SizeConfig.orientation == Orientation.landscape
//                     ? Axis.horizontal
//                     : Axis.vertical,
//                 //main
//                 alignment: WrapAlignment.center,
//                 //cross
//                 crossAxisAlignment: WrapCrossAlignment.center,
//                 children: [
//                   SizeConfig.orientation == Orientation.landscape
//                       ? const SizedBox(
//                     height: 6,
//                   )
//                       : const SizedBox(
//                     height: 120,
//                   ),
//                   SvgPicture.asset(
//                     "assets/images/task.svg",
//                     color: primaryClr.withOpacity(0.7),
//                     height: 100,
//                     semanticsLabel: "Task",
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   Text(
//                     "You do not have any tasks!\nAdd New tasks to make your days productive",
//                     style: Themes.supTitleStyle,
//                     textAlign: TextAlign.center,
//                   ),
//                   SizeConfig.orientation == Orientation.landscape
//                       ? const SizedBox(
//                     height: 120,
//                   )
//                       : const SizedBox(
//                     height: 150,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget showTasks(context) {
//     return Expanded(
//         child: RefreshIndicator(
//           onRefresh: () => getNotes(),
//           child: FutureBuilder<List<Note>>(
//             future: _futureNotes,
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return Center(
//                   child: CircularProgressIndicator(
//                     backgroundColor: Colors.grey,
//                   ),
//                 );
//               } else {
//                 if (snapshot.hasError) {
//                   print(snapshot.error.toString());
//                   return Center(
//                     child: Text(
//                       "Error...${snapshot.error.toString()}",
//                       style: TextStyle(
//                           color: Colors.redAccent, fontWeight: FontWeight.w500),
//                     ),
//                   );
//                 } else {
//                   if (_notes.isEmpty && !isAllDeleted) _notes = snapshot.data!;
//                   if (_notes.isEmpty) {
//                     return ListView(children: [
//                       Center(
//                         child: Column(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [noTasks(context)],
//                         ),
//                       ),
//                     ]);
//                   } else {}
//                   return ListView.separated(
//                       itemBuilder: (context, index) {
//                         return ListTile(
//                           onTap: () {
//                             print("Edit Note");
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => EditNoteScreen(
//                                         note: _notes.elementAt(index))));
//                           },
//                           leading: Icon(Icons.note_sharp),
//                           title: Text(
//                             _notes.elementAt(index).title!,
//                             maxLines: 1,
//                             overflow: TextOverflow.ellipsis,
//                             style: TextStyle(fontSize: 18),
//                           ),
//                           subtitle: Padding(
//                             padding: const EdgeInsets.only(top: 5),
//                             child: Text(
//                               _notes.elementAt(index).details!,
//                               maxLines: 2,
//                               overflow: TextOverflow.ellipsis,
//                               style: TextStyle(fontSize: 13),
//                             ),
//                           ),
//
//                           /// بدي احط ديالوج هان قبل الحذف
//                           trailing: IconButton(
//                             icon: Icon(
//                               Icons.delete,
//                               color: Colors.red,
//                             ),
//                             onPressed: () async {
//                               await deleteNote(_notes.elementAt(index).id!, index);
//                             },
//                           ),
//                         );
//                       },
//                       separatorBuilder: (context, index) => Divider(
//                         height: 5,
//                         color: Colors.blueAccent.withOpacity(0.5),
//                         thickness: 0.8,
//                         endIndent: 40,
//                         indent: 40,
//                       ),
//                       itemCount: _notes.length);
//                 }
//               }
//             },
//           ),
//         ));
//   }
// }
