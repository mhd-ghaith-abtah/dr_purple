import 'package:dr_purple/app/app_configurations/app_configurations.dart';
import 'package:dr_purple/core/features/data/remote_data_source/models/params/params_model.dart';
import 'package:dr_purple/core/utils/enums.dart';
import 'package:json_annotation/json_annotation.dart';

part 'register_params.g.dart';

class RegisterParams extends ParamsModel<RegisterParamsBody> {
  @override
  Map<String, String>? get additionalHeaders => {};

  @override
  RequestType get requestType => RequestType.post;

  @override
  String? get url => 'Authentication/Register';

  @override
  Map<String, String> get urlParams => {};

  const RegisterParams({RegisterParamsBody? body})
      : super(body: body, baseUrl: AppConfigurations.baseUrl);

  @override
  List<Object?> get props => [url, urlParams, requestType, body];
}

@JsonSerializable(explicitToJson: true)
class RegisterParamsBody extends BaseBodyModel {
  @JsonKey(name: "firstName")
  final String? firstName;
  @JsonKey(name: "lastName")
  final String? lastName;
  @JsonKey(name: "userName")
  final String? userName;
  @JsonKey(name: "password")
  final String? password;
  @JsonKey(name: "contactNumber")
  final String? contactNumber;
  @JsonKey(name: "email")
  final String? email;
  @JsonKey(name: "gender")
  final int? gender;

  RegisterParamsBody({
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.password,
    required this.contactNumber,
    required this.gender,
    required this.email,
  });

  factory RegisterParamsBody.fromJson(Map<String, dynamic> json) =>
      _$RegisterParamsBodyFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$RegisterParamsBodyToJson(this);
}
