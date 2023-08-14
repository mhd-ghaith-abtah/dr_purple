import 'package:dr_purple/app/app_configurations/app_configurations.dart';
import 'package:dr_purple/core/features/data/remote_data_source/models/params/params_model.dart';
import 'package:dr_purple/core/utils/enums.dart';
import 'package:json_annotation/json_annotation.dart';

part 'update_fcm_token_params.g.dart';

class UpdateFCMTokenParams extends ParamsModel<UpdateFCMTokenParamsBody> {
  @override
  Map<String, String>? get additionalHeaders => {};

  @override
  RequestType get requestType => RequestType.put;

  @override
  String? get url => 'Authentication/UpdateFCM_Key';

  @override
  Map<String, String> get urlParams => {};

  const UpdateFCMTokenParams({UpdateFCMTokenParamsBody? body})
      : super(body: body, baseUrl: AppConfigurations.baseUrl);

  @override
  List<Object?> get props => [url, urlParams, requestType, body];
}

@JsonSerializable(explicitToJson: true)
class UpdateFCMTokenParamsBody extends BaseBodyModel {
  @JsonKey(name: "fcM_Key")
  final String? fcmKey;

  UpdateFCMTokenParamsBody({required this.fcmKey});

  factory UpdateFCMTokenParamsBody.fromJson(Map<String, dynamic> json) =>
      _$UpdateFCMTokenParamsBodyFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UpdateFCMTokenParamsBodyToJson(this);
}
