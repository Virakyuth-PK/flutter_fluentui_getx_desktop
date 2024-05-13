import 'package:flutter_fluentui_getx_desktop/model/login/login_response.dart';
import 'package:get/get.dart';

class LoginState {
  RxBool isLogin = false.obs;
  LoginResponse loginResponse = LoginResponse().obs();
}
