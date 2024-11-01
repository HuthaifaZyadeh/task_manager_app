import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'error_response.g.dart';

@JsonSerializable()
class ErrorResponse extends Equatable {
  final String message;
  final dynamic status;
  final dynamic data;

  const ErrorResponse({
    required this.message,
    required this.status,
    required this.data,
  });

  factory ErrorResponse.fromJson(Map<String, dynamic> json) =>
      _$ErrorResponseFromJson(json);

  @override
  List<Object?> get props => [message, status, data];
}
