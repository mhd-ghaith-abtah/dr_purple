// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_password_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChangePasswordParamsBody _$ChangePasswordParamsBodyFromJson(
        Map<String, dynamic> json) =>
    ChangePasswordParamsBody(
      newPassword: json['newPassword'] as String?,
      oldPassword: json['oldPassword'] as String?,
    );

Map<String, dynamic> _$ChangePasswordParamsBodyToJson(
        ChangePasswordParamsBody instance) =>
    <String, dynamic>{
      'newPassword': instance.newPassword,
      'oldPassword': instance.oldPassword,
    };
