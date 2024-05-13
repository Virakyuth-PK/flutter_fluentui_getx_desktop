import 'package:fluent_ui/fluent_ui.dart';

import 'enum_end_point.dart';

@immutable
class ApiEndpoint {
  static const String version = "1";
  static const String suffix = "/api/v$version";

  static String auth(AuthEndpoint endPoint) {
    var path = 'https://uat.chipmong.com:8787/dmscmicapi$suffix/Authentication';
    switch (endPoint) {
      case AuthEndpoint.LOGIN:
        return '$path/Login';
      case AuthEndpoint.REFRESH_TOKEN:
        return '$path/RefreshToken';
    }
  }

  static String getList(GetList endPoint) {
    var path = 'https://pokeapi.co/api/v2/pokemon/ditto';
    return '$path';
  }
}
