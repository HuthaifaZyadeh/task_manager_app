import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:simple_do/app/tasks/domain/repositories/base_tasks_repository.dart';

import '../../../../../src/core/architecture/base_usecase.dart';
import '../../../../../src/error/failure.dart';
import '../entities/todo_task.dart';

class ViewTaskUsecase extends BaseUseCase<TodoTask, ViewTaskParameters> {
  final BaseTasksRepository baseTasksRepository;

  ViewTaskUsecase(this.baseTasksRepository);

  @override
  Future<Either<Failure, TodoTask>> call(ViewTaskParameters parameters) async {
    return await baseTasksRepository.viewTask(parameters);
  }
}

class ViewTaskParameters extends Equatable {
  final int taskId;

  const ViewTaskParameters({required this.taskId});

  @override
  List<Object> get props => [taskId];
}
