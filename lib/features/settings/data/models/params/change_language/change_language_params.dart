import 'package:dr_purple/app/app_configurations/app_configurations.dart';
import 'package:dr_purple/core/features/data/remote_data_source/models/params/params_model.dart';
import 'package:dr_purple/core/utils/enums.dart';
import 'package:json_annotation/json_annotation.dart';

part 'change_language_params.g.dart';

class ChangeLanguageParams extends ParamsModel<ChangeLanguageParamsBody> {
  @override
  Map<String, String>? get additionalHeaders => {};

  @override
  RequestType get requestType => RequestType.put;

  @override
  String? get url => 'User/UpdateCulture';

  @override
  Map<String, dynamic>? get urlParams => {};

  const ChangeLanguageParams({ChangeLanguageParamsBody? body})
      : super(body: body, baseUrl: AppConfigurations.baseUrl);

  @override
  List<Object?> get props => [url, urlParams, requestType, body];
}

@JsonSerializable(explicitToJson: true)
class ChangeLanguageParamsBody extends BaseBodyModel {
  @JsonKey(name: "culture")
  final String? newLanguage;

  ChangeLanguageParamsBody({required this.newLanguage});

  factory ChangeLanguageParamsBody.fromJson(Map<String, dynamic> json) =>
      _$ChangeLanguageParamsBodyFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ChangeLanguageParamsBodyToJson(this);
}
