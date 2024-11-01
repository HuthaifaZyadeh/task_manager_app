import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:simple_do/app/tasks/domain/entities/todo_tasks.dart';
import 'package:simple_do/app/tasks/domain/repositories/base_tasks_repository.dart';

import '../../../../../src/core/architecture/base_usecase.dart';
import '../../../../../src/error/failure.dart';

class GetTasksUsecase extends BaseUseCase<TodoTasks, GetTasksParameters> {
  final BaseTasksRepository baseTasksRepository;

  GetTasksUsecase(this.baseTasksRepository);

  @override
  Future<Either<Failure, TodoTasks>> call(GetTasksParameters parameters) async {
    return await baseTasksRepository.getTasks(parameters);
  }
}

class GetTasksParameters extends Equatable {
  final int limit;
  final int skip;
  final bool invalidateCache;

  const GetTasksParameters({
    required this.skip,
    this.limit = 15,
    this.invalidateCache = false,
  });

  @override
  List<Object> get props => [
        limit,
        skip,
        invalidateCache,
      ];
}
