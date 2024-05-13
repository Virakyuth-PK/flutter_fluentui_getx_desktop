import 'package:freezed_annotation/freezed_annotation.dart';

part 'gen/login_request.freezed.dart';
part 'gen/login_request.g.dart';


@freezed
class LoginRequest with _$LoginRequest {
  const LoginRequest._();

  const factory LoginRequest({
      @JsonKey(name: 'password') @Default('')  String password,
      @JsonKey(name: 'userCode') @Default('')  String userCode,
    }) = _LoginRequest;
  
  factory LoginRequest.fromJson(Map<String, dynamic> json) => _$LoginRequestFromJson(json);

}