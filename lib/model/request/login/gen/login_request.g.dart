// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../login_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LoginRequestImpl _$$LoginRequestImplFromJson(Map<String, dynamic> json) =>
    _$LoginRequestImpl(
      password: json['password'] as String? ?? '',
      userCode: json['userCode'] as String? ?? '',
    );

Map<String, dynamic> _$$LoginRequestImplToJson(_$LoginRequestImpl instance) =>
    <String, dynamic>{
      'password': instance.password,
      'userCode': instance.userCode,
    };
