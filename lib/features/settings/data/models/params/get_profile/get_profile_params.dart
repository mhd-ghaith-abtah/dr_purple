import 'package:dr_purple/app/app_configurations/app_configurations.dart';
import 'package:dr_purple/core/features/data/remote_data_source/models/params/params_model.dart';
import 'package:dr_purple/core/utils/enums.dart';

class GetProfileParams extends ParamsModel<GetProfileParamsBody> {
  @override
  Map<String, String>? get additionalHeaders => {};

  @override
  RequestType get requestType => RequestType.get;

  @override
  String? get url => 'User/Profile';

  @override
  Map<String, dynamic>? get urlParams => body?.toJson();

  const GetProfileParams({GetProfileParamsBody? body})
      : super(body: body, baseUrl: AppConfigurations.baseUrl);

  @override
  List<Object?> get props => [url, urlParams, requestType, body];
}

class GetProfileParamsBody extends BaseBodyModel {
  @override
  Map<String, dynamic> toJson() => {};
}
