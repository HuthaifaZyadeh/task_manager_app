import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simple_do/app/tasks/presentation/bloc/tasks_bloc.dart';
import 'package:simple_do/app/tasks/presentation/widgets/task_details_dialog.dart';
import 'package:simple_do/src/themes/app_colors.dart';

import '../../../../src/components/app_text.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({
    super.key,
    required this.taskId,
    required this.title,
    this.completed = false,
  });
  final int taskId;
  final String title;
  final bool completed;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: REdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: ListTile(
        onTap: () {
          _showTaskDialog(context);
        },
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        contentPadding: REdgeInsets.all(12.0),
        leading: Icon(
          completed ? Icons.task_alt_rounded : Icons.assignment,
          size: 24.sp,
          color: completed ? Colors.green : Colors.blueAccent,
        ),
        title: AppText(
          text: title,
          overFlow: TextOverflow.ellipsis,
        ),
        trailing: Icon(
          Icons.open_in_new,
          size: 20.sp,
          color: AppColors.textGrey,
        ),
      ),
    );
  }

  _showTaskDialog(BuildContext context) {
    final bloc = context.read<TasksBloc>();
    showAdaptiveDialog(
      context: context,
      builder: (_) => TaskDetailsDialog(
        completed: completed,
        taskName: title,
        isAdd: false,
      ),
    ).then(
      (value) {
        if (value == null) return;
        if (value['delete'] == true) {
          bloc.add(DeleteTaskEvent(taskId: taskId));
        } else if (value['completed'] != completed) {
          bloc.add(UpdateTaskEvent(
            taskId: taskId,
            completed: value['completed'],
          ));
        }
      },
    );
  }
}
