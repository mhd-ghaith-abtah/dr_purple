import 'package:dr_purple/core/features/data/remote_data_source/models/responses/base_response_model.dart';
import 'package:dr_purple/features/home/domain/entities/get_service_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_service_api_response.g.dart';

@JsonSerializable()
class GetServiceAPIResponse extends BaseResponseModel {
  GetServiceAPIResponse();

  factory GetServiceAPIResponse.fromJson(Map<String, dynamic> json) =>
      _$GetServiceAPIResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$GetServiceAPIResponseToJson(this);

  @override
  GetServiceEntity toEntity() => GetServiceEntity();
}
