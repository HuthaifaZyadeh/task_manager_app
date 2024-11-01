import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_do/app/auth/domain/usecases/get_me_usecase.dart';
import 'package:simple_do/app/auth/domain/usecases/refresh_token_usecase.dart';
import 'package:simple_do/src/utils/app_notifications.dart';

import '../../domain/usecases/login_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final GetMeUsecase getMeUsecase;
  final RefreshTokenUsecase refreshTokenUsecase;

  AuthBloc(
    this.loginUseCase,
    this.getMeUsecase,
    this.refreshTokenUsecase,
  ) : super(const AuthState()) {
    on<LoginEvent>(_login);
    on<GetMeEvent>(_getMe);
    on<RefreshTokenEvent>(_refrehToken);
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  FutureOr<void> _login(LoginEvent event, Emitter<AuthState> emit) async {
    showLoading(emit);
    final result = await loginUseCase(LoginParameters(
      username: usernameController.text,
      password: passwordController.text,
    ));

    result.fold(
      (l) {
        AppNotifications.showError(message: l.message);
      },
      (r) {
        emit(state.copyWith(loginSuccess: true));
      },
    );
    hideLoading(emit);
  }

  FutureOr<void> _getMe(GetMeEvent event, Emitter<AuthState> emit) async {}

  FutureOr<void> _refrehToken(
      RefreshTokenEvent event, Emitter<AuthState> emit) async {}

  void hideLoading(Emitter<AuthState> emit) {
    emit(state.copyWith(loading: false));
  }

  void showLoading(Emitter<AuthState> emit) {
    emit(state.copyWith(loading: true));
  }
}
