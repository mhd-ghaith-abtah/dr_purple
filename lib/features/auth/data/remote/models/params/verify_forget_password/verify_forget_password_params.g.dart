// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_forget_password_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyForgetPasswordParamsBody _$VerifyForgetPasswordParamsBodyFromJson(
        Map<String, dynamic> json) =>
    VerifyForgetPasswordParamsBody(
      mobileNumber: json['contactNumber'] as String?,
      code: json['code'] as String?,
      newPassword: json['password'] as String?,
    );

Map<String, dynamic> _$VerifyForgetPasswordParamsBodyToJson(
        VerifyForgetPasswordParamsBody instance) =>
    <String, dynamic>{
      'contactNumber': instance.mobileNumber,
      'code': instance.code,
      'password': instance.newPassword,
    };
