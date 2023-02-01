// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:sizer/sizer.dart';
//
// import '../../bloc/cubit.dart';
// import '../theme.dart';
// import '../widgets/default_text_button.dart';
// import '../widgets/input_feild.dart';
//
// class EditTaskTitleDialog extends StatelessWidget {
//   EditTaskTitleDialog({Key? key, required this.model}) : super(key: key);
//
//   Map model;
//   var scaffoldKey = GlobalKey<ScaffoldState>();
//   var formKey = GlobalKey<FormState>();
//   var titleController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//
//     titleController = TextEditingController(text: '${model['title']}');
//
//     return Dialog(
//       backgroundColor: bluishClr,
//         shape: RoundedRectangleBorder(
//             borderRadius:
//             BorderRadius.circular(25.0)),
//       child: Container(
//         decoration: BoxDecoration(
//           color: bluishClr,
//           borderRadius: BorderRadius.circular(20.0),
//         ),
//         padding: EdgeInsets.symmetric(vertical: 2.h,
//             horizontal: 3.w),
//         child: Form(
//           key: formKey,
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               DefaultFormField(
//                 controller: titleController,
//                 keyboardType: TextInputType.text,
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'Title must not be empty';
//                   }
//                   return null;
//                 },
//                 labelText: 'Task Title',
//                 // textColor: white,
//                 prefixIcon: const Icon(
//                   Icons.title_outlined, color: bluishClr,),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   Flexible(
//                     child: DefaultTextButton(
//                       onPressed: (){
//                         if(formKey.currentState!.validate()) {
//                           AppCubit.get(context).editTaskTitle(
//                               title: titleController.text,
//                               id: model['id']
//                           );
//                           Fluttertoast.showToast(
//                               msg: "Task Title edited successfully!",
//                               toastLength: Toast.LENGTH_LONG,
//                               gravity: ToastGravity.BOTTOM,
//                               timeInSecForIosWeb: 1,
//                               backgroundColor: Colors.green,
//                               textColor: darkBlue,
//                               fontSize: 14.sp
//                           );
//                           Navigator.of(context).pop();
//                         }
//                       },
//                       child: const DefaultText(
//                         text: 'Save',
//                         color: lightBlue,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                   Flexible(
//                     child: DefaultTextButton(
//                         onPressed: () => Navigator.of(context).pop(),
//                         child: const DefaultText(
//                           text: 'Cancel',
//                           color: lightBlue,
//                           fontWeight: FontWeight.bold,
//                         ),
//                     ),
//                   ),
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }