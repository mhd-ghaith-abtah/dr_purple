import 'package:dr_purple/app/app_configurations/app_configurations.dart';
import 'package:dr_purple/core/features/data/remote_data_source/models/params/params_model.dart';
import 'package:dr_purple/core/utils/enums.dart';
import 'package:json_annotation/json_annotation.dart';

part 'change_password_params.g.dart';

class ChangePasswordParams extends ParamsModel<ChangePasswordParamsBody> {
  @override
  Map<String, String>? get additionalHeaders => {};

  @override
  RequestType get requestType => RequestType.put;

  @override
  String? get url => 'User/ResetPassword';

  @override
  Map<String, dynamic>? get urlParams => {};

  const ChangePasswordParams({ChangePasswordParamsBody? body})
      : super(body: body, baseUrl: AppConfigurations.baseUrl);

  @override
  List<Object?> get props => [url, urlParams, requestType, body];
}

@JsonSerializable(explicitToJson: true)
class ChangePasswordParamsBody extends BaseBodyModel {
  @JsonKey(name: "newPassword")
  final String? newPassword;
  @JsonKey(name: "oldPassword")
  final String? oldPassword;

  ChangePasswordParamsBody({
    required this.newPassword,
    required this.oldPassword,
  });

  factory ChangePasswordParamsBody.fromJson(Map<String, dynamic> json) =>
      _$ChangePasswordParamsBodyFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ChangePasswordParamsBodyToJson(this);
}
