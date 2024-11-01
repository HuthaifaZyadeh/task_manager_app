import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simple_do/app/tasks/domain/entities/todo_task.dart';
import 'package:simple_do/app/tasks/domain/usecases/add_task_usecase.dart';
import 'package:simple_do/app/tasks/domain/usecases/delete_task_usecase.dart';
import 'package:simple_do/app/tasks/domain/usecases/get_tasks_usecase.dart';
import 'package:simple_do/app/tasks/domain/usecases/update_task_usecase.dart';
import 'package:simple_do/app/tasks/domain/usecases/view_task_usecase.dart';
import 'package:simple_do/src/utils/app_notifications.dart';

import '../../../../src/core/data_sources/local/local_storage.dart';
import '../../../../src/di/services_locator.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  final GetTasksUsecase getTasksUsecase;
  final ViewTaskUsecase viewTaskUsecase;
  final AddTaskUsecase addTaskUsecase;
  final UpdateTaskUsecase updateTaskUsecase;
  final DeleteTaskUsecase deleteTaskUsecase;

  TasksBloc(
    this.getTasksUsecase,
    this.viewTaskUsecase,
    this.addTaskUsecase,
    this.updateTaskUsecase,
    this.deleteTaskUsecase,
  ) : super(const TasksState()) {
    on<GetTasksEvent>(_getTasks);
    on<RefreshTasksEvent>(_refreshTasks);
    on<AddTaskEvent>(_addTask);
    on<UpdateTaskEvent>(_updateTask);
    on<DeleteTaskEvent>(_deleteTask);
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          state.canFetchNow) {
        add(const GetTasksEvent());
        scrollController
            .jumpTo(scrollController.position.maxScrollExtent + 80.h);
      }
    });
  }

  final ScrollController scrollController = ScrollController();

  int skip = 0;
  int total = -1;

  FutureOr<void> _getTasks(
      GetTasksEvent event, Emitter<TasksState> emit) async {
    skip = state.tasks.length;
    if (skip == total || !state.canFetchNow) {
      return;
    }
    if (skip == 0) {
      emit(state.copyWith(tasksLoading: true));
    } else {
      emit(state.copyWith(tasksPaginating: true));
    }

    final response = await getTasksUsecase.call(
        GetTasksParameters(skip: skip, invalidateCache: event.invalidateCahce));

    response.fold(
      (l) {
        AppNotifications.showError(message: l.message);
        emit(state.copyWith(tasksLoading: false, tasksPaginating: false));
      },
      (r) {
        total = r.total;
        final tempList =
            List.generate(state.tasks.length, (index) => state.tasks[index]);
        tempList.addAll(r.todos);
        emit(state.copyWith(
            tasks: tempList, tasksLoading: false, tasksPaginating: false));
      },
    );
  }

  _resetValues(Emitter<TasksState> emit) {
    total = -1;
    emit(state.copyWith(tasks: []));
  }

  FutureOr<void> _refreshTasks(
      RefreshTasksEvent event, Emitter<TasksState> emit) async {
    _resetValues(emit);
    add(const GetTasksEvent(invalidateCahce: true));
  }

  FutureOr<void> _addTask(AddTaskEvent event, Emitter<TasksState> emit) async {
    emit(state.copyWith(tasksLoading: true));
    final response = await addTaskUsecase.call(AddTaskParameters(
      todo: event.taskName,
      completed: event.completed,
      // TODO: fetch actual user id
      userId: getIt<LocalStorage>().appUser!.id,
    ));

    response.fold(
      (l) {
        AppNotifications.showError(message: l.message);
        emit(state.copyWith(tasksLoading: false));
      },
      (r) {
        final tempList =
            List.generate(state.tasks.length, (index) => state.tasks[index]);
        tempList.insert(0, r);

        AppNotifications.showSuccess(message: 'Task added successfully!');

        emit(state.copyWith(tasks: tempList, tasksLoading: false));
      },
    );
  }

  FutureOr<void> _updateTask(
      UpdateTaskEvent event, Emitter<TasksState> emit) async {
    emit(state.copyWith(tasksLoading: true));
    final response = await updateTaskUsecase.call(UpdateTaskParameters(
      taskId: event.taskId,
      completed: event.completed,
    ));

    response.fold(
      (l) {
        AppNotifications.showError(message: l.message);
        emit(state.copyWith(tasksLoading: false));
      },
      (r) {
        final tempList =
            List.generate(state.tasks.length, (index) => state.tasks[index]);
        final taskIndex = tempList
            .indexOf(tempList.firstWhere((element) => element.id == r.id));
        tempList[taskIndex] = r;

        AppNotifications.showSuccess(message: 'Task updated successfully!');

        emit(state.copyWith(tasks: tempList, tasksLoading: false));
      },
    );
  }

  FutureOr<void> _deleteTask(
      DeleteTaskEvent event, Emitter<TasksState> emit) async {
    emit(state.copyWith(tasksLoading: true));
    final response = await deleteTaskUsecase
        .call(DeleteTaskParameters(taskId: event.taskId));

    response.fold(
      (l) {
        AppNotifications.showError(message: l.message);
        emit(state.copyWith(tasksLoading: false));
      },
      (r) {
        final tempList =
            List.generate(state.tasks.length, (index) => state.tasks[index]);

        tempList.remove(tempList.firstWhere((element) => element.id == r.id));

        AppNotifications.showSuccess(message: 'Task deleted successfully!');

        emit(state.copyWith(tasks: tempList, tasksLoading: false));
      },
    );
  }
}
