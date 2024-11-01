import 'package:equatable/equatable.dart';

class TodoTask extends Equatable {
  final int id;
  final String todo;
  final bool completed;
  final int userId;
  final bool? isDeleted;

  const TodoTask({
    required this.id,
    required this.todo,
    required this.completed,
    required this.userId,
    required this.isDeleted,
  });

  @override
  List<Object?> get props => [
        id,
        todo,
        completed,
        userId,
        isDeleted,
      ];
}
