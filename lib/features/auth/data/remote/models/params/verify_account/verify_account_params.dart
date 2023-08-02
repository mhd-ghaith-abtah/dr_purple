import 'package:dr_purple/app/app_configurations/app_configurations.dart';
import 'package:dr_purple/core/features/data/remote_data_source/models/params/params_model.dart';
import 'package:dr_purple/core/utils/enums.dart';
import 'package:json_annotation/json_annotation.dart';

part 'verify_account_params.g.dart';

class VerifyAccountParams extends ParamsModel<VerifyAccountParamsBody> {
  @override
  Map<String, String>? get additionalHeaders => {};

  @override
  RequestType get requestType => RequestType.put;

  @override
  String? get url => 'Authentication/Verify';

  @override
  Map<String, String> get urlParams => {};

  const VerifyAccountParams({VerifyAccountParamsBody? body})
      : super(body: body, baseUrl: AppConfigurations.baseUrl);

  @override
  List<Object?> get props => [url, urlParams, requestType, body];
}

@JsonSerializable(explicitToJson: true)
class VerifyAccountParamsBody extends BaseBodyModel {
  @JsonKey(name: "contactNumber")
  final String? contactNumber;

  VerifyAccountParamsBody({required this.contactNumber});

  factory VerifyAccountParamsBody.fromJson(Map<String, dynamic> json) =>
      _$VerifyAccountParamsBodyFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$VerifyAccountParamsBodyToJson(this);
}
