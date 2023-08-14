import 'package:dr_purple/core/features/data/remote_data_source/models/responses/base_response_model.dart';
import 'package:dr_purple/features/auth/domain/entities/forget_password_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'forget_password_api_response.g.dart';

@JsonSerializable()
class ForgetPasswordAPIResponse extends BaseResponseModel {
  ForgetPasswordAPIResponse();

  factory ForgetPasswordAPIResponse.fromJson(Map<String, dynamic> json) =>
      _$ForgetPasswordAPIResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ForgetPasswordAPIResponseToJson(this);

  @override
  ForgetPasswordEntity toEntity() => ForgetPasswordEntity();
}
