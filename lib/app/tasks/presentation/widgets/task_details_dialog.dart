import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_do/src/themes/app_colors.dart';

import '../../../../src/components/app_button.dart';
import '../../../../src/components/app_text.dart';
import '../../../../src/components/custom_text_field.dart';

class TaskDetailsDialog extends StatefulWidget {
  const TaskDetailsDialog({
    super.key,
    required this.isAdd,
    this.taskName,
    this.completed,
  }) : assert(isAdd || taskName != null);
  final String? taskName;
  final bool? completed;
  final bool isAdd;

  @override
  State<TaskDetailsDialog> createState() => _TaskDetailsDialogState();
}

class _TaskDetailsDialogState extends State<TaskDetailsDialog> {
  final TextEditingController taskNameController = TextEditingController();
  bool? completed;

  @override
  void initState() {
    super.initState();
    completed = widget.completed;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!widget.isAdd)
            const Center(
              child: AppText(
                text: 'Description',
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          widget.isAdd
              ? CustomTextField(
                  controller: taskNameController,
                  label: 'Task name',
                  isMultiline: true,
                  onChanged: (_) {
                    setState(() {});
                  },
                )
              : AppText(
                  text: widget.taskName!,
                  maxLines: null,
                ),
          12.verticalSpace,
          CheckboxListTile.adaptive(
            contentPadding: REdgeInsets.symmetric(horizontal: 12),
            dense: true,
            title: const AppText(text: 'Completed'),
            value: completed ?? false,
            onChanged: (val) {
              setState(() {
                completed = val;
              });
            },
          ),
        ],
      ),
      actions: [
        widget.isAdd
            ? Center(
                child: AppButton(
                  title: 'Confirm',
                  disabled: taskNameController.text.isEmpty,
                  onPressed: () {
                    context.pop({
                      'completed': completed ?? false,
                      'taskName': taskNameController.text,
                    });
                    taskNameController.clear();
                  },
                ),
              )
            : Center(
                child: AppButton.outlined(
                  title: 'Delete',
                  isOutlined: true,
                  textColor: AppColors.red,
                  onPressed: () {
                    context.pop({'delete': true});
                  },
                ),
              ),
        8.verticalSpace,
        Center(
          child: AppButton.outlined(
            title: 'Close',
            textColor: AppColors.black,
            onPressed: () {
              widget.isAdd
                  ? context.pop()
                  : context.pop({'completed': completed});
            },
          ),
        ),
      ],
    );
  }
}
