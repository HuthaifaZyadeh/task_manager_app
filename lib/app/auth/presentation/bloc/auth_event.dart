part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginEvent extends AuthEvent {}

class RefreshTokenEvent extends AuthEvent {}

class GetMeEvent extends AuthEvent {}
