// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_profile_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateProfileParamsBody _$UpdateProfileParamsBodyFromJson(
        Map<String, dynamic> json) =>
    UpdateProfileParamsBody(
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      userName: json['userName'] as String?,
      password: json['password'] as String?,
      contactNumber: json['contactNumber'] as String?,
      gender: json['gender'] as int?,
      email: json['email'] as String?,
      address: json['address'] as String?,
      id: json['id'] as int?,
    );

Map<String, dynamic> _$UpdateProfileParamsBodyToJson(
        UpdateProfileParamsBody instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'userName': instance.userName,
      'password': instance.password,
      'contactNumber': instance.contactNumber,
      'email': instance.email,
      'gender': instance.gender,
      'address': instance.address,
      'id': instance.id,
    };
