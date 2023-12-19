import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Tasks/shard/component/component.dart';
import 'package:Tasks/shard/cubit/cubit.dart';
import 'package:Tasks/shard/cubit/states.dart';

class TasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
    builder: (context,state){
    return ListView.separated(
    itemBuilder: (context, index) => buildTaskItem(
      context,
    AppCubit.getInstance(context).newTasks[index]['id'],
    AppCubit.getInstance(context).newTasks[index]['title'],
    AppCubit.getInstance(context).newTasks[index]['time'],
    AppCubit.getInstance(context).newTasks[index]['date']
    ),
    separatorBuilder: (context, index) => Container(
    color: Colors.grey,
    width: double.infinity,
    height: 1.0,
    ),
    itemCount: AppCubit.getInstance(context).newTasks.length,
    );
    });
    }
}
