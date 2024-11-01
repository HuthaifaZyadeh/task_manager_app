part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final bool loading;
  final bool loginSuccess;

  const AuthState({
    this.loading = false,
    this.loginSuccess = false,
  });

  @override
  List<Object?> get props => [
        loading,
        loginSuccess,
      ];

  AuthState copyWith({
    bool? loading,
    bool? loginSuccess,
  }) {
    return AuthState(
      loading: loading ?? this.loading,
      loginSuccess: loginSuccess ?? this.loginSuccess,
    );
  }
}
