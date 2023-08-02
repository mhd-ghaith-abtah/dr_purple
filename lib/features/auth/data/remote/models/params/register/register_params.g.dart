// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterParamsBody _$RegisterParamsBodyFromJson(Map<String, dynamic> json) =>
    RegisterParamsBody(
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      userName: json['userName'] as String?,
      password: json['password'] as String?,
      contactNumber: json['contactNumber'] as String?,
      gender: json['gender'] as int?,
      email: json['email'] as String?,
    );

Map<String, dynamic> _$RegisterParamsBodyToJson(RegisterParamsBody instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'userName': instance.userName,
      'password': instance.password,
      'contactNumber': instance.contactNumber,
      'email': instance.email,
      'gender': instance.gender,
    };
