import 'package:dio/dio.dart';
import 'app_exceptions.dart';

class DioExceptionHandler {
  static AppException handle(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return AppException(message: "Connection timeout. Please try again.");
      case DioExceptionType.sendTimeout:
        return AppException(message: "Send timeout. Check your internet.");
      case DioExceptionType.receiveTimeout:
        return AppException(message: "Receive timeout. Please retry.");
      case DioExceptionType.badResponse:
        return _handleBadResponse(error);
      case DioExceptionType.cancel:
        return AppException(message: "Request was cancelled.");
      case DioExceptionType.unknown:
        if (error.message?.contains("SocketException") ?? false) {
          return AppException(message: "No Internet connection.");
        }
        return AppException(message: "Unexpected error occurred.");
      default:
        return AppException(message: "Something went wrong. Please try again.");
    }
  }

  static AppException _handleBadResponse(DioException error) {
    final statusCode = error.response?.statusCode;
    final data = error.response?.data;
    String message = "Unexpected server error.";

    if (data is Map && data.containsKey('message')) {
      message = data['message'];
    } else {
      switch (statusCode) {
        case 400:
          message = "Bad request.";
          break;
        case 401:
          message = "Unauthorized. Please login again.";
          break;
        case 403:
          message = "Access forbidden.";
          break;
        case 404:
          message = "Not found.";
          break;
        case 500:
          message = "Internal server error.";
          break;
      }
    }

    return AppException(
      message: message,
      statusCode: statusCode,
      details: data,
    );
  }
}
