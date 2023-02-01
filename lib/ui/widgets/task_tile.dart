import 'package:flutter/material.dart';
import 'package:sqflite_app/ui/size_config.dart';
import 'package:sqflite_app/ui/theme.dart';

import '../../models/notes.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({Key? key, required this.note}) : super(key: key);
  final Note note;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.orientation == Orientation.landscape
          ? SizeConfig.screenWidth / 2
          : SizeConfig.screenWidth,
      padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(
              SizeConfig.orientation == Orientation.landscape ? 4 : 0),
          vertical: getProportionateScreenHeight(
              SizeConfig.orientation == Orientation.landscape ? 4 : 0)),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            color: getColor(note.color)),
        child: Row(
          children: [
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    note.title!,
                    style: Themes.body2Style
                        .copyWith(fontSize: 16, color: Colors.grey[100]),
                  ),
                  SizedBox(
                    height: 12.0,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.access_time_filled_outlined,
                        color: Colors.grey[200],
                        size: 18,
                      ),
                      SizedBox(
                        width: 12.0,
                      ),
                      Text(
                        note.startTime! + " - " + note.endTime!,
                        style: Themes.body2Style.copyWith(fontSize: 13, color: Colors.grey[100],),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12.0,
                  ),
                  Text(note.note!,
                    style: Themes.body2Style
                      .copyWith(fontSize: 14, color: Colors.grey[100]),)
                ],
              ),
            ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              height: 60,
              width: 0.5,
              color: Colors.grey[200]!.withOpacity(0.7),
            ),
            RotatedBox(
              quarterTurns: 3,
              child: Text(
                note.isCompleted == 0 ? "TODO" : "Completed",
                style: Themes.body2Style
                    .copyWith(fontSize: 10, color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }

  Color getColor(int? color) {
    switch (color) {
      case 0:
        return primaryClr;
      case 1:
        return pinkClr;
      case 2:
        return orangeClr;
      default:
        return bluishClr;
    }
  }
}
