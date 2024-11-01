import '../../../../src/core/data_sources/local/local_storage.dart';
import '../../../../src/di/services_locator.dart';
import '../../domain/usecases/get_tasks_usecase.dart';
import '../models/tasks_model.dart';

abstract class BaseLocalTasksDataSource {
  TasksModel? getTasks(GetTasksParameters parameters);
  Future<bool> saveTasks(TasksModel tasks);
  Future<bool> clearTasks();
}

class LocalTasksDataSource extends BaseLocalTasksDataSource {
  LocalStorage localStorage = getIt<LocalStorage>();

  @override
  TasksModel? getTasks(GetTasksParameters parameters) {
    return localStorage.tasks;
  }

  @override
  Future<bool> saveTasks(TasksModel tasks) {
    return localStorage.storeTasks(tasks);
  }

  @override
  Future<bool> clearTasks() {
    return localStorage.clearTasks();
  }
}
