import 'package:sqflite/sqflite.dart';
import 'package:Tasks/shard/constant/constants.dart';
import 'package:Tasks/shard/cubit/cubit.dart';

import '../../model/Task.dart';


// Future<Database> inserIntoToDatabase(String title, String time, String data) async {
// return  await createDatabase().then((database) {
//     database
//         .transaction((txn) => txn.rawQuery(
//             'INSERT INTO tasks (title, time, date) VALUES("$title", "$time", "$data")'))
//         .then((value) => print("glal : insert successful"))
//         .catchError((error) {
//       print("glal : ${error.toString()}");
//     });
//     return database;
//   });
// }

