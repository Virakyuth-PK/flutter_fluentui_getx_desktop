import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'exception.dart';

class ExceptionHandler {
  static BaseException handle(dynamic error) {
    if (error is http.ClientException) {
      return NetworkException(
          code: 'NO_INTERNET_CONNECTION', message: "No Internet Connection");
    } else if (error is SocketException) {
      return NetworkException(
          code: 'NO_INTERNET_CONNECTION', message: "No Internet Connection");
    } else if (error is TimeoutException) {
      return NetworkException(
          code: 'CONNECTION_TIMEOUT', message: "Connection Timeout");
    } else if (error is http.Response) {
      switch (error.statusCode) {
        case 400:
          return ApiException(
              code: error.statusCode.toString(),
              message: getErrorMessage(error.body, "Bad Request"));
        case 401:
          return ApiException(
              code: error.statusCode.toString(),
              message: getErrorMessage(error.body, "Unauthorised Request"));
        case 403:
          return ApiException(
              code: error.statusCode.toString(),
              message: getErrorMessage(error.body, "Request Forbidden"));
        case 404:
          return ApiException(
              code: error.statusCode.toString(),
              message: getErrorMessage(error.body, "Request Not Found"));
        case 409:
          return ApiException(
              code: error.statusCode.toString(),
              message: getErrorMessage(error.body, "Request Conflict"));
        case 408:
          return ApiException(
              code: error.statusCode.toString(),
              message: getErrorMessage(error.body, "Request Timeout"));
        case 422:
          return ApiException(
              code: error.statusCode.toString(),
              message: "Un-processable Entity");
        case 500:
          return ApiException(
              code: error.statusCode.toString(),
              message: "Internal Server Error");
        case 501:
          return ApiException(
              code: error.statusCode.toString(),
              message: "Server Not Implemented");
        case 502:
          return ApiException(
              code: error.statusCode.toString(),
              message: "Service Unavailable");
        case 503:
          return ApiException(
              code: error.statusCode.toString(),
              message: "Service Unavailable");
        case 504:
          return ApiException(
              code: error.statusCode.toString(), message: "Gate Way Time Out");
        case 204:
          return ApiException(
              code: error.statusCode.toString(), message: "No Content");
        default:
          return ApiException(
              code: error.statusCode.toString(),
              message: getErrorMessage(error.body, "Response Unknown"));
      }
    } else {
      // For other types of errors, include the actual error message
      return AppException(message: error.toString());
    }
  }

  static String getErrorMessage(dynamic data, String defaultMessage) {
    String error = defaultMessage;
    if (data is Map?) {
      if (data?["message"] is String) {
        error = data?["message"];
      } else if (data?["Message"] is String) {
        error = data?["Message"];
      }
    }
    return error;
  }
}
