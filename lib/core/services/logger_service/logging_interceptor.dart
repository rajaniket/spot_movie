import 'dart:convert';
import 'package:dio/dio.dart';

import 'logger_service.dart';

/// Custom interceptor for logging Dio requests and responses using Logger.
class LoggingInterceptor extends Interceptor {
  static const JsonDecoder _jsonDecoder = JsonDecoder();
  static const JsonEncoder _jsonEncoder = JsonEncoder.withIndent('  ');

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final logBuffer = StringBuffer()
      ..writeln('--- Dio Request ---')
      ..writeln('Request URI: ${options.uri}')
      ..writeln('HTTP Method: ${options.method}')
      ..writeln('Response Type: ${options.responseType}')
      ..writeln('Redirects Followed: ${options.followRedirects}')
      ..writeln('Connection Timeout: ${options.connectTimeout}')
      ..writeln('Receive Timeout: ${options.receiveTimeout}')
      ..writeln('Additional Info: ${options.extra}')
      ..writeln('Request Headers: ${options.headers}')
      ..writeln('Request Body:');

    if (options.data != null) {
      logBuffer.writeln(options.data.toString());
    }

    Log.i(logBuffer.toString());
    return handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final errorLogBuffer = StringBuffer()
      ..writeln('--- Dio Error ---')
      ..writeln('$err');

    if (err.response != null) {
      _logResponse(err.response!, errorLogBuffer);
    }

    Log.e(errorLogBuffer.toString());
    return handler.next(err);
  }

  @override
  Future<void> onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) async {
    final responseLogBuffer = StringBuffer()..writeln('--- Dio Response ---');
    _logResponse(response, responseLogBuffer);
    Log.i(responseLogBuffer.toString());
    return handler.next(response);
  }

  void _logResponse(Response<dynamic> response, StringBuffer logBuffer) {
    logBuffer
      ..writeln('Request URI: ${response.requestOptions.uri}')
      ..writeln('Status Code: ${response.statusCode}');

    if (response.isRedirect == true) {
      logBuffer.writeln('Redirected to: ${response.realUri}');
    }

    logBuffer
      ..writeln('Response Headers: ${response.requestOptions.headers}')
      ..writeln('Response Content:');

    final responseContent = response.toString();
    try {
      final decodedResponse = _jsonDecoder.convert(responseContent);
      final prettyJsonResponse = _jsonEncoder.convert(decodedResponse);
      logBuffer.writeln(prettyJsonResponse);
    } catch (e) {
      logBuffer.writeln('Failed to parse response as JSON: $responseContent');
    }
  }
}
