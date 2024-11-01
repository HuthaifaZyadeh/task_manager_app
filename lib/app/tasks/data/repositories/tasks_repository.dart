import 'package:dartz/dartz.dart';
import 'package:simple_do/app/tasks/domain/entities/todo_task.dart';
import 'package:simple_do/app/tasks/domain/entities/todo_tasks.dart';
import 'package:simple_do/app/tasks/domain/usecases/add_task_usecase.dart';
import 'package:simple_do/app/tasks/domain/usecases/delete_task_usecase.dart';
import 'package:simple_do/app/tasks/domain/usecases/get_tasks_usecase.dart';
import 'package:simple_do/app/tasks/domain/usecases/update_task_usecase.dart';
import 'package:simple_do/app/tasks/domain/usecases/view_task_usecase.dart';

import '../../../../../src/error/exceptions.dart';
import '../../../../../src/error/failure.dart';
import '../../domain/repositories/base_tasks_repository.dart';
import '../datasources/local_tasks_datasource.dart';
import '../datasources/tasks_datasource.dart';

class TasksRepository extends BaseTasksRepository {
  final BaseTasksDataSource baseTasksDataSource;
  final BaseLocalTasksDataSource baseLocalTasksDataSource;

  TasksRepository(
    this.baseTasksDataSource,
    this.baseLocalTasksDataSource,
  );

  @override
  Future<Either<Failure, TodoTasks>> getTasks(
      GetTasksParameters parameters) async {
    try {
      // Fetch cached
      if (parameters.invalidateCache) {
        await baseLocalTasksDataSource.clearTasks();
      }

      final cachedTasks = baseLocalTasksDataSource.getTasks(parameters);
      if (cachedTasks != null &&
          cachedTasks.todos.skip(parameters.skip).isNotEmpty) {
        return Right(cachedTasks);
      }

      // Fetch live
      final response = await baseTasksDataSource.getTasks(parameters);
      if (response.hasSuccess) {
        baseLocalTasksDataSource.saveTasks(response.data!);
        return Right(response.data!);
      } else {
        return Left(ServerFailure(response.message ?? 'ERROR'));
      }
    } on ServerException catch (error) {
      return Left(ServerFailure(error.errorMessageModel.message));
    }
    // on LocalDatabaseException catch (error) {
    //   return Left(DatabaseFailure(error.message));
    // }
  }

  @override
  Future<Either<Failure, TodoTask>> viewTask(
      ViewTaskParameters parameters) async {
    try {
      final response = await baseTasksDataSource.viewTask(parameters);
      if (response.hasSuccess) {
        return Right(response.data!);
      } else {
        return Left(ServerFailure(response.message ?? 'ERROR'));
      }
    } on ServerException catch (error) {
      return Left(ServerFailure(error.errorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, TodoTask>> addTask(
      AddTaskParameters parameters) async {
    try {
      final response = await baseTasksDataSource.addTask(parameters);
      if (response.hasSuccess) {
        return Right(response.data!);
      } else {
        return Left(ServerFailure(response.message ?? 'ERROR'));
      }
    } on ServerException catch (error) {
      return Left(ServerFailure(error.errorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, TodoTask>> updateTask(
      UpdateTaskParameters parameters) async {
    try {
      final response = await baseTasksDataSource.updateTask(parameters);
      if (response.hasSuccess) {
        return Right(response.data!);
      } else {
        return Left(ServerFailure(response.message ?? 'ERROR'));
      }
    } on ServerException catch (error) {
      return Left(ServerFailure(error.errorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, TodoTask>> deleteTask(
      DeleteTaskParameters parameters) async {
    try {
      final response = await baseTasksDataSource.deleteTask(parameters);
      if (response.hasSuccess) {
        return Right(response.data!);
      } else {
        return Left(ServerFailure(response.message ?? 'ERROR'));
      }
    } on ServerException catch (error) {
      return Left(ServerFailure(error.errorMessageModel.message));
    }
  }
}
