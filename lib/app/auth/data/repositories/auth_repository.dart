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
      final appUser = await baseAuthDataSource.login(parameters);
      await getIt<LocalStorage>().storeAppUser(appUser);
      await getIt<LocalStorage>().storeToken(appUser.accessToken);

      return Right(appUser);
    } on ServerException catch (error) {
      return Left(ServerFailure(error.errorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, AppUser>> me() async {
    try {
      final appUser = await baseAuthDataSource.me();
      return Right(appUser);
    } on ServerException catch (error) {
      return Left(ServerFailure(error.errorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, UserTokens>> refreshToken(
      RefreshTokenParameters parameters) async {
    try {
      final tokens = await baseAuthDataSource.refreshToken(parameters);
      return Right(tokens);
    } on ServerException catch (error) {
      return Left(ServerFailure(error.errorMessageModel.message));
    }
  }
}
