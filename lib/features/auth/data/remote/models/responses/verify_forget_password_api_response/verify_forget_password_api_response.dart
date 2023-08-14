import 'package:dr_purple/core/features/data/remote_data_source/models/responses/base_response_model.dart';
import 'package:dr_purple/features/auth/domain/entities/verify_forget_password_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'verify_forget_password_api_response.g.dart';

@JsonSerializable()
class VerifyForgetPasswordAPIResponse extends BaseResponseModel {
  VerifyForgetPasswordAPIResponse();

  factory VerifyForgetPasswordAPIResponse.fromJson(Map<String, dynamic> json) =>
      _$VerifyForgetPasswordAPIResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() =>
      _$VerifyForgetPasswordAPIResponseToJson(this);

  @override
  VerifyForgetPasswordEntity toEntity() => VerifyForgetPasswordEntity();
}
