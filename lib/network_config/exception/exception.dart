abstract class BaseException implements Exception {
  String? code;
  String? message;

  BaseException(this.code, this.message);

  @override
  String toString() {
    Object? message = this.message;
    return "$runtimeType: $message";
  }
}

class NetworkException extends BaseException {
  NetworkException({String? code, String? message}) : super(code, message);
}

class ApiException extends BaseException {
  ApiException({String? code, String? message}) : super(code, message);
}

class CacheException extends BaseException {
  CacheException(String? code, String? message) : super(code, message);
}

class AppException extends BaseException {
  AppException({String? code, String? message}) : super(code, message);
}
