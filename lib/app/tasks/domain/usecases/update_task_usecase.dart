import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:simple_do/app/tasks/domain/repositories/base_tasks_repository.dart';

import '../../../../../src/core/architecture/base_usecase.dart';
import '../../../../../src/error/failure.dart';
import '../entities/todo_task.dart';

class UpdateTaskUsecase extends BaseUseCase<TodoTask, UpdateTaskParameters> {
  final BaseTasksRepository baseTasksRepository;

  UpdateTaskUsecase(this.baseTasksRepository);

  @override
  Future<Either<Failure, TodoTask>> call(
      UpdateTaskParameters parameters) async {
    return await baseTasksRepository.updateTask(parameters);
  }
}

class UpdateTaskParameters extends Equatable {
  final int taskId;
  final bool completed;

  const UpdateTaskParameters({
    required this.taskId,
    required this.completed,
  });

  Map<String, dynamic> toMap() => {'completed': completed};

  @override
  List<Object> get props => [
        taskId,
        completed,
      ];
}
