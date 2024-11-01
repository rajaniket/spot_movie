import 'package:dio/dio.dart';
import 'logger_service/logging_interceptor.dart';

class NetworkService {
  NetworkService({
    required Dio dio,
  }) : _dio = dio {
    _dio
      ..options = BaseOptions(
        connectTimeout: const Duration(seconds: 2),
        receiveTimeout: const Duration(seconds: 2),
        contentType: 'application/json',
      )
      ..interceptors.add(LoggingInterceptor());
  }

  final Dio _dio;

  /// GET request
  Future<Response<dynamic>> getRequest({
    required String endpoint,
    Map<String, dynamic>? queryParams,
  }) async {
    final response =
        await _dio.get<dynamic>(endpoint, queryParameters: queryParams);
    return response;
  }

  /// POST request
  Future<Response<dynamic>> postRequest({
    required String endpoint,
    required Map<String, dynamic> data,
  }) async {
    final response = await _dio.post<dynamic>(endpoint, data: data);
    return response;
  }
}
