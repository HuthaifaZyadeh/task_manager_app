import 'package:equatable/equatable.dart';

class AppUser extends Equatable {
  final int id;
  final String username;
  final String email;
  final String firstName;
  final String lastName;
  final String gender;
  final String image;
  final String accessToken;
  final String refreshToken;

  const AppUser({
    required this.id,
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.image,
    required this.accessToken,
    required this.refreshToken,
  });

  factory AppUser.testEntity() => const AppUser(
        id: -1,
        username: '',
        email: '',
        firstName: '',
        lastName: '',
        gender: '',
        image: '',
        accessToken: '',
        refreshToken: '',
      );

  @override
  List<Object?> get props => [
        id,
        username,
        email,
        firstName,
        lastName,
        gender,
        image,
        accessToken,
        refreshToken,
      ];
}
