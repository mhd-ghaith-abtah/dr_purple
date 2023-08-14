import 'package:dr_purple/core/features/data/remote_data_source/models/responses/base_response_model.dart';
import 'package:dr_purple/features/settings/domain/entities/change_language_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'change_language_api_response.g.dart';

@JsonSerializable()
class ChangeLanguageAPIResponse extends BaseResponseModel {
  ChangeLanguageAPIResponse();

  factory ChangeLanguageAPIResponse.fromJson(Map<String, dynamic> json) =>
      _$ChangeLanguageAPIResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ChangeLanguageAPIResponseToJson(this);

  @override
  ChangeLanguageEntity toEntity() => ChangeLanguageEntity();
}
