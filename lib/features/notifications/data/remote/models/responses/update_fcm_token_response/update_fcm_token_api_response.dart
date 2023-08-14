import 'package:dr_purple/core/features/data/remote_data_source/models/responses/base_response_model.dart';
import 'package:dr_purple/features/notifications/domain/entities/update_fcm_token_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'update_fcm_token_api_response.g.dart';

@JsonSerializable()
class UpdateFCMTokenAPIResponse extends BaseResponseModel {
  UpdateFCMTokenAPIResponse();

  factory UpdateFCMTokenAPIResponse.fromJson(Map<String, dynamic> json) =>
      _$UpdateFCMTokenAPIResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UpdateFCMTokenAPIResponseToJson(this);

  @override
  UpdateFCMTokenEntity toEntity() =>
      UpdateFCMTokenEntity(accessToken: message ?? "");
}
