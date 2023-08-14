import 'package:dr_purple/app/app_configurations/app_configurations.dart';
import 'package:dr_purple/core/features/data/remote_data_source/models/params/params_model.dart';
import 'package:dr_purple/core/utils/enums.dart';
import 'package:json_annotation/json_annotation.dart';

part 'forget_password_params.g.dart';

class ForgetPasswordParams extends ParamsModel<ForgetPasswordParamsBody> {
  @override
  Map<String, String>? get additionalHeaders => {};

  @override
  RequestType get requestType => RequestType.post;

  @override
  String? get url => 'Authentication/ForgetPassword';

  @override
  Map<String, String> get urlParams => {};

  const ForgetPasswordParams({ForgetPasswordParamsBody? body})
      : super(body: body, baseUrl: AppConfigurations.baseUrl);

  @override
  List<Object?> get props => [url, urlParams, requestType, body];
}

@JsonSerializable(explicitToJson: true)
class ForgetPasswordParamsBody extends BaseBodyModel {
  @JsonKey(name: "mobile")
  final String? mobileNumber;

  ForgetPasswordParamsBody({required this.mobileNumber});

  factory ForgetPasswordParamsBody.fromJson(Map<String, dynamic> json) =>
      _$ForgetPasswordParamsBodyFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ForgetPasswordParamsBodyToJson(this);
}
