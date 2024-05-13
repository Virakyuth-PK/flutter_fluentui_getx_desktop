import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';

import '../data/network/api_endpoint.dart';
import '../data/network/enum_end_point.dart';
import '../model/login/login_response.dart';
import '../model/request/login/login_request.dart';
import '../network_config/api_handler.dart';
import 'state.dart';

class LoginLogic extends GetxController {
  final LoginState state = LoginState();
  void isLoggedIn(bool isLogin) {
    // Implement your login logic here
    // For now, just return true if the user is logged in
    state.isLogin.value = isLogin;
    update();
  }

  //region Sample Call Api
  login() async {
    ApiHandler<LoginResponse> handler =
        ApiHandler.post(converter: LoginResponse.fromJson);
    await handler.execute(
        body: const LoginRequest(userCode: "90015979", password: "12345")
            .toJson(),
        endPoint: ApiEndpoint.auth(AuthEndpoint.LOGIN),
        onComplete: (LoginResponse data) {
          Logger().i(data.token);
          state.loginResponse = data;
          isLoggedIn(true);
        });
  }
}
