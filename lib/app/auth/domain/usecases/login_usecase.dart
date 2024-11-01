import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:simple_do/app/auth/domain/entities/app_user.dart';

import '../../../../../src/core/architecture/base_usecase.dart';
import '../../../../../src/error/failure.dart';
import '../repositories/base_auth_repository.dart';

class LoginUseCase extends BaseUseCase<AppUser, LoginParameters> {
  final BaseAuthRepository baseAuthRepository;

  LoginUseCase(this.baseAuthRepository);

  @override
  Future<Either<Failure, AppUser>> call(LoginParameters parameters) async {
    return await baseAuthRepository.login(parameters);
  }
}

class LoginParameters extends Equatable {
  final String username;
  final String password;

  const LoginParameters({
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toMap() => {
        'username': username,
        'password': password,
      };

  @override
  List<Object> get props => [
        username,
        password,
      ];
}
