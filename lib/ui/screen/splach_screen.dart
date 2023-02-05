import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sqflite_app/bloc/cubit.dart';
import 'package:sqflite_app/ui/screen/notes_screen.dart';

import '../theme.dart';

class SplachScreen extends StatefulWidget {
  const SplachScreen({Key? key}) : super(key: key);

  @override
  State<SplachScreen> createState() => _SplachScreenState();
}

class _SplachScreenState extends State<SplachScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    AppCubit cubit = AppCubit.get(context);
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(vsync: this);
    Future.delayed(Duration(seconds: 2), () async{
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => NotesScreen()));
      await cubit.getNote();
      //     .then((value)
      // {
      //   cubit.getNote();
      // });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppCubit cubit=AppCubit.get(context);
    return Scaffold(
        backgroundColor: !cubit.model
            ? Theme
            .of(context)
            .backgroundColor
            : Colors.white,
        body: Container(
            child: Center(
              child: Lottie.network(
                  "https://assets2.lottiefiles.com/private_files/lf30_qLBJdY.json",
                  controller: _controller, onLoaded: (compos) {
                Text("Errrrrrrrrrror1");
                _controller
                  ..duration = compos.duration
                  ..forward();
                Text("Errrrrrrrrrror2");
              }),
            )
        )
    );
  }
}
