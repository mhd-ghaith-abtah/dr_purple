import 'package:dr_purple/core/features/data/remote_data_source/models/responses/base_response_model.dart';
import 'package:dr_purple/features/settings/domain/entities/update_profile_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'update_profile_api_response.g.dart';

@JsonSerializable()
class UpdateProfileAPIResponse extends BaseResponseModel {
  UpdateProfileAPIResponse();

  factory UpdateProfileAPIResponse.fromJson(Map<String, dynamic> json) =>
      _$UpdateProfileAPIResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UpdateProfileAPIResponseToJson(this);

  @override
  UpdateProfileEntity toEntity() => UpdateProfileEntity();
}
