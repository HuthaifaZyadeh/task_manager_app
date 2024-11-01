part of 'tasks_bloc.dart';

class TasksState extends Equatable {
  final bool tasksLoading;
  final bool tasksPaginating;
  final List<TodoTask> tasks;
  const TasksState({
    this.tasksLoading = false,
    this.tasksPaginating = false,
    this.tasks = const [],
  });

  @override
  List<Object> get props => [
        tasksLoading,
        tasksPaginating,
        tasks,
      ];

  bool get canFetchNow => !tasksLoading && !tasksPaginating;

  TasksState copyWith({
    bool? tasksLoading,
    bool? tasksPaginating,
    List<TodoTask>? tasks,
  }) {
    return TasksState(
      tasksLoading: tasksLoading ?? this.tasksLoading,
      tasksPaginating: tasksPaginating ?? this.tasksPaginating,
      tasks: tasks ?? this.tasks,
    );
  }
}
