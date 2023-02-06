import 'package:flutter/material.dart';

import '../theme.dart';

class DefaultButton extends StatelessWidget {
  final Function onPress;
  final String label;
  final Color buttonColor;
  final double buttonHeight;
  final double buttonMinWidth;
  final double borderRadius;

  const DefaultButton({
    Key? key,
    required this.onPress,
    this.buttonColor=primaryClr,
    required this.label,
    this.buttonHeight=45,
    this.buttonMinWidth=100,
    this.borderRadius = 10,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>onPress(),
      child: Container(
        height: buttonHeight,
        width: buttonMinWidth,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child:Text(label,style: const TextStyle(color: Colors.white),),
      ),
    );
  }
}
