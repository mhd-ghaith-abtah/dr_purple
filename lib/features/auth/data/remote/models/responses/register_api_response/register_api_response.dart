import 'package:dr_purple/core/features/data/remote_data_source/models/responses/base_response_model.dart';
import 'package:dr_purple/features/auth/domain/entities/register_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'register_api_response.g.dart';

@JsonSerializable()
class RegisterAPIResponse extends BaseResponseModel {
  RegisterAPIResponse();

  factory RegisterAPIResponse.fromJson(Map<String, dynamic> json) =>
      _$RegisterAPIResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$RegisterAPIResponseToJson(this);

  @override
  RegisterEntity toEntity() => RegisterEntity();
}
