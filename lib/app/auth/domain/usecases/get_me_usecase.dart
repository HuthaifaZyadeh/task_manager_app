import 'package:dartz/dartz.dart';

import '../../../../src/core/architecture/base_usecase.dart';
import '../../../../src/error/failure.dart';
import '../entities/app_user.dart';
import '../repositories/base_auth_repository.dart';

class GetMeUsecase extends BaseUseCase<AppUser, NoParameters> {
  final BaseAuthRepository baseAuthRepository;

  GetMeUsecase(this.baseAuthRepository);

  @override
  Future<Either<Failure, AppUser>> call(NoParameters parameters) async {
    return await baseAuthRepository.me();
  }
}
