import 'package:equatable/equatable.dart';

import '../../data/models/task_model.dart';

class TodoTasks extends Equatable {
  final List<TaskModel> todos;
  final int total;
  final int skip;
  final int limit;

  const TodoTasks({
    required this.todos,
    required this.total,
    required this.skip,
    required this.limit,
  });

  @override
  List<Object?> get props => [
        todos,
        total,
        skip,
        limit,
      ];
}
