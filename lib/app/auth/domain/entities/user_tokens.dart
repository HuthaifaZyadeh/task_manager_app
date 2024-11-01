import 'package:equatable/equatable.dart';

class UserTokens extends Equatable {
  final String accessToken;
  final String refreshToken;

  const UserTokens({
    required this.accessToken,
    required this.refreshToken,
  });

  @override
  List<Object?> get props => [accessToken, refreshToken];
}
