import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:simple_do/app/tasks/domain/repositories/base_tasks_repository.dart';

import '../../../../../src/core/architecture/base_usecase.dart';
import '../../../../../src/error/failure.dart';
import '../entities/todo_task.dart';

class DeleteTaskUsecase extends BaseUseCase<TodoTask, DeleteTaskParameters> {
  final BaseTasksRepository baseTasksRepository;

  DeleteTaskUsecase(this.baseTasksRepository);

  @override
  Future<Either<Failure, TodoTask>> call(
      DeleteTaskParameters parameters) async {
    return await baseTasksRepository.deleteTask(parameters);
  }
}

class DeleteTaskParameters extends Equatable {
  final int taskId;

  const DeleteTaskParameters({required this.taskId});

  @override
  List<Object> get props => [taskId];
}
