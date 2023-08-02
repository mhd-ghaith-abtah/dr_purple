// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'refresh_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RefreshParamsBody _$RefreshParamsBodyFromJson(Map<String, dynamic> json) =>
    RefreshParamsBody(
      accessToken: json['accessToken'] as String?,
      refreshToken: json['refreshToken'] as String?,
    );

Map<String, dynamic> _$RefreshParamsBodyToJson(RefreshParamsBody instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
    };
