import 'package:mockito/annotations.dart';

import 'package:simple_do/app/auth/domain/repositories/base_auth_repository.dart';
import 'package:simple_do/src/core/data_sources/remote/services/auth_services.dart';


@GenerateMocks(
  [
    BaseAuthRepository,
    AuthServices,
  ],
)

void main() {}
