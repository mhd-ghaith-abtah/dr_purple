// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_profile_api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetProfileAPIResponse _$GetProfileAPIResponseFromJson(
        Map<String, dynamic> json) =>
    GetProfileAPIResponse(
      result: json['data'] == null
          ? null
          : GetProfileAPIResult.fromJson(json['data'] as Map<String, dynamic>),
    )
      ..succsess = json['succsess'] as bool?
      ..messageId = json['messageId'] as int?
      ..message = json['message'] as String?;

Map<String, dynamic> _$GetProfileAPIResponseToJson(
        GetProfileAPIResponse instance) =>
    <String, dynamic>{
      'succsess': instance.succsess,
      'messageId': instance.messageId,
      'message': instance.message,
      'data': instance.result,
    };

GetProfileAPIResult _$GetProfileAPIResultFromJson(Map<String, dynamic> json) =>
    GetProfileAPIResult(
      id: json['id'] as int?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      userName: json['userName'] as String?,
      email: json['email'] as String?,
      contactNumber: json['contactNumber'] as String?,
      address: json['address'] as String?,
      role: json['role'] as int?,
      gender: json['gender'] as int?,
      profilePicPath: json['profilePicPath'] as String?,
    );

Map<String, dynamic> _$GetProfileAPIResultToJson(
        GetProfileAPIResult instance) =>
    <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'userName': instance.userName,
      'email': instance.email,
      'contactNumber': instance.contactNumber,
      'address': instance.address,
      'role': instance.role,
      'gender': instance.gender,
      'profilePicPath': instance.profilePicPath,
    };
