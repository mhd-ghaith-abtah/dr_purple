import 'package:dr_purple/core/features/data/remote_data_source/models/responses/base_response_model.dart';
import 'package:dr_purple/features/settings/domain/entities/get_profile_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_profile_api_response.g.dart';

@JsonSerializable()
class GetProfileAPIResponse extends BaseResponseModel {
  @JsonKey(name: "data")
  GetProfileAPIResult? result;

  GetProfileAPIResponse({required this.result});

  factory GetProfileAPIResponse.fromJson(Map<String, dynamic> json) =>
      _$GetProfileAPIResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$GetProfileAPIResponseToJson(this);

  @override
  GetProfileEntity toEntity() => GetProfileEntity(
        id: result?.id,
        firstName: result?.firstName,
        lastName: result?.lastName,
        userName: result?.userName,
        email: result?.email,
        contactNumber: result?.contactNumber,
        address: result?.address,
        role: result?.role,
        gender: result?.gender,
        profilePicPath: result?.profilePicPath,
      );
}

@JsonSerializable()
class GetProfileAPIResult {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "firstName")
  String? firstName;
  @JsonKey(name: "lastName")
  String? lastName;
  @JsonKey(name: "userName")
  String? userName;
  @JsonKey(name: "email")
  String? email;
  @JsonKey(name: "contactNumber")
  String? contactNumber;
  @JsonKey(name: "address")
  String? address;
  @JsonKey(name: "role")
  int? role;
  @JsonKey(name: "gender")
  int? gender;
  @JsonKey(name: "profilePicPath")
  String? profilePicPath;

  GetProfileAPIResult({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.email,
    required this.contactNumber,
    required this.address,
    required this.role,
    required this.gender,
    required this.profilePicPath,
  });

  factory GetProfileAPIResult.fromJson(Map<String, dynamic> json) =>
      _$GetProfileAPIResultFromJson(json);

  Map<String, dynamic> toJson() => _$GetProfileAPIResultToJson(this);
}
