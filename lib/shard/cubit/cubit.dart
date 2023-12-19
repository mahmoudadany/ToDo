import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:Tasks/module/archive/archive_screen.dart';
import 'package:Tasks/module/done/done_screen.dart';
import 'package:Tasks/module/tasks/tasks_screen.dart';
import 'package:Tasks/shard/cubit/states.dart';
import 'package:Tasks/shard/database/sqflite.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppIntialState());

  List<Widget> allScreen = [TasksScreen(), DoneScreen(), ArchiveScreen()];
  List<String> screenTitle = ['New tasks', 'Done Tasks', 'Archive Tasks'];
  int currentindex = 0;
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archiveTasks = [];
  bool bottomShetState=false;
  IconData icon=Icons.edit;
  late Database database;

  void bottomSheetState(
  {
    required bool isShow,
    required IconData icon
}
      ){
    bottomShetState=isShow;
    this.icon=icon;
    emit(AppChangeBottomState());
  }

  void changeBottomBarState(int index) {
    currentindex = index;
    emit(AppBottomNavBarState());
  }

  static AppCubit getInstance(context) => BlocProvider.of(context);

  void createDatabase() {
    openDatabase('todo.db', version: 1, onCreate: (database, version) {
      database
          .execute(
              'CREATE TABLE tasks (id INTEGER PRIMARY KEY , title TEXT , time TEXT , date TEXT , state TEXT)')
          .then((value) {
        print("database created");
      });
    }, onOpen: (database) {
      getAllTasks(database);
    }).then((value) {
      database = value;
      emit(AppCreateDatabase());
    });
  }


  void getAllTasks(Database database) async {
    newTasks=[];
    doneTasks=[];
    archiveTasks=[];
    await database.rawQuery('SELECT * FROM tasks').then((value) {
      value.forEach((element) {
        if(element['state']=='new'){
          newTasks.add(element);
        }else if(element['state']=='done'){
          doneTasks.add(element);
        }else{
          archiveTasks.add(element);
        }
      });
      emit(AppGetAllDatabase());
    });
  }


  void inserIntoToDatabase(String title, String time, String data,String state) async {
    // return  await createDatabase().then((database) {
   await database.transaction((txn) {
     return txn.rawQuery(
            'INSERT INTO tasks (title, time, date, state) VALUES("$title", "$time", "$data","$state")');
   }).then((value) {
          emit(AppInsertToDatabase());
          print("glal : insert successful");
          getAllTasks(database);
        })
        .catchError((error) {
      print("glal : ${error.toString()}");
    });
  }

  void updateDataInDatabase(
  {
    required String state,
    required int id
}) async{
    database.rawUpdate(
        'UPDATE tasks SET state = ? WHERE id = ? ',
      ['$state',id]
    ).then((value) {
      print("glal : update$value");
      emit(AppUpdateDatabase());
      getAllTasks(database);
    });
  }


  void deleteDataInDatabase(
  {
    required int id
}) async{
    database.rawDelete(
        'DELETE FROM tasks WHERE id = ? ',
      [id]
    ).then((value) {
      print("glal : update$value");
      getAllTasks(database);
      emit(AppDeleteDatabase());
    });
  }

}
