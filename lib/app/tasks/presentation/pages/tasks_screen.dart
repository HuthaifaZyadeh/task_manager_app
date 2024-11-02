import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_do/src/core/data_sources/local/local_storage.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:simple_do/src/themes/app_colors.dart';

import '../../../../src/components/pagination_indicator.dart';
import '../../../../src/di/services_locator.dart';
import '../bloc/tasks_bloc.dart';
import '../widgets/task_details_dialog.dart';
import '../widgets/task_tile.dart';
import '../widgets/tasks_app_bar.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  String _taskTitle(TasksState state, int index) {
    if (state.tasksLoading) return 'just some dummy text';

    return state.tasks[index].todo;
  }

  bool _taskCompleted(TasksState state, int index) {
    if (state.tasksLoading) return false;

    return state.tasks[index].completed;
  }

  int _taskId(TasksState state, int index) {
    if (state.tasksLoading) return -1;

    return state.tasks[index].id;
  }

  int _childCount(TasksState state) {
    final tasksCount = state.tasks.length;
    if (state.tasksLoading) return tasksCount == 0 ? 7 : tasksCount;
    if (state.tasksPaginating) return tasksCount + 1;
    return tasksCount;
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<TasksBloc>();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showTaskDialog(context);
        },
        child: const Icon(Icons.add),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          bloc.add(RefreshTasksEvent());
        },
        child: CustomScrollView(
          controller: bloc.scrollController,
          slivers: [
            TasksAppBar(
                userImage: getIt<LocalStorage>()
                    .appUser!
                    .image
                    .replaceFirst('128', '512')),
            BlocBuilder<TasksBloc, TasksState>(
              builder: (context, state) {
                return Skeletonizer.sliver(
                  containersColor: AppColors.white,
                  enabled: state.tasksLoading,
                  child: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return index == state.tasks.length &&
                                state.tasksPaginating
                            ? const PaginationIndicator()
                            : TaskTile(
                                taskId: _taskId(state, index),
                                title: _taskTitle(state, index),
                                completed: _taskCompleted(state, index),
                              );
                      },
                      childCount: _childCount(state),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  _showTaskDialog(BuildContext context) {
    final bloc = context.read<TasksBloc>();
    showAdaptiveDialog(
      context: context,
      builder: (_) => const TaskDetailsDialog(isAdd: true),
    ).then(
      (value) {
        if (value == null) return;
        bloc.add(AddTaskEvent(
          taskName: value['taskName'],
          completed: value['completed'],
        ));
      },
    );
  }
}
