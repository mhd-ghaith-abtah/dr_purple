import 'package:dr_purple/app/app_configurations/app_configurations.dart';
import 'package:dr_purple/core/features/data/remote_data_source/models/params/params_model.dart';
import 'package:dr_purple/core/utils/enums.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_doctor_params.g.dart';

class GetDoctorParams extends ParamsModel<GetDoctorParamsBody> {
  @override
  Map<String, String>? get additionalHeaders => {};

  @override
  RequestType get requestType => RequestType.get;

  @override
  String? get url => 'User/GetByContractService';

  @override
  Map<String, dynamic>? get urlParams => body?.toJson();

  const GetDoctorParams({GetDoctorParamsBody? body})
      : super(body: body, baseUrl: AppConfigurations.baseUrl);

  @override
  List<Object?> get props => [url, urlParams, requestType, body];
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class GetDoctorParamsBody extends BaseBodyModel {
  @JsonKey(name: "contractServiceId")
  final int? contractServiceId;

  GetDoctorParamsBody({required this.contractServiceId});

  factory GetDoctorParamsBody.fromJson(Map<String, dynamic> json) =>
      _$GetDoctorParamsBodyFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$GetDoctorParamsBodyToJson(this);
}
