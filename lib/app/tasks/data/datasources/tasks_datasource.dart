import 'package:simple_do/app/tasks/data/models/tasks_model.dart';
import 'package:simple_do/app/tasks/domain/usecases/add_task_usecase.dart';
import 'package:simple_do/app/tasks/domain/usecases/get_tasks_usecase.dart';
import 'package:simple_do/app/tasks/domain/usecases/view_task_usecase.dart';
import 'package:simple_do/src/core/data_sources/remote/services/tasks_services.dart';

import '../../../../../src/di/services_locator.dart';
import '../../../../src/core/data_sources/remote/api_response.dart';
import '../../domain/usecases/delete_task_usecase.dart';
import '../../domain/usecases/update_task_usecase.dart';
import '../models/task_model.dart';

abstract class BaseTasksDataSource {
  Future<ApiResponse<TasksModel>> getTasks(GetTasksParameters parameters);
  Future<ApiResponse<TaskModel>> viewTask(ViewTaskParameters parameters);
  Future<ApiResponse<TaskModel>> addTask(AddTaskParameters parameters);
  Future<ApiResponse<TaskModel>> updateTask(UpdateTaskParameters parameters);
  Future<ApiResponse<TaskModel>> deleteTask(DeleteTaskParameters parameters);
}

class TasksDataSource extends BaseTasksDataSource {
  TasksServices service = getIt<TasksServices>();

  @override
  Future<ApiResponse<TaskModel>> addTask(AddTaskParameters parameters) {
    return service.addTask(parameters.toMap());
  }

  @override
  Future<ApiResponse<TaskModel>> deleteTask(DeleteTaskParameters parameters) {
    return service.deleteTask(parameters.taskId);
  }

  @override
  Future<ApiResponse<TasksModel>> getTasks(GetTasksParameters parameters) {
    return service.getTasks(limit: parameters.limit, skip: parameters.skip);
  }

  @override
  Future<ApiResponse<TaskModel>> updateTask(UpdateTaskParameters parameters) {
    return service.updateTask(parameters.taskId, parameters.toMap());
  }

  @override
  Future<ApiResponse<TaskModel>> viewTask(ViewTaskParameters parameters) {
    return service.viewTask(parameters.taskId);
  }
}
