import 'dart:async';
import 'dart:convert';

import '../network_config/interceptor/interceptor_client.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import 'exception/exception_handler.dart';
import 'http_client.dart';
import 'method.dart';
import 'typedefs.dart';

class ApiHandler<T> {
  final T Function(JSON value) converter;
  final String method;

  ApiHandler({
    required this.method,
    required this.converter,
  });

  //region Method
  factory ApiHandler.get({
    required T Function(JSON value) converter,
  }) =>
      ApiHandler<T>(converter: converter, method: Method.GET);

  factory ApiHandler.post({
    required T Function(JSON value) converter,
  }) =>
      ApiHandler<T>(converter: converter, method: Method.POST);

  factory ApiHandler.put({
    required T Function(JSON value) converter,
  }) =>
      ApiHandler<T>(converter: converter, method: Method.PUT);

  factory ApiHandler.patch({
    required T Function(JSON value) converter,
  }) =>
      ApiHandler<T>(converter: converter, method: Method.PATCH);

  factory ApiHandler.delete({
    required T Function(JSON value) converter,
  }) =>
      ApiHandler<T>(converter: converter, method: Method.DELETE);

  factory ApiHandler.head({
    required T Function(JSON value) converter,
  }) =>
      ApiHandler<T>(converter: converter, method: Method.HEAD);

  factory ApiHandler.options({
    required T Function(JSON value) converter,
  }) =>
      ApiHandler<T>(converter: converter, method: Method.OPTIONS);

  //endregion

  Future<T?> execute({
    required OnComplete<T> onComplete,
    OnFail? onFail,
    Future<void> Function()? onFinished,
    bool isAuthenticated =
        false, // Condition to switch between authenticated and normal client,
    required String endPoint,
    JSON? body, // Parameter for JSON body
    JSON? formData, // Parameter for multipart form data
    JSON? queryParams, // Parameter for URL query parameters
  }) async {
    final client = isAuthenticated
        ? AuthHttpClient(InterceptorClient(http.Client()), token: '')
        : NormalHttpClient(InterceptorClient(http.Client()));

    try {
      //region Set Up Body
      http.BaseRequest request = http.Request(method, Uri.parse(endPoint));

      if (body != null) {
        request = http.Request(method, Uri.parse(endPoint))
          ..headers['Content-Type'] = 'application/json'
          ..body = jsonEncode(body);
      } else if (formData != null) {
        final multipartRequest =
            http.MultipartRequest(method, Uri.parse(endPoint));
        formData.forEach((key, value) {
          if (value is List<http.MultipartFile>) {
            for (final file in value) {
              multipartRequest.files.add(file);
            }
          } else {
            multipartRequest.fields[key] = value.toString();
          }
        });
        request = multipartRequest;
      }
      if (queryParams != null) {
        final uri = Uri.parse(endPoint).replace(queryParameters: queryParams);
        request = http.Request(method, uri);
      }
      //endregion

      final response = await client.send(request);
      final responseBody = await _streamToByte(response.stream);
      final jsonResponse = jsonDecode(responseBody);
      T data = converter(jsonResponse);
      await onComplete(data);
    } catch (error, stack) {
      Logger().e("$error\n$stack");
      if (onFail != null) {
        await onFail(ExceptionHandler.handle(error));
      }
    } finally {
      client.close(); // Close the client when finished
      if (onFinished != null) {
        await onFinished();
      }
    }
    return null;
  }

  Future<String> _streamToByte(Stream<List<int>> stream) async {
    final bytes = <int>[];

    await for (final chunk in stream) {
      bytes.addAll(chunk);
    }

    return utf8.decode(bytes);
  }
}
