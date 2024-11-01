import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../enums/api_response_status.dart';
import '../../../error/exceptions.dart';

part 'api_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class ApiResponse<T> {
  ApiResponseStatus? status;
  String? message;
  T? data;
  dynamic error;

  ApiResponse();

  ApiResponse.success({this.message, this.data})
      : status = ApiResponseStatus.success;

  ApiResponse.error({this.message, this.error, this.data})
      : status = ApiResponseStatus.error;

  factory ApiResponse.fromJson(json, Function(Map<String, dynamic>) fromJsonT) {
    if (json['success'] == null) {
      return ApiResponse.error(
        message: 'Server Error Happened, Please try again later',
        error: null,
      );
    }
    try {
      if (!json['success']) {
        return ApiResponse.error(
          message: json['message'],
          error: json['data'],
        );
      } else {
        if (json['success']) {
          return ApiResponse.success(
            message: json['message'],
            data: fromJsonT(json),
          );
        } else {
          if (json['message'] != null) {
            return ApiResponse.error(message: json['message']);
          }
          return ApiResponse.error(message: 'Error Happened, Please try again');
        }
      }
    } catch (error) {
      debugPrint('**********************************');
      debugPrint(error.toString());
      debugPrint('**********************************');
      if (error is JsonObjectSerializeException) {
        return ApiResponse.error(
          message: error.message,
        );
      } else {
        return ApiResponse.error(
          message: error.toString(),
        );
      }
    }
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data,
        "error": error,
      };

  @override
  String toString() {
    return 'ApiResponse{status: $status, message: $message, data: $data, error: $error}';
  }

  bool get hasSuccess => status == ApiResponseStatus.success;

  bool get hasFailed => status == ApiResponseStatus.error;
}
