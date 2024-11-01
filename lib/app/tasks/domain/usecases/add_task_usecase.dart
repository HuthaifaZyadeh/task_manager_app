import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:simple_do/app/tasks/domain/repositories/base_tasks_repository.dart';

import '../../../../../src/core/architecture/base_usecase.dart';
import '../../../../../src/error/failure.dart';
import '../entities/todo_task.dart';

class AddTaskUsecase extends BaseUseCase<TodoTask, AddTaskParameters> {
  final BaseTasksRepository baseTasksRepository;

  AddTaskUsecase(this.baseTasksRepository);

  @override
  Future<Either<Failure, TodoTask>> call(AddTaskParameters parameters) async {
    return await baseTasksRepository.addTask(parameters);
  }
}

class AddTaskParameters extends Equatable {
  final String todo;
  final bool completed;
  final int userId;

  const AddTaskParameters({
    required this.todo,
    this.completed = false,
    required this.userId,
  });

  Map<String, dynamic> toMap() => {
        'todo': todo,
        'completed': completed,
        'userId': userId,
      };

  @override
  List<Object> get props => [
        todo,
        completed,
        userId,
      ];
}
