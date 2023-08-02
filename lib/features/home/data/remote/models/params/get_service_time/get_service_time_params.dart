import 'package:dr_purple/app/app_configurations/app_configurations.dart';
import 'package:dr_purple/core/features/data/remote_data_source/models/params/params_model.dart';
import 'package:dr_purple/core/utils/enums.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_service_time_params.g.dart';

class GetServiceTimeParams extends ParamsModel<GetServiceTimeParamsBody> {
  @override
  Map<String, String>? get additionalHeaders => {};

  @override
  RequestType get requestType => RequestType.get;

  @override
  String? get url => 'Service/ServiceTime/GetBy';

  @override
  Map<String, dynamic>? get urlParams => body?.toJson();

  const GetServiceTimeParams({GetServiceTimeParamsBody? body})
      : super(body: body, baseUrl: AppConfigurations.baseUrl);

  @override
  List<Object?> get props => [url, urlParams, requestType, body];
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class GetServiceTimeParamsBody extends BaseBodyModel {
  @JsonKey(name: "ServiceId")
  final int? serviceId;

  GetServiceTimeParamsBody({required this.serviceId});

  factory GetServiceTimeParamsBody.fromJson(Map<String, dynamic> json) =>
      _$GetServiceTimeParamsBodyFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$GetServiceTimeParamsBodyToJson(this);
}
