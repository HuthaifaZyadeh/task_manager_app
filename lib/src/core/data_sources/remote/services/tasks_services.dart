import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:simple_do/src/core/data_sources/remote/api_response.dart';

import '../../../../../app/tasks/data/models/task_model.dart';
import '../../../../../app/tasks/data/models/tasks_model.dart';
import '../api_endpoints.dart';

part 'tasks_services.g.dart';

@RestApi()
abstract class TasksServices {
  factory TasksServices(Dio dio, {String baseUrl}) = _TasksServices;

  @GET(ApiEndpoints.todos)
  Future<ApiResponse<TasksModel>> getTasks({
    @Query('limit') int limit = 15,
    @Query('skip') required int skip,
  });

  @GET(ApiEndpoints.todos)
  Future<ApiResponse<TaskModel>> viewTask(@Path() int taskId);

  @PUT(ApiEndpoints.updaeteTodo)
  Future<ApiResponse<TaskModel>> updateTask(
      @Path('id') int taskId, @Body() Map<String, dynamic> body);

  @DELETE(ApiEndpoints.deleteTodo)
  Future<ApiResponse<TaskModel>> deleteTask(@Path('id') int taskId);

  @POST(ApiEndpoints.addTodo)
  Future<ApiResponse<TaskModel>> addTask(@Body() Map<String, dynamic> body);
}
