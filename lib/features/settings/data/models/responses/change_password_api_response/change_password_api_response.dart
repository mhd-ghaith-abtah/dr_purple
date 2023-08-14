import 'package:dr_purple/core/features/data/remote_data_source/models/responses/base_response_model.dart';
import 'package:dr_purple/features/settings/domain/entities/change_password_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'change_password_api_response.g.dart';

@JsonSerializable()
class ChangePasswordAPIResponse extends BaseResponseModel {
  ChangePasswordAPIResponse();

  factory ChangePasswordAPIResponse.fromJson(Map<String, dynamic> json) =>
      _$ChangePasswordAPIResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ChangePasswordAPIResponseToJson(this);

  @override
  ChangePasswordEntity toEntity() => ChangePasswordEntity();
}
