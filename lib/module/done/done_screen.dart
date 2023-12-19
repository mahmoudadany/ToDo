import 'package:flutter/material.dart';
import 'package:Tasks/shard/component/component.dart';
import 'package:Tasks/shard/cubit/cubit.dart';

class DoneScreen extends StatelessWidget {
  const DoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) =>
          buildTaskItem(
              context,
              AppCubit
                  .getInstance(context)
                  .doneTasks[index]['id'],
              AppCubit
                  .getInstance(context)
                  .doneTasks[index]['title'],
              AppCubit
                  .getInstance(context)
                  .doneTasks[index]['time'],
              AppCubit
                  .getInstance(context)
                  .doneTasks[index]['date']
          ),
      separatorBuilder: (context, index) =>
          Container(
            color: Colors.grey,
            width: double.infinity,
            height: 1.0,
          ),
      itemCount: AppCubit
          .getInstance(context)
          .doneTasks
          .length,
    );
  }
}
