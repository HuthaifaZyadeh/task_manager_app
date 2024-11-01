import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:simple_do/app/auth/domain/entities/user_tokens.dart';

import '../../../../src/core/architecture/base_usecase.dart';
import '../../../../src/error/failure.dart';
import '../repositories/base_auth_repository.dart';

class RefreshTokenUsecase
    extends BaseUseCase<UserTokens, RefreshTokenParameters> {
  final BaseAuthRepository baseAuthRepository;

  RefreshTokenUsecase(this.baseAuthRepository);

  @override
  Future<Either<Failure, UserTokens>> call(
      RefreshTokenParameters parameters) async {
    return await baseAuthRepository.refreshToken(parameters);
  }
}

class RefreshTokenParameters extends Equatable {
  final String refreshToken;

  const RefreshTokenParameters({required this.refreshToken});

  Map<String, dynamic> toMap() => {'refreshToken': refreshToken};

  @override
  List<Object> get props => [refreshToken];
}
