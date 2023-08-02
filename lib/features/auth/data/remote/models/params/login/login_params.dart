import 'package:dr_purple/app/app_configurations/app_configurations.dart';
import 'package:dr_purple/core/features/data/remote_data_source/models/params/params_model.dart';
import 'package:dr_purple/core/utils/enums.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_params.g.dart';

class LoginParams extends ParamsModel<LoginParamsBody> {
  @override
  Map<String, String>? get additionalHeaders => {};

  @override
  RequestType get requestType => RequestType.post;

  @override
  String? get url => 'Authentication/Login';

  @override
  Map<String, String> get urlParams => {};

  const LoginParams({LoginParamsBody? body})
      : super(body: body, baseUrl: AppConfigurations.baseUrl);

  @override
  List<Object?> get props => [url, urlParams, requestType, body];
}

@JsonSerializable(explicitToJson: true)
class LoginParamsBody extends BaseBodyModel {
  @JsonKey(name: "userName")
  final String? userName;
  @JsonKey(name: "password")
  final String? password;

  LoginParamsBody({required this.userName, required this.password});

  factory LoginParamsBody.fromJson(Map<String, dynamic> json) =>
      _$LoginParamsBodyFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$LoginParamsBodyToJson(this);
}
