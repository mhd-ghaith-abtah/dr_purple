import 'package:dr_purple/core/features/data/remote_data_source/models/responses/base_response_model.dart';
import 'package:dr_purple/features/home/domain/entities/get_all_service_time_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_all_service_time_api_response.g.dart';

@JsonSerializable()
class GetAllServiceTimeAPIResponse extends BaseResponseModel {
  GetAllServiceTimeAPIResponse();

  factory GetAllServiceTimeAPIResponse.fromJson(Map<String, dynamic> json) =>
      _$GetAllServiceTimeAPIResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$GetAllServiceTimeAPIResponseToJson(this);

  @override
  GetAllServiceTimeEntity toEntity() => GetAllServiceTimeEntity();
}
