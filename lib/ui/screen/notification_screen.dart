import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/app_states.dart';
import '../../bloc/cubit.dart';
import '../theme.dart';

class NotificationScreen extends StatelessWidget {
  final String payload;

  const NotificationScreen({Key? key, required this.payload}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return Scaffold(
          backgroundColor: //darkHeaderClr,
          !cubit.model ? Theme.of(context).backgroundColor : Colors.white,
          appBar: AppBar(
            elevation: 0,
            backgroundColor:
            !cubit.model ? Theme.of(context).backgroundColor : Colors.white,
            centerTitle: true,
            title: Text(
              payload.split("|")[0],
              textAlign: TextAlign.center,
              style: Themes.titleStyle.copyWith(color:cubit.model ? Colors.black:Colors.white),
            ),
            leading: IconButton(
              color: cubit.model ? darkHeaderClr : Colors.white,
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Text("Hello, Let's finish our work",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Themes.headingStyle),
                  const SizedBox(
                    height: 15,
                  ),
                  Text("you have a new Task and it is ${payload.split("|")[0]}",
                    style: Themes.titleStyle,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 25.0,
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25.0, vertical: 10),
                      decoration: const BoxDecoration(
                        color: primaryClr,
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      child: SingleChildScrollView(
                        child: DefaultTextStyle(
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                          child: Column(
                            children: [
                              rowData(Icons.text_format, "Title",
                                  payload.split("|")[0]),
                              const SizedBox(
                                height: 15,
                              ),
                              const Divider(
                                color: Colors.white,
                              ),
                              rowData(Icons.description, "Description",
                                  payload.split("|")[1]),
                              const SizedBox(
                                height: 15,
                              ),
                              const Divider(
                                color: Colors.white,
                              ),
                              rowData(Icons.calendar_today_outlined, "Time",
                                  payload.split("|")[2]),
                              const SizedBox(
                                height: 15,
                              ),
                              const Divider(
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget rowData(IconData icon, String title, String descrip) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 20,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(title)
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          descrip,
          style: const TextStyle(
            fontSize: 15,
          ),
          textAlign: TextAlign.justify,
        )
      ],
    );
  }
}
