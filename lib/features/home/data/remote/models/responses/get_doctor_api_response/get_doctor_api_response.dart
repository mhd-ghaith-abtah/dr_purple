import 'package:dr_purple/core/features/data/remote_data_source/models/responses/base_response_model.dart';
import 'package:dr_purple/features/home/domain/entities/get_doctor_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_doctor_api_response.g.dart';

@JsonSerializable()
class GetDoctorAPIResponse extends BaseResponseModel {
  @JsonKey(name: "data")
  GetDoctorAPIResult? result;

  GetDoctorAPIResponse({required this.result});

  factory GetDoctorAPIResponse.fromJson(Map<String, dynamic> json) =>
      _$GetDoctorAPIResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$GetDoctorAPIResponseToJson(this);

  @override
  GetDoctorEntity toEntity() => GetDoctorEntity(
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
class GetDoctorAPIResult {
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

  GetDoctorAPIResult({
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

  factory GetDoctorAPIResult.fromJson(Map<String, dynamic> json) =>
      _$GetDoctorAPIResultFromJson(json);

  Map<String, dynamic> toJson() => _$GetDoctorAPIResultToJson(this);
}
