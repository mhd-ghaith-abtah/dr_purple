import 'package:dr_purple/app/app_configurations/app_configurations.dart';
import 'package:dr_purple/core/features/data/remote_data_source/models/params/params_model.dart';
import 'package:dr_purple/core/utils/enums.dart';
import 'package:json_annotation/json_annotation.dart';

part 'refresh_params.g.dart';

class RefreshParams extends ParamsModel<RefreshParamsBody> {
  @override
  Map<String, String>? get additionalHeaders => {};

  @override
  RequestType get requestType => RequestType.post;

  @override
  String? get url => 'Authentication/RefreshToken';

  @override
  Map<String, String> get urlParams => {};

  const RefreshParams({RefreshParamsBody? body})
      : super(body: body, baseUrl: AppConfigurations.baseUrl);

  @override
  List<Object?> get props => [url, urlParams, requestType, body];
}

@JsonSerializable(explicitToJson: true)
class RefreshParamsBody extends BaseBodyModel {
  @JsonKey(name: "accessToken")
  final String? accessToken;
  @JsonKey(name: "refreshToken")
  final String? refreshToken;

  RefreshParamsBody({required this.accessToken, required this.refreshToken});

  factory RefreshParamsBody.fromJson(Map<String, dynamic> json) =>
      _$RefreshParamsBodyFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$RefreshParamsBodyToJson(this);
}
