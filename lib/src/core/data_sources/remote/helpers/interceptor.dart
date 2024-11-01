import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import '../../../../../generated/locale_keys.g.dart';
import '../../../../utils/app_notifications.dart';

import '../../local/local_storage.dart';
import '../api_response.dart';

class RemoteInterceptor extends InterceptorsWrapper {
  RemoteInterceptor(LocalStorage storageProvider)
      : super(
          onRequest: (options, handler) async {
            final headers = <String, String>{
              "Accept": "application/json",
            };
            final customOptions = options;
            customOptions.headers = headers;
            final token = storageProvider.token;
            if (token != null) {
              customOptions.headers['Authorization'] = 'Bearer $token';
            }
            final connectivityResult = await Connectivity().checkConnectivity();
            // Todo

            interceptorLog(
                'REQUEST CONNECTIVITY : ${connectivityResult.first.name}');
            if (connectivityResult.contains(ConnectivityResult.none)) {
              return handler.resolve(
                Response(
                  requestOptions: customOptions,
                  data: _handleErrorResponse(null).toJson(),
                ),
              );
            }

            return handler.next(customOptions);
          },
          onResponse: (response, handler) async {
            debugPrint('Response: $response');
            if (response.data is String) {
              return handler.resolve(
                Response(
                  data: ApiResponse.success(data: response.data).toJson(),
                  requestOptions: response.requestOptions,
                ),
              );
            }
            if (response.statusCode! >= 400) {
              return handler.resolve(
                Response(
                  data: ApiResponse.error(message: response.data['message'])
                      .toJson(),
                  requestOptions: response.requestOptions,
                ),
              );
            }

            if (response.data is Map &&
                (response.data['success'] == null ||
                    (response.data as Map).containsKey('success'))) {
              Map<String, dynamic> data =
                  (response.data as Map<String, dynamic>);
              data.addAll({"success": response.statusCode.isSuccess});
              response = response.copyWith(data: data);
            }
            return handler.next(response);
          },
          onError: (error, handler) {
            debugPrint('Error: $error');
            debugPrint('Error Response: ${error.response}');
            Map<String, dynamic> data = _handleErrorResponse(error.response,
                    path: error.requestOptions.path)
                .toJson();

            int? statusCode = error.response!.statusCode;
            if (error.response != null && !statusCode.isSuccess) {
              data.addAll({"success": false});
            }
            return handler.resolve(
              Response(
                requestOptions: error.requestOptions,
                data: data,
              ),
            );
          },
        );

  static ApiResponse _handleErrorResponse(Response? response, {String? path}) {
    if (response == null) {
      return ApiResponse.error(
        message: LocaleKeys.no_connection.tr(),
        error: null,
      );
    }
    switch (response.statusCode) {
      case 401:
        return ApiResponse.error(message: 'unauthorized');
      case 400:
        return ApiResponse.error(
            message: response.data['message'], data: {'success': false});

      case 500:
        ApiResponse res = ApiResponse.error(
            message: 'Internal server error', error: response.data);
        AppNotifications.showError(message: res.message!);
        return res;

      default:
        return ApiResponse.error(
          error: response.data,
          message: 'Unknown Exception',
        );
    }
  }
}

interceptorLog(String message) => log('[INTERCEPTOR]=> $message');

extension CopyResponse on Response {
  copyWith({
    RequestOptions? requestOptions,
    Map<String, dynamic>? extra,
    Object? data,
    Headers? headers,
    bool? isRedirect,
    List<RedirectRecord>? redirects,
    int? statusCode,
    String? statusMessage,
  }) {
    return Response(
      requestOptions: requestOptions ?? this.requestOptions,
      extra: extra ?? this.extra,
      data: data ?? this.data,
      headers: headers ?? this.headers,
      isRedirect: isRedirect ?? this.isRedirect,
      redirects: redirects ?? this.redirects,
      statusCode: statusCode ?? this.statusCode,
      statusMessage: statusMessage ?? this.statusMessage,
    );
  }
}

extension IsSuccess on int? {
  bool get isSuccess => this != null && (this! >= 200 && this! < 300);
}
