// // import 'package:flutter/material.dart';
// //
// // import '../models/notes.dart';
// //
// // class EditNoteScreen extends StatefulWidget {
// //   final Note? note;
// //
// //   @override
// //   State<EditNoteScreen> createState() => _EditNoteScreenState();
// //
// //   EditNoteScreen({this.note});
// // }
// //
// // class _EditNoteScreenState extends State<EditNoteScreen> {
// //   TextEditingController? _titleEditingController;
// //   TextEditingController? _detailsEditingController;
// //
// //   @override
// //   void setState(VoidCallback fn) {
// //     // TODO: implement setState
// //     super.setState(fn);
// //     _titleEditingController = TextEditingController();
// //     _detailsEditingController = TextEditingController();
// //     setNoteData();
// //   }
// //
// //   @override
// //   void dispose() {
// //     // TODO: implement dispose
// //     super.dispose();
// //     _titleEditingController!.dispose();
// //     _detailsEditingController!.dispose();
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text("Edit ${widget.note!.title!}"),
// //       ),
// //       body: Padding(
// //         padding: const EdgeInsets.all(15.0),
// //         child: Column(
// //           children: [
// //             TextField(
// //               controller: _titleEditingController,
// //               keyboardType: TextInputType.text,
// //               decoration: InputDecoration(
// //                 hintText: 'Title',
// //               ),
// //             ),
// //             SizedBox(
// //               height: 20,
// //             ),
// //             TextField(
// //               controller: _detailsEditingController,
// //               keyboardType: TextInputType.text,
// //               decoration: InputDecoration(
// //                 hintText: 'Details',
// //               ),
// //             ),
// //             SizedBox(
// //               height: 20,
// //             ),
// //             SizedBox(
// //                 width: double.infinity,
// //                 height: 50,
// //                 child: ElevatedButton.icon(
// //                   onPressed: () async{
// //                     // await performStore();
// //                   },
// //                   icon: Icon(Icons.save_alt),
// //                   label: Text('Save'),
// //                 ))
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// //   Note getNote() {
// //     return Note(
// //       title: _titleEditingController!.text,
// //       details: _detailsEditingController!.text,
// //     );
// //   }
// //
// //   void clear(){
// //     _titleEditingController!.text = "";
// //     _detailsEditingController!.text = "";
// //   }
// //   void setNoteData(){
// //     _titleEditingController!.text = widget.note!.title!;
// //     _detailsEditingController!.text = widget.note!.details!;
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import '../../models/notes.dart';
//
// class EditNoteScreen extends StatefulWidget {
//   final Note? note;
//
//   EditNoteScreen({this.note});
//
//   @override
//   State<EditNoteScreen> createState() => _EditNoteScreenState();
// }
//
// class _EditNoteScreenState extends State<EditNoteScreen> {
//   TextEditingController? _titleTextController;
//   TextEditingController? _detailsTextController;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _titleTextController = TextEditingController();
//     _detailsTextController = TextEditingController();
//     // setNoteData();
//
//   }
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//     _titleTextController!.dispose();
//     _detailsTextController!.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(AppLocalizations.of(context)!.editNoteScreen),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(15.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _titleTextController,
//               keyboardType: TextInputType.text,
//               decoration: InputDecoration(
//                 hintText: 'Title',
//               ),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             TextField(
//               controller: _detailsTextController,
//               keyboardType: TextInputType.text,
//               maxLines: 3,
//               decoration: InputDecoration(
//                 hintText: 'Details',
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
//                     // await performStore();
//                   },
//                   icon: Icon(Icons.save_alt),
//                   label: Text('Save'),
//                 ))
//           ],
//         ),
//       ),
//     );
//   }
//
//   // Future performStore() async {
//   //   if (checkData()) {
//   //     await update();
//   //   }
//   // }
//
//   bool checkData() {
//     if (_titleTextController!.text.isNotEmpty &&
//         _detailsTextController!.text.isNotEmpty) {
//       return true;
//     }
//     return false;
//   }
//
//   // Future update() async {
//   //   bool? updated = await DataBase.instance!.update(getNote());
//   //   if(updated!)
//   //   {
//   //     print("Updated Successfully");
//   //   }
//   // }
//
//   // Note getNote() {
//   //  // widget.note!.title = _titleTextController!.text;
//   //  // widget.note!.details = detailsTextController!.text;
//   //  // return widget.note!;
//   //   Note note = widget.note!;
//   //   note.title = _titleTextController!.text;
//   //   note.details = _detailsTextController!.text;
//   //   return note;
//   // }
//
//   // void clear(){
//   //   _titleTextController!.text = "";
//   //   _detailsTextController!.text = "";
//   // }
//   // void setNoteData(){
//   //   _titleTextController!.text = widget.note!.title!;
//   //   _detailsTextController!.text = widget.note!.details!;
//   // }
// }
