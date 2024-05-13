import 'package:freezed_annotation/freezed_annotation.dart';

part 'gen/login_response.freezed.dart';
part 'gen/login_response.g.dart';

@unfreezed
class LoginResponse with _$LoginResponse {
  const LoginResponse._();

  const factory LoginResponse({
    @JsonKey(name: 'statusCode') @Default(0) int statusCode,
    @JsonKey(name: 'userId') @Default(0) int userId,
    @JsonKey(name: 'userName') @Default('') String userName,
    @JsonKey(name: 'token') @Default('') String token,
    @JsonKey(name: 'refreshToken') @Default('') String refreshToken,
    @JsonKey(name: 'expiration') @Default('') String expiration,
    @JsonKey(name: 'message') @Default('') String message,
    @JsonKey(name: 'isActive') @Default(false) bool isActive,
  }) = _LoginResponse;

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);
}
