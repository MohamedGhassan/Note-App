import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite_app/bloc/app_states.dart';
import 'package:sqflite_app/bloc/cubit.dart';
import 'package:sqflite_app/models/notes.dart';
import 'package:sqflite_app/ui/widgets/button.dart';
import '../theme.dart';
import '../widgets/input_feild.dart';

class CreateNoteScreen extends StatefulWidget {
  const CreateNoteScreen({Key? key}) : super(key: key);

  @override
  State<CreateNoteScreen> createState() => _CreateNoteScreenState();
}


class _CreateNoteScreenState extends State<CreateNoteScreen> {

  @override
  void initState() {
    super.initState();
    titlec.text = "hi";
    notec.text = "my name is good";
    remindc.text = "5";
    repeatc.text = "None";
    etimec.text = DateFormat("hh:mm a")
        .format(DateTime.now().add(const Duration(minutes: 15)));
    stimec.text = DateFormat("hh:mm a").format(DateTime.now());
    datec.text = DateFormat.yMd().format(DateTime.now());
  }

  TextEditingController titlec = TextEditingController();
  TextEditingController notec = TextEditingController();
  TextEditingController datec = TextEditingController();
  TextEditingController stimec = TextEditingController();
  TextEditingController etimec = TextEditingController();
  TextEditingController remindc = TextEditingController();
  TextEditingController repeatc = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  DateTime date = DateTime.now();
  dynamic eTime =
  TimeOfDay.fromDateTime(DateTime.now().add(const Duration(minutes: 15)));
  dynamic sTime = TimeOfDay.now();
  int remind = 3;
  List<int> remindList = [5, 10, 15, 20];
  String repeat = "None";
  List<String> repeatList = ["None", "Daily", "weekly", "Monthly"];
  int color = 0;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return Scaffold(
          backgroundColor:
          !cubit.model ? Theme
              .of(context)
              .backgroundColor : Colors.white,
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor:
            !cubit.model ? Theme
                .of(context)
                .backgroundColor : Colors.white,
            leading: IconButton(
              color: cubit.model ? darkHeaderClr : Colors.white,
              icon: const Icon(
                Icons.arrow_back_ios,
                size: 24,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            actions: const[
              Padding(
                padding: EdgeInsets.all(10.0),
                child: CircleAvatar(
                  radius: 18,
                  backgroundImage: AssetImage("assets/images/person.jpg"),
                ),
              )
            ],
          ),
          body: Container(
            padding: const EdgeInsetsDirectional.all(10),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                        child: Text(
                          "Add Task",
                          style: Themes.supHeadingStyle,
                        )),
                    ...?mainForm(
                      title: "Title",
                      myController: titlec,
                      readOnly: false,
                      icon: Icons.title,
                      textInputType: TextInputType.text,
                    ),
                    ...?mainForm(
                      title: "Noat",
                      myController: notec,
                      readOnly: false,
                      icon: Icons.note,
                      textInputType: TextInputType.text,
                    ),
                    ...?mainForm(
                        title: "Date",
                        myController: datec,
                        readOnly: true,
                        icon: Icons.data_usage_outlined,
                        textInputType: TextInputType.text,
                        hintText:
                        DateFormat.yMd().format(DateTime.now()).toString(),
                        onPressSuffixIcon: () {
                          showDatePicker(
                              context: context,
                              initialDate: date,
                              firstDate: DateTime.parse("2020-12-31"),
                              lastDate: DateTime.parse("2023-12-31"))
                              .then((value) {
                            if (value != null) {
                              setState(() {
                                date = value;
                                datec.text = DateFormat.yMd().format(value);
                              });
                            }
                          });
                        }),
                    Row(
                      children: [
                        Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ...?mainForm(
                                    title: "Start Time",
                                    myController: stimec,
                                    readOnly: true,
                                    icon: Icons.watch,
                                    textInputType: TextInputType.number,
                                    hintText:
                                    TimeOfDay.now().format(context).toString(),
                                    onPressSuffixIcon: () {
                                      showTimePicker(
                                          context: context, initialTime: sTime)
                                          .then((value) {
                                        if (value != null) {
                                          setState(() {
                                            sTime = value.format(context);
                                            stimec.text =
                                                value.format(context)
                                                    .toString();
                                          });
                                        }
                                      });
                                    }),
                              ],
                            )),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ...?mainForm(
                                    title: "End Time",
                                    myController: etimec,
                                    readOnly: true,
                                    icon: Icons.watch,
                                    textInputType: TextInputType.number,
                                    hintText: DateFormat("hh:mm a").format(
                                        DateTime.now()
                                            .add(const Duration(minutes: 15))),
                                    onPressSuffixIcon: () {
                                      showTimePicker(
                                          context: context, initialTime: eTime)
                                          .then((value) {
                                        if (value != null) {
                                          setState(() {
                                            eTime = value.format(context);
                                            etimec.text = value.format(context);
                                          });
                                        }
                                      });
                                    }),
                              ],
                            ))
                      ],
                    ),
                    ...?mainForm(
                      title: "Remind",
                      myController: remindc,
                      readOnly: true,
                      icon: Icons.arrow_drop_down,
                      textInputType: TextInputType.number,
                      hintText: " ${remind.toString()} minutes early",
                      widget: Builder(builder: (ctx) {
                        return DropdownButton(
                            borderRadius: BorderRadius.circular(10),
                            dropdownColor: Colors.blueGrey,
                            underline: Container(),
                            items: remindList.map((int item) {
                              return DropdownMenuItem(
                                child: Text(item.toString()),
                                value: item,
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                if (value != null) remind = value as int;
                                remindc.text = remind.toString();
                              });
                              print("remind : " + remind.toString());
                            });
                      }),
                    ),
                    ...?mainForm(
                      title: "Repeat",
                      myController: repeatc,
                      readOnly: true,
                      hintText: repeat,
                      icon: Icons.arrow_drop_down,
                      textInputType: TextInputType.text,
                      widget: Builder(builder: (ctx) {
                        return DropdownButton(
                            borderRadius: BorderRadius.circular(10),
                            dropdownColor: Colors.blueGrey,
                            underline: Container(),
                            items: repeatList.map((String item) {
                              return DropdownMenuItem(
                                child: Text(item),
                                value: item,
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                if (value != null) repeat = value.toString();
                                repeatc.text = repeat;
                              });

                              print("repeat : " + repeat.toString());
                            });
                      }),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Color",
                              style: Themes.titleStyle,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                colorAvatar(const Color(0xFF4e5ae8), 0),
                                const SizedBox(
                                  width: 10,
                                ),
                                colorAvatar(const Color(0xFFff4667), 1),
                                const SizedBox(
                                  width: 10,
                                ),
                                colorAvatar(const Color(0xCFFF8746), 2),
                              ],
                            )
                          ],
                        ),
                        const Spacer(),
                        DefaultButton(
                            onPress: () async {
                              if (_formKey.currentState!.validate()) {
                                await addNote(context);
                              }
                            },
                            label: "Submit")
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  addTask(context) async {
    AppCubit cubit = AppCubit.get(context);
    Note n = Note(
      color: color,
      date: DateFormat.yMd().format(date),
      endTime: etimec.text,
      startTime: stimec.text,
      isCompleted: 0,
      note: notec.text,
      title: titlec.text,
      remind: remind,
      repeat: repeat,
    );
    int? id = await cubit.addNote(n);
    n.setId(id);
    print("id is " + n.id.toString());
    cubit.saveAnddisplayNotification(n);
    Navigator.pop(context);
  }

  List<Widget>? mainForm({required String title,
    required myController,
    required readOnly,
    required IconData icon,
    required textInputType,
    Function? onPressSuffixIcon,
    dynamic foucs,
    String? hintText,
    Widget? widget}) {
    return [
      const SizedBox(
        height: 15.0,
      ),
      Text(title, style: Themes.titleStyle,),
      const SizedBox(
        height: 10.0,
      ),
      DefaultTextFormField(
        widget: widget,
        readOnly: readOnly,
        hintText: hintText ?? "Enter $title",
        labelText: title,
        isPassword: false,
        textInputType: textInputType,
        controller: myController,
        suffixIcon: icon,
        onPressSuffixIcon: () {
          if (onPressSuffixIcon != null) onPressSuffixIcon();
        },
        validator: (String? value) {
          if (value == null || value
              .trim()
              .isEmpty) {
            return 'Please fill the field';
          }
          return null;
        },
      ),
    ];
  }

  Widget colorAvatar(Color myColor, int index) {
    return InkWell(
      onTap: () {
        setState(() {
          color = index;
          print("Color : " + color.toString());
        });
      },
      child: CircleAvatar(
        radius: 15,
        backgroundColor: myColor,
        child: index == color ? Icon(Icons.done) : null,
      ),
    );
  }

  addNote(context) async {
    AppCubit cubit = AppCubit.get(context);
    Note n = Note(
        color: color,
        date: DateFormat.yMd().format(date),
        endTime: etimec.text,
        startTime: stimec.text,
        isCompleted: 0,
        note: notec.text,
        title: titlec.text,
        remind: remind,
        repeat: repeat);
    int id = await cubit.addNote(n);
    n.setId(id);
    print("id is " + id.toString());
    // cubit.saveAnddisplayNotification(n);
    Navigator.pop(context);
  }
}


// import 'package:flutter/material.dart';
// import 'package:sqflite_app/database/database.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
//
// import '../../models/notes.dart';
//
//
// class CreateNoteScreen extends StatefulWidget {
//   final String? title;
//
//   CreateNoteScreen({this.title});
//
//   @override
//   State<CreateNoteScreen> createState() => _CreateNoteScreenState();
// }
//
// class _CreateNoteScreenState extends State<CreateNoteScreen> {
//   TextEditingController? _titleEditingController;
//   TextEditingController? _detailsEditingController;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _titleEditingController = TextEditingController();
//     _detailsEditingController = TextEditingController();
//
//   }
//
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//     _titleEditingController!.dispose();
//     _detailsEditingController!.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(AppLocalizations.of(context)!.createNoteScreen),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(15.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _titleEditingController,
//               keyboardType: TextInputType.text,
//               decoration: InputDecoration(
//                 hintText: AppLocalizations.of(context)!.noteTitle,
//               ),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             TextField(
//               controller: _detailsEditingController,
//               keyboardType: TextInputType.text,
//               decoration: InputDecoration(
//                 hintText: AppLocalizations.of(context)!.notesDetails,
//               ),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             SizedBox(
//                 width: double.infinity,
//                 height: 50,
//                 child: ElevatedButton.icon(
//                   onPressed: () async{
//                     await performStore();
//                   },
//                   icon: Icon(Icons.save_alt),
//                   label: Text(AppLocalizations.of(context)!.saveTask),
//                 ))
//           ],
//         ),
//       ),
//     );
//   }
//
//   Future performStore() async {
//     if (checkData()) {
//       await create();
//     }
//   }
//
//   bool checkData() {
//     if (_titleEditingController!.text.isNotEmpty &&
//         _detailsEditingController!.text.isNotEmpty) {
//       return true;
//     }
//     return false;
//   }
//
//   // Future create() async {
//   //  bool inserted =  await DataBase.instance!.create(getNote());
//   //  if(inserted)
//   //    {
//   //      print("Inserted Successfully");
//   //      clear();
//   //    }
//   // }
//
//   Note getNote() {
//     return Note(
//       title: _titleEditingController!.text,
//       details: _detailsEditingController!.text,
//     );
//   }
//
//   void clear(){
//     _titleEditingController!.text = "";
//     _detailsEditingController!.text = "";
//   }
// }
