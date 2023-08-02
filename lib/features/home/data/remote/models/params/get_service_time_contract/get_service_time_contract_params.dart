import 'package:dr_purple/app/app_configurations/app_configurations.dart';
import 'package:dr_purple/core/features/data/remote_data_source/models/params/params_model.dart';
import 'package:dr_purple/core/utils/enums.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_service_time_contract_params.g.dart';

class GetServiceTimeContractParams
    extends ParamsModel<GetServiceTimeContractParamsBody> {
  @override
  Map<String, String>? get additionalHeaders => {};

  @override
  RequestType get requestType => RequestType.get;

  @override
  String? get url => 'ContractService/Get';

  @override
  Map<String, dynamic>? get urlParams => body?.toJson();

  const GetServiceTimeContractParams({GetServiceTimeContractParamsBody? body})
      : super(body: body, baseUrl: AppConfigurations.baseUrl);

  @override
  List<Object?> get props => [url, urlParams, requestType, body];
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class GetServiceTimeContractParamsBody extends BaseBodyModel {
  @JsonKey(name: "id")
  final int? id;

  GetServiceTimeContractParamsBody({required this.id});

  factory GetServiceTimeContractParamsBody.fromJson(
          Map<String, dynamic> json) =>
      _$GetServiceTimeContractParamsBodyFromJson(json);

  @override
  Map<String, dynamic> toJson() =>
      _$GetServiceTimeContractParamsBodyToJson(this);
}
