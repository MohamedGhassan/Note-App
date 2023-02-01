import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sqflite_app/bloc/cubit.dart';
import 'package:sqflite_app/ui/size_config.dart';
import '../../models/notes.dart';
import '../theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

showMyBottomSheet(BuildContext context, Note note) {
  AppCubit cubit = AppCubit.get(context);
  // NotifyHelper notifyHelper=NotifyHelper();

  showBottomSheet(
    context: context,
    builder: (BuildContext context) => Container(
      padding: EdgeInsets.only(
          top: 10, bottom: MediaQuery.of(context).viewInsets.bottom + 10),
      width: SizeConfig.screenWidth,
      color: !cubit.model ? darkHeaderClr : Colors.white,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 6,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: !cubit.model ? Colors.grey[600] : Colors.grey[300],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            note.isCompleted == 1
                ? Container()
                : bottomSheetButton(context, label: "Task completed",
                ontap: () async {
                  cubit.updateNote(note);
                  //await notifyHelper.cancelNotification(task);
                  //controller.updateTask(task);
                  //Get.back();

                  Navigator.pop(context);
                }, clr: primaryClr),
            bottomSheetButton(context, label: "Delete Task", ontap: () async {
              //await notifyHelper.cancelAllNotification();
              //controller.deleteTask(task.id!);
              //controller.taskList.remove(task);
              //Get.back();
              cubit.deleteNote(note);
              Navigator.pop(context);
            }, clr: pinkClr),
            Divider(
              color: !cubit.model ? Colors.grey : darkGreyClr,
            ),
            bottomSheetButton(context, label: "Cancel", isClosed: false,
                ontap: () {
                  Navigator.pop(context);
                }, clr: primaryClr),
          ],
        ),
      ),
    ),
  );
}

Widget noTasks(BuildContext context) {
  AppCubit cubit = AppCubit.get(context);
  return Stack(
    children: [
      AnimatedPositioned(
        duration: const Duration(seconds: 2),
        child: RefreshIndicator(
          onRefresh: () async {
            cubit.getNote();
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Wrap(
              direction: SizeConfig.orientation == Orientation.landscape
                  ? Axis.horizontal
                  : Axis.vertical,
              //main
              alignment: WrapAlignment.center,
              //cross
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                SizeConfig.orientation == Orientation.landscape
                    ? const SizedBox(
                  height: 6,
                )
                    : const SizedBox(
                  height: 120,
                ),
                SvgPicture.asset(
                  "assets/images/task.svg",
                  color: primaryClr.withOpacity(0.7),
                  height: 100,
                  semanticsLabel: "Task",
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  AppLocalizations.of(context)!.notes,
                  // style: Themes.supTitleStyle,
                  style: TextStyle(
                    fontSize: 18,
                    // fontWeight: FontWeight.w300,
                    color: !cubit.model ? Colors.white : Colors.grey[700],
                  ),
                  textAlign: TextAlign.center,
                ),
                // Text(
                //   "You do not have any tasks!\nAdd New tasks to make your days productive",
                //   style: Themes.supTitleStyle,
                //   textAlign: TextAlign.center,
                // ),
                SizeConfig.orientation == Orientation.landscape
                    ? const SizedBox(
                  height: 120,
                )
                    : const SizedBox(
                  height: 150,
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}

Widget bottomSheetButton(BuildContext context,
    {required String label,
      required Function() ontap,
      required Color clr,
      bool isClosed = false}) {
  AppCubit cubit = AppCubit.get(context);
  return GestureDetector(
    onTap: () => ontap(),
    child: Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      height: 50,
      width: SizeConfig.screenWidth * 0.7,
      alignment: AlignmentDirectional.center,
      decoration: BoxDecoration(
          border: Border.all(
              width: 2,
              color: isClosed
                  ? !cubit.model
                  ? Colors.grey[600]!
                  : Colors.grey[300]!
                  : clr),
          borderRadius: BorderRadius.circular(20),
          color: isClosed ? Colors.transparent : clr),
      child: Text(
        label,
        style: isClosed
            ? Themes.supTitleStyle
            : Themes.supTitleStyle.copyWith(color: Colors.white),
      ),
    ),
  );
}

// List<Widget>? mainForm({required String title,
//   required myController,
//   required readOnly,
//   required IconData icon,
//   required textInputType,
//   Function? onPressSuffixIcon,
//   dynamic foucs,
//   String? hintText,
//   Widget? widget}) {
//   return [
//     const SizedBox(
//       height: 15.0,
//     ),
//     Text(title, style: Themes.titleStyle,),
//     const SizedBox(
//       height: 10.0,
//     ),
//     DefaultTextFormField(
//       widget: widget,
//       readOnly: readOnly,
//       hintText: hintText ?? "Enter $title",
//       labelText: title,
//       isPassword: false,
//       textInputType: textInputType,
//       controller: myController,
//       suffixIcon: icon,
//       onPressSuffixIcon: () {
//         if (onPressSuffixIcon != null) onPressSuffixIcon();
//       },
//       validator: (String? value) {
//         if (value == null || value.trim().isEmpty) {
//           return 'Please fill the field';
//         }
//         return null;
//       },
//     ),
//   ];
// }
