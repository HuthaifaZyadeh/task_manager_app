import 'package:dartz/dartz.dart';
import 'package:simple_do/app/auth/domain/entities/user_tokens.dart';
import 'package:simple_do/app/auth/domain/usecases/refresh_token_usecase.dart';

import '../../../../../src/error/exceptions.dart';
import '../../../../../src/error/failure.dart';
import '../../../../src/core/data_sources/local/local_storage.dart';
import '../../../../src/di/services_locator.dart';
import '../../domain/entities/app_user.dart';
import '../../domain/repositories/base_auth_repository.dart';
import '../../domain/usecases/login_usecase.dart';
import '../datasources/auth_datasource.dart';

class AuthRepository extends BaseAuthRepository {
  final BaseAuthDataSource baseAuthDataSource;

  AuthRepository(this.baseAuthDataSource);

  @override
  Future<Either<Failure, AppUser>> login(LoginParameters parameters) async {
    try {
      final response = await baseAuthDataSource.login(parameters);
      if (response.hasSuccess) {
        await getIt<LocalStorage>().storeAppUser(response.data!);
        await getIt<LocalStorage>().storeToken(response.data!.accessToken);
        return Right(response.data!);
      } else {
        return Left(ServerFailure(response.message ?? 'ERROR'));
      }
    } on ServerException catch (error) {
      return Left(ServerFailure(error.errorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, AppUser>> me() async {
    try {
      final response = await baseAuthDataSource.me();
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
  Future<Either<Failure, UserTokens>> refreshToken(
      RefreshTokenParameters parameters) async {
    try {
      final response = await baseAuthDataSource.refreshToken(parameters);
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
