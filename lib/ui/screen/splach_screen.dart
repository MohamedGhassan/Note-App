import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:sqflite_app/bloc/app_states.dart';
import 'package:sqflite_app/bloc/cubit.dart';
import 'package:sqflite_app/ui/screen/notes_screen.dart';
import '../theme.dart';
import '../widgets/default_text.dart';

class SplachScreen extends StatefulWidget {
  SplachScreen({Key? key}) : super(key: key);
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
    Future.delayed(Duration(seconds: 5), () async{
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
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state){},
      builder: (context, state)
      {
        return Scaffold(
            backgroundColor: !cubit.model
                ? Theme
                .of(context)
                .backgroundColor
                : Colors.white,
            body: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Lottie.network(
                            "https://assets10.lottiefiles.com/private_files/lf30_qLBJdY.json",
                            controller: _controller, onLoaded: (compos) {
                          _controller
                            ..duration = compos.duration
                            ..forward();
                        }),
                      ),
                    ),
                    Flexible(
                      child: DefaultText(
                        text: 'MY TO-DO LIST',
                        color: pinkClr,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ]
              ),
            )
        );
      },
    );
  }
}
