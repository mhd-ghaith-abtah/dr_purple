import 'package:dr_purple/core/features/data/remote_data_source/models/responses/base_response_model.dart';
import 'package:dr_purple/features/auth/domain/entities/logout_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'logout_api_response.g.dart';

@JsonSerializable()
class LogoutAPIResponse extends BaseResponseModel {
  LogoutAPIResponse();

  factory LogoutAPIResponse.fromJson(Map<String, dynamic> json) =>
      _$LogoutAPIResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$LogoutAPIResponseToJson(this);

  @override
  LogoutEntity toEntity() => LogoutEntity();
}
