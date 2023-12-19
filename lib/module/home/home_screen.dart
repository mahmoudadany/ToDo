import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Tasks/layout/bottomsheet_screen.dart';
import 'package:Tasks/shard/cubit/cubit.dart';
import 'package:Tasks/shard/cubit/states.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});


  TextEditingController titlecontroller = TextEditingController();
  TextEditingController timecontroller = TextEditingController();
  TextEditingController datecontroller = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var scaffoldKey = GlobalKey<ScaffoldState>();

  // @override
  // void initState() {
  //   createDatabase();
  // }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) =>
        AppCubit()
          ..createDatabase(),
        child: BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              key: scaffoldKey,
              appBar: AppBar(
                backgroundColor: Colors.blue,
                title: Text(
                  AppCubit
                      .getInstance(context)
                      .screenTitle[AppCubit
                      .getInstance(context)
                      .currentindex],
                  style: TextStyle(
                      fontSize: 25.0,
                      color: Colors.white
                  ),
                ),
              ),
              body: AppCubit
                  .getInstance(context)
                  .allScreen[AppCubit
                  .getInstance(context)
                  .currentindex],
              bottomNavigationBar: BottomNavigationBar(
                  fixedColor: Colors.blue,
                  currentIndex: AppCubit
                      .getInstance(context)
                      .currentindex,
                  onTap: (index) {
                    AppCubit.getInstance(context).changeBottomBarState(index);
                  },
                  items: [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.menu), label: 'Tasks'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.check_circle_outline), label: 'Done'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.archive), label: 'Archive'),
                  ]),
              floatingActionButton: FloatingActionButton(
                backgroundColor: Colors.blue,
                elevation: 20.0,
                child: Icon(
                  AppCubit
                      .getInstance(context)
                      .icon,
                  color: Colors.white,
                ),
                onPressed: () {
                  if ( AppCubit.getInstance(context).bottomShetState) {
                    if(formKey.currentState!.validate()){
                      AppCubit.getInstance(context)
                          .inserIntoToDatabase(
                          titlecontroller.text,
                          timecontroller.text,
                          datecontroller.text,
                        "new"
                      );
                      Navigator.pop(context);
                    }

                  } else {

                    scaffoldKey.currentState?.showBottomSheet((context) =>
                        BottomSheetScreen(
                          formKey: formKey,
                          titlecontroller: titlecontroller,
                          timecontroller: timecontroller,
                          datecontroller: datecontroller,
                        )).closed.then((value) {
                      AppCubit.getInstance(context).bottomSheetState(
                        isShow: false,
                        icon: Icons.edit
                      );
                    });
                    AppCubit.getInstance(context).bottomSheetState(
                        isShow: true,
                        icon: Icons.add
                    );
                  }
                  // AppCubit.getInstance(context).bottomSheetState();

                  // setState(() {
                  //   if(bottomShetState){
                  //     if(formKey.currentState!.validate()){
                  //       inserIntoToDatabase(titlecontroller.text, timecontroller.text, datecontroller.text).then((database) {
                  //         getAllTasks(database).then((value) {
                  //           setState(() {
                  //             allTasks=value;
                  //             Navigator.pop(context);
                  //             icon=Icons.edit;
                  //
                  //           });
                  //         });
                  //       });
                  //     }
                  //   }else{
                  //     icon=Icons.add;
                  //     scaffoldKey.currentState?.showBottomSheet((context) => BottomSheetScreen(
                  //       formKey: formKey,
                  //       titlecontroller: titlecontroller,
                  //       timecontroller: timecontroller,
                  //       datecontroller: datecontroller,
                  //     )).closed.then((value) {
                  //       setState(() {
                  //         icon=Icons.edit;
                  //         bottomShetState=!bottomShetState;
                  //       });
                  //     });
                  //   }
                  //   bottomShetState=!bottomShetState;
                  // });
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

