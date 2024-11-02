import 'package:simple_do/app/auth/data/models/user_tokens_model.dart';
import 'package:simple_do/app/auth/domain/usecases/refresh_token_usecase.dart';

import '../../../../../src/core/data_sources/remote/services/auth_services.dart';
import '../../../../src/core/data_sources/remote/error_response.dart';
import '../../../../src/error/exceptions.dart';
import '../../domain/usecases/login_usecase.dart';
import '../models/app_user_model.dart';

abstract class BaseAuthDataSource {
  Future<AppUserModel> login(LoginParameters parameters);
  Future<AppUserModel> me();
  Future<UserTokensModel> refreshToken(RefreshTokenParameters parameters);
}

class AuthDataSource extends BaseAuthDataSource {
  AuthServices service;

  AuthDataSource({required this.service});

  @override
  Future<AppUserModel> login(LoginParameters parameters) async {
    final response = await service.login(parameters.toMap());
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
  Future<AppUserModel> me() async {
    final response = await service.me();
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
  Future<UserTokensModel> refreshToken(
      RefreshTokenParameters parameters) async {
    final response = await service.refresh(parameters.toMap());
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
