import 'package:dr_purple/app/app_configurations/app_configurations.dart';
import 'package:dr_purple/core/features/data/remote_data_source/models/params/params_model.dart';
import 'package:dr_purple/core/utils/enums.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_contract_params.g.dart';

class GetContractParams extends ParamsModel<GetContractParamsBody> {
  @override
  Map<String, String>? get additionalHeaders => {};

  @override
  RequestType get requestType => RequestType.get;

  @override
  String? get url => 'Contract/Get';

  @override
  Map<String, dynamic>? get urlParams => body?.toJson();

  const GetContractParams({GetContractParamsBody? body})
      : super(body: body, baseUrl: AppConfigurations.baseUrl);

  @override
  List<Object?> get props => [url, urlParams, requestType, body];
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class GetContractParamsBody extends BaseBodyModel {
  @JsonKey(name: "id")
  final int? id;

  GetContractParamsBody({required this.id});

  factory GetContractParamsBody.fromJson(Map<String, dynamic> json) =>
      _$GetContractParamsBodyFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$GetContractParamsBodyToJson(this);
}
