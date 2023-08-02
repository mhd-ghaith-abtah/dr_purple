import 'package:dr_purple/core/features/data/remote_data_source/models/responses/base_response_model.dart';
import 'package:dr_purple/features/home/domain/entities/get_service_time_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_service_time_api_response.g.dart';

@JsonSerializable()
class GetServiceTimeAPIResponse extends BaseResponseModel {
  @JsonKey(name: "data")
  final List<GetServiceTimeAPIResult>? result;

  GetServiceTimeAPIResponse({required this.result});

  factory GetServiceTimeAPIResponse.fromJson(Map<String, dynamic> json) =>
      _$GetServiceTimeAPIResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$GetServiceTimeAPIResponseToJson(this);

  @override
  GetServiceTimeEntity toEntity() => GetServiceTimeEntity(serviceTimes: result);
}

@JsonSerializable()
class GetServiceTimeAPIResult {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "serviceId")
  final int? serviceId;
  @JsonKey(name: "contractServiceId")
  final int? contractServiceId;
  @JsonKey(name: "date")
  final String? date;
  @JsonKey(name: "startTime")
  final String? startTime;
  @JsonKey(name: "endTime")
  final String? endTime;
  @JsonKey(name: "state")
  final String? state;

  GetServiceTimeAPIResult({
    required this.id,
    required this.serviceId,
    required this.contractServiceId,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.state,
  });

  factory GetServiceTimeAPIResult.fromJson(Map<String, dynamic> json) =>
      _$GetServiceTimeAPIResultFromJson(json);

  Map<String, dynamic> toJson() => _$GetServiceTimeAPIResultToJson(this);
}
