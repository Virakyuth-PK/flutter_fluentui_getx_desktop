import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class InterceptorClient extends http.BaseClient {
  final http.Client _inner;
  final RequestInterceptor? requestInterceptor;
  final ResponseInterceptor? responseInterceptor;

  InterceptorClient(this._inner,
      {this.requestInterceptor, this.responseInterceptor});

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    // Intercept the request if interceptor is provided
    if (requestInterceptor != null) {
      request = await requestInterceptor!.interceptRequest(request);
    }

    // Log the request
    if (kDebugMode) {
      _logRequest(request);
    }

    // Send the request and get the response
    final response = await _inner.send(request);

    // Log the response
    if (kDebugMode) {
      _logResponse(response);
    }

    // Intercept the response if interceptor is provided
    if (responseInterceptor != null) {
      return responseInterceptor!.interceptResponse(response);
    }

    return response;
  }

  void _logRequest(http.BaseRequest request) {
    Logger().d('Log Request 🇰🇭🛫'
        '\nRequest: ${request.method} ${request.url}'
        '\nHeaders: ${request.headers}'
        '\nBody: ${request is http.Request ? (request).body : 'Streamed'}');
  }

  void _logResponse(http.StreamedResponse response) {
    Logger().d('Log Response 🇰🇭🛬'
        '\nRequest: ${response.request?.method} ${response.request?.url}'
        '\nHeaders: ${response.headers}'
        '\nResponse Status: ${response.statusCode} ${response.reasonPhrase}');
  }
}

abstract class RequestInterceptor {
  Future<http.BaseRequest> interceptRequest(http.BaseRequest request);
}

abstract class ResponseInterceptor {
  Future<http.StreamedResponse> interceptResponse(
      http.StreamedResponse response);
}
