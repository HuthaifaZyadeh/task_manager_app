import 'package:dio/dio.dart';
import 'package:simple_do/app/auth/data/models/app_user_model.dart';
import 'package:simple_do/app/auth/data/models/user_tokens_model.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:simple_do/src/core/data_sources/remote/api_response.dart';

import '../api_endpoints.dart';

part 'auth_services.g.dart';

@RestApi()
abstract class AuthServices {
  factory AuthServices(Dio dio, {String baseUrl}) = _AuthServices;

  @POST(ApiEndpoints.login)
  Future<ApiResponse<AppUserModel>> login(@Body() Map<String, dynamic> body);

  @POST(ApiEndpoints.me)
  Future<ApiResponse<AppUserModel>> me();

  @POST(ApiEndpoints.refresh)
  Future<ApiResponse<UserTokensModel>> refresh(
      @Body() Map<String, dynamic> body);
}
