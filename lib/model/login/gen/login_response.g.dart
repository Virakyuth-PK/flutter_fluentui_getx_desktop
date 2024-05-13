// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LoginResponseImpl _$$LoginResponseImplFromJson(Map<String, dynamic> json) =>
    _$LoginResponseImpl(
      statusCode: (json['statusCode'] as num?)?.toInt() ?? 0,
      userId: (json['userId'] as num?)?.toInt() ?? 0,
      userName: json['userName'] as String? ?? '',
      token: json['token'] as String? ?? '',
      refreshToken: json['refreshToken'] as String? ?? '',
      expiration: json['expiration'] as String? ?? '',
      message: json['message'] as String? ?? '',
      isActive: json['isActive'] as bool? ?? false,
    );

Map<String, dynamic> _$$LoginResponseImplToJson(_$LoginResponseImpl instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'userId': instance.userId,
      'userName': instance.userName,
      'token': instance.token,
      'refreshToken': instance.refreshToken,
      'expiration': instance.expiration,
      'message': instance.message,
      'isActive': instance.isActive,
    };
