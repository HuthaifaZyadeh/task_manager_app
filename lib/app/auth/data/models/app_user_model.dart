import 'package:json_annotation/json_annotation.dart';
import 'package:simple_do/app/auth/domain/entities/app_user.dart';

part 'app_user_model.g.dart';

@JsonSerializable()
class AppUserModel extends AppUser {
  const AppUserModel({
    required super.id,
    required super.username,
    required super.email,
    required super.firstName,
    required super.lastName,
    required super.gender,
    required super.image,
    required super.accessToken,
    required super.refreshToken,
  });

  factory AppUserModel.fromJson(Map<String, dynamic> json) =>
      _$AppUserModelFromJson(json);

  Map<String, dynamic> toJson() => _$AppUserModelToJson(this);
}
