import 'package:flutter/material.dart';
import 'package:Tasks/shard/component/component.dart';
import 'package:Tasks/shard/cubit/cubit.dart';

class ArchiveScreen extends StatelessWidget {
  const ArchiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) => buildTaskItem(
          context,
          AppCubit.getInstance(context).archiveTasks[index]['id'],
          AppCubit.getInstance(context).archiveTasks[index]['title'],
          AppCubit.getInstance(context).archiveTasks[index]['time'],
          AppCubit.getInstance(context).archiveTasks[index]['date']
      ),
      separatorBuilder: (context, index) => Container(
        color: Colors.grey,
        width: double.infinity,
        height: 1.0,
      ),
      itemCount: AppCubit.getInstance(context).archiveTasks.length,
    );
  }
}
