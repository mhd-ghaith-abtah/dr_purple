import 'package:dr_purple/app/app_configurations/app_configurations.dart';
import 'package:dr_purple/core/features/data/remote_data_source/models/params/params_model.dart';
import 'package:dr_purple/core/utils/enums.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_service_params.g.dart';

class GetServiceParams extends ParamsModel<GetServiceParamsBody> {
  @override
  Map<String, String>? get additionalHeaders => {};

  @override
  RequestType get requestType => RequestType.get;

  @override
  String? get url => 'Service/Get';

  @override
  Map<String, dynamic>? get urlParams => body?.toJson();

  const GetServiceParams({GetServiceParamsBody? body})
      : super(body: body, baseUrl: AppConfigurations.baseUrl);

  @override
  List<Object?> get props => [url, urlParams, requestType, body];
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class GetServiceParamsBody extends BaseBodyModel {
  @JsonKey(name: "id")
  final int? id;

  GetServiceParamsBody({required this.id});

  factory GetServiceParamsBody.fromJson(Map<String, dynamic> json) =>
      _$GetServiceParamsBodyFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$GetServiceParamsBodyToJson(this);
}
