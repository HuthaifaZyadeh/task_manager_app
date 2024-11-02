import 'package:simple_do/app/tasks/data/models/tasks_model.dart';
import 'package:simple_do/app/tasks/domain/usecases/add_task_usecase.dart';
import 'package:simple_do/app/tasks/domain/usecases/get_tasks_usecase.dart';
import 'package:simple_do/app/tasks/domain/usecases/view_task_usecase.dart';
import 'package:simple_do/src/core/data_sources/remote/services/tasks_services.dart';

import '../../../../src/core/data_sources/remote/error_response.dart';
import '../../../../src/error/exceptions.dart';
import '../../domain/usecases/delete_task_usecase.dart';
import '../../domain/usecases/update_task_usecase.dart';
import '../models/task_model.dart';

abstract class BaseTasksDataSource {
  Future<TasksModel> getTasks(GetTasksParameters parameters);
  Future<TaskModel> viewTask(ViewTaskParameters parameters);
  Future<TaskModel> addTask(AddTaskParameters parameters);
  Future<TaskModel> updateTask(UpdateTaskParameters parameters);
  Future<TaskModel> deleteTask(DeleteTaskParameters parameters);
}

class TasksDataSource extends BaseTasksDataSource {
  TasksServices service;
  TasksDataSource({required this.service});

  @override
  Future<TaskModel> addTask(AddTaskParameters parameters) async {
    final response = await service.addTask(parameters.toMap());
    if (response.hasSuccess) {
      return response.data!;
    } else {
      throw ServerException(
        errorMessageModel: ErrorResponse(
          data: response.data,
          message: response.message ?? '',
          status: response.status,
        ),
      );
    }
  }

  @override
  Future<TaskModel> deleteTask(DeleteTaskParameters parameters) async {
    final response = await service.deleteTask(parameters.taskId);
    if (response.hasSuccess) {
      return response.data!;
    } else {
      throw ServerException(
        errorMessageModel: ErrorResponse(
          data: response.data,
          message: response.message ?? '',
          status: response.status,
        ),
      );
    }
  }

  @override
  Future<TasksModel> getTasks(GetTasksParameters parameters) async {
    final response = await service.getTasks(
      skip: parameters.skip,
      limit: parameters.limit,
    );
    if (response.hasSuccess) {
      return response.data!;
    } else {
      throw ServerException(
        errorMessageModel: ErrorResponse(
          data: response.data,
          message: response.message ?? '',
          status: response.status,
        ),
      );
    }
  }

  @override
  Future<TaskModel> updateTask(UpdateTaskParameters parameters) async {
    final response =
        await service.updateTask(parameters.taskId, parameters.toMap());
    if (response.hasSuccess) {
      return response.data!;
    } else {
      throw ServerException(
        errorMessageModel: ErrorResponse(
          data: response.data,
          message: response.message ?? '',
          status: response.status,
        ),
      );
    }
  }

  @override
  Future<TaskModel> viewTask(ViewTaskParameters parameters) async {
    final response = await service.viewTask(parameters.taskId);
    if (response.hasSuccess) {
      return response.data!;
    } else {
      throw ServerException(
        errorMessageModel: ErrorResponse(
          data: response.data,
          message: response.message ?? '',
          status: response.status,
        ),
      );
    }
  }
}
