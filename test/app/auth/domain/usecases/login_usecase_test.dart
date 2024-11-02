import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:simple_do/app/auth/domain/entities/app_user.dart';
import 'package:simple_do/app/auth/domain/usecases/login_usecase.dart';
import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late MockBaseAuthRepository mockBaseAuthRepository;
  late LoginUseCase loginUseCase;

  const params = LoginParameters(
    username: 'emilys',
    password: 'emilyspass',
  );

  final response = AppUser.testEntity();

  setUp(() {
    mockBaseAuthRepository = MockBaseAuthRepository();
    loginUseCase = LoginUseCase(mockBaseAuthRepository);
  });
  test(
    'Login with username and password',
    () async {
      // arrange
      when(mockBaseAuthRepository.login(params))
          .thenAnswer((_) async => Right(response));

      // act
      final result = await loginUseCase.call(params);

      // assert
      expect(result, Right(response));
    },
  );
}
