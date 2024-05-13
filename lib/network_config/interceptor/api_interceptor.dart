
  import 'package:http/http.dart' as http;

  import 'interceptor_client.dart';

  class ApiInterceptor implements RequestInterceptor, ResponseInterceptor {
    late String _accessToken;

    @override
    Future<http.BaseRequest> interceptRequest(http.BaseRequest request) async {
      // Modify request headers, body, etc. as needed
      request.headers['Authorization'] = 'Bearer $_accessToken';

      return request;
    }

    @override
    Future<http.StreamedResponse> interceptResponse(
        http.StreamedResponse response) async {
      // Handle response data, error, etc.
      final statusCode = response.statusCode;

      switch (statusCode) {
        case 401:
          return (await _unauthorizedHandler(response));
        default:
          return response;
      }
    }

    // Define your token refreshing logic here
    Future<String> refreshToken() async {
      // This is a placeholder, you need to implement actual logic to refresh the token
      return 'NewAccessToken';
    }

    Future<http.StreamedResponse> _retryRequest(
        http.BaseRequest originalRequest) async {
      if (originalRequest is http.Request) {
        final newRequest =
            http.Request(originalRequest.method, originalRequest.url);

        newRequest.headers.addAll(originalRequest.headers);
        newRequest.body = originalRequest.body;
        newRequest.encoding = originalRequest.encoding;

        return await http.Client().send(newRequest);
      } else if (originalRequest is http.StreamedRequest) {
        final newRequest =
            http.StreamedRequest(originalRequest.method, originalRequest.url);

        newRequest.headers.addAll(originalRequest.headers);
        await originalRequest.finalize().pipe(newRequest.sink);

        return await http.Client().send(newRequest);
      } else {
        throw ArgumentError(
            'Unsupported request type: ${originalRequest.runtimeType}');
      }
    }

    Future<http.StreamedResponse> _unauthorizedHandler(
        http.StreamedResponse response) async {
      // attempt to refresh the token
      _accessToken = await refreshToken();

      // Retry the original request with the new token
      return (await _retryRequest(response.request!));
    }
  }
