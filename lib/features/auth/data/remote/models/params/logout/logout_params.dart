import 'package:dr_purple/app/app_configurations/app_configurations.dart';
import 'package:dr_purple/core/features/data/remote_data_source/models/params/params_model.dart';
import 'package:dr_purple/core/utils/enums.dart';

class LogoutParams extends ParamsModel<LogoutParamsBody> {
  @override
  Map<String, String>? get additionalHeaders => {};

  @override
  RequestType get requestType => RequestType.get;

  @override
  String? get url => 'Authentication/Logout';

  @override
  Map<String, String> get urlParams => {};

  const LogoutParams({LogoutParamsBody? body})
      : super(body: body, baseUrl: AppConfigurations.baseUrl);

  @override
  List<Object?> get props => [url, urlParams, requestType, body];
}

class LogoutParamsBody extends BaseBodyModel {
  @override
  Map<String, dynamic> toJson() => {};
}
