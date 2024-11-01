part of 'tasks_bloc.dart';

abstract class TasksEvent extends Equatable {
  const TasksEvent();

  @override
  List<Object> get props => [];
}

class GetTasksEvent extends TasksEvent {
  final bool invalidateCahce;

  const GetTasksEvent({this.invalidateCahce = false});
}

class RefreshTasksEvent extends TasksEvent {}

class AddTaskEvent extends TasksEvent {
  final String taskName;
  final bool completed;

  const AddTaskEvent({required this.taskName, required this.completed});
}

class UpdateTaskEvent extends TasksEvent {
  final int taskId;
  final bool completed;
  const UpdateTaskEvent({
    required this.taskId,
    required this.completed,
  });
}

class DeleteTaskEvent extends TasksEvent {
  final int taskId;

  const DeleteTaskEvent({required this.taskId});
}
