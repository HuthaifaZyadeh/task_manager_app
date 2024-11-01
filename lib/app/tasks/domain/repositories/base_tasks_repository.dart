import 'package:dartz/dartz.dart';
import 'package:simple_do/app/tasks/domain/entities/todo_task.dart';
import 'package:simple_do/app/tasks/domain/entities/todo_tasks.dart';
import 'package:simple_do/app/tasks/domain/usecases/add_task_usecase.dart';

import '../../../../../src/error/failure.dart';
import '../usecases/delete_task_usecase.dart';
import '../usecases/get_tasks_usecase.dart';
import '../usecases/update_task_usecase.dart';
import '../usecases/view_task_usecase.dart';

abstract class BaseTasksRepository {
  Future<Either<Failure, TodoTasks>> getTasks(GetTasksParameters parameters);
  Future<Either<Failure, TodoTask>> viewTask(ViewTaskParameters parameters);
  Future<Either<Failure, TodoTask>> addTask(AddTaskParameters parameters);
  Future<Either<Failure, TodoTask>> updateTask(UpdateTaskParameters parameters);
  Future<Either<Failure, TodoTask>> deleteTask(DeleteTaskParameters parameters);
}
