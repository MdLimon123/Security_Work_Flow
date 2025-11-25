class AppException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic details;

  AppException({required this.message, this.statusCode, this.details});

  @override
  String toString() =>
      "AppException(statusCode: $statusCode, message: $message)";
}
