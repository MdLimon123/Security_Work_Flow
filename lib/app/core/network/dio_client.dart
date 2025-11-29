import 'package:dio/dio.dart';
import 'package:flutter_security_workforce/app/core/constants/app_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../errors/app_exceptions.dart';
import '../errors/dio_exception_handler.dart';

class DioClient {
  final Dio _dio;

  DioClient({String? baseUrl})
    : _dio = Dio(
        BaseOptions(
          baseUrl: baseUrl ?? "",
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
          sendTimeout: const Duration(seconds: 10),
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json",
          },
        ),
      ) {
    // 👉 LogInterceptor (you already had)
    _dio.interceptors.add(
      LogInterceptor(requestBody: true, responseBody: true),
    );

    // 👉 Global Token Interceptor (NEW)
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final prefs = await SharedPreferences.getInstance();
          final token = prefs.getString(AppKeys.accessTokenKey);

          if (token != null && token.isNotEmpty) {
            options.headers["Authorization"] = "Bearer $token";
          }

          return handler.next(options);
        },
      ),
    );
  }

  Future<dynamic> get(
    String endpoint, {
    Map<String, dynamic>? queryParams,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await _dio.get(
        endpoint,
        queryParameters: queryParams,
        options: Options(headers: headers),
      );
      return response.data;
    } on DioException catch (e) {
      throw DioExceptionHandler.handle(e);
    } catch (e) {
      throw AppException(message: "Unexpected error: $e");
    }
  }

  Future<dynamic> post(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParams,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await _dio.post(
        endpoint,
        data: data,
        queryParameters: queryParams,
        options: Options(headers: headers),
      );
      return response.data;
    } on DioException catch (e) {
      throw DioExceptionHandler.handle(e);
    } catch (e) {
      throw AppException(message: "Unexpected error: $e");
    }
  }

  Future<dynamic> put(
    String endpoint, {
    dynamic data,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await _dio.put(
        endpoint,
        data: data,
        options: Options(headers: headers),
      );
      return response.data;
    } on DioException catch (e) {
      throw DioExceptionHandler.handle(e);
    } catch (e) {
      throw AppException(message: "Unexpected error: $e");
    }
  }

  Future<dynamic> delete(
    String endpoint, {
    dynamic data,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await _dio.delete(
        endpoint,
        data: data,
        options: Options(headers: headers),
      );
      return response.data;
    } on DioException catch (e) {
      throw DioExceptionHandler.handle(e);
    } catch (e) {
      throw AppException(message: "Unexpected error: $e");
    }
  }
}
