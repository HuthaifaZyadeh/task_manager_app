import 'package:json_annotation/json_annotation.dart';
import 'package:simple_do/app/auth/domain/entities/user_tokens.dart';

part 'user_tokens_model.g.dart';

@JsonSerializable()
class UserTokensModel extends UserTokens {
  const UserTokensModel({
    required super.accessToken,
    required super.refreshToken,
  });

  factory UserTokensModel.fromJson(Map<String, dynamic> json) =>
      _$UserTokensModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserTokensModelToJson(this);
}
