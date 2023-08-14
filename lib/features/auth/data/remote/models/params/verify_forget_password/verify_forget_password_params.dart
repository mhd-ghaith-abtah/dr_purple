import 'package:dr_purple/app/app_configurations/app_configurations.dart';
import 'package:dr_purple/core/features/data/remote_data_source/models/params/params_model.dart';
import 'package:dr_purple/core/utils/enums.dart';
import 'package:json_annotation/json_annotation.dart';

part 'verify_forget_password_params.g.dart';

class VerifyForgetPasswordParams
    extends ParamsModel<VerifyForgetPasswordParamsBody> {
  @override
  Map<String, String>? get additionalHeaders => {};

  @override
  RequestType get requestType => RequestType.put;

  @override
  String? get url => 'Authentication/VerifyForgetPassword';

  @override
  Map<String, String> get urlParams => {};

  const VerifyForgetPasswordParams({VerifyForgetPasswordParamsBody? body})
      : super(body: body, baseUrl: AppConfigurations.baseUrl);

  @override
  List<Object?> get props => [url, urlParams, requestType, body];
}

@JsonSerializable(explicitToJson: true)
class VerifyForgetPasswordParamsBody extends BaseBodyModel {
  @JsonKey(name: "contactNumber")
  final String? mobileNumber;
  @JsonKey(name: "code")
  final String? code;
  @JsonKey(name: "password")
  final String? newPassword;

  VerifyForgetPasswordParamsBody({
    required this.mobileNumber,
    required this.code,
    required this.newPassword,
  });

  factory VerifyForgetPasswordParamsBody.fromJson(Map<String, dynamic> json) =>
      _$VerifyForgetPasswordParamsBodyFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$VerifyForgetPasswordParamsBodyToJson(this);
}
