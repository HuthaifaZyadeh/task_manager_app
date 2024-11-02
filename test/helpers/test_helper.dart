import 'package:dio/dio.dart';
import 'package:mockito/annotations.dart';

import 'package:simple_do/app/auth/domain/repositories/base_auth_repository.dart';


@GenerateMocks(
  [
    BaseAuthRepository,
  ],
  customMocks: [MockSpec<Dio>(as: #MockDioClient)],
)

void main() {}
