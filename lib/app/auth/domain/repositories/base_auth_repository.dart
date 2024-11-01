import 'package:dartz/dartz.dart';
import 'package:simple_do/app/auth/domain/entities/app_user.dart';
import 'package:simple_do/app/auth/domain/entities/user_tokens.dart';

import '../../../../../src/error/failure.dart';
import '../usecases/login_usecase.dart';
import '../usecases/refresh_token_usecase.dart';

abstract class BaseAuthRepository {
  Future<Either<Failure, AppUser>> login(LoginParameters parameters);
  Future<Either<Failure, AppUser>> me();
  Future<Either<Failure, UserTokens>> refreshToken(
      RefreshTokenParameters parameters);
}
