import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:simple_do/app/auth/data/datasources/auth_datasource.dart';
import 'package:simple_do/app/auth/data/models/app_user_model.dart';
import 'package:simple_do/app/auth/domain/usecases/login_usecase.dart';
import 'package:simple_do/src/core/data_sources/remote/api_response.dart';

import '../../../../helpers/test_helper.mocks.dart';
import '../models/app_user_model_test.dart';

const userCredentials = {
  'username': 'emilys',
  'password': 'emilyspass',
};

void main() {
  late MockAuthServices mockAuthServices;
  late AuthDataSource authDataSource;

  setUp(() {
    mockAuthServices = MockAuthServices();
    authDataSource = AuthDataSource(service: mockAuthServices);
  });

  group('Login user', () {
    test('Login using username and password', () async {
      // arrange
      when(mockAuthServices.login(userCredentials)).thenAnswer(
        (_) async => ApiResponse.success(
          data: appUserModel,
          message: 'Login Success',
        ),
      );

      // act
      final result = await authDataSource.login(LoginParameters(
        username: userCredentials['username']!,
        password: userCredentials['password']!,
      ));

      // assert
      expect(result, isA<AppUserModel>());
    });
  });
}
