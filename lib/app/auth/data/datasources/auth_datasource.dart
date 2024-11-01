import 'package:simple_do/app/auth/data/models/user_tokens_model.dart';
import 'package:simple_do/app/auth/domain/usecases/refresh_token_usecase.dart';

import '../../../../../src/core/data_sources/remote/services/auth_services.dart';
import '../../../../../src/di/services_locator.dart';
import '../../../../src/core/data_sources/remote/api_response.dart';
import '../../domain/usecases/login_usecase.dart';
import '../models/app_user_model.dart';

abstract class BaseAuthDataSource {
  Future<ApiResponse<AppUserModel>> login(LoginParameters parameters);
  Future<ApiResponse<AppUserModel>> me();
  Future<ApiResponse<UserTokensModel>> refreshToken(
      RefreshTokenParameters parameters);
}

class AuthDataSource extends BaseAuthDataSource {
  AuthServices service = getIt<AuthServices>();

  @override
  Future<ApiResponse<AppUserModel>> login(LoginParameters parameters) {
    return service.login(parameters.toMap());
  }

  @override
  Future<ApiResponse<AppUserModel>> me() {
    return service.me();
  }

  @override
  Future<ApiResponse<UserTokensModel>> refreshToken(
      RefreshTokenParameters parameters) {
    return service.refresh(parameters.toMap());
  }
}
