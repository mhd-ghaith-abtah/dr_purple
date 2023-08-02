import 'package:dr_purple/app/app_configurations/app_configurations.dart';
import 'package:dr_purple/core/features/data/remote_data_source/models/params/params_model.dart';
import 'package:dr_purple/core/utils/enums.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_all_services_params.g.dart';

class GetAllServicesParams extends ParamsModel<GetAllServicesParamsBody> {
  @override
  Map<String, String>? get additionalHeaders => {};

  @override
  RequestType get requestType => RequestType.get;

  @override
  String? get url => 'Service/All';

  @override
  Map<String, dynamic>? get urlParams => body?.toJson();

  const GetAllServicesParams({GetAllServicesParamsBody? body})
      : super(body: body, baseUrl: AppConfigurations.baseUrl);

  @override
  List<Object?> get props => [url, urlParams, requestType, body];
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class GetAllServicesParamsBody extends BaseBodyModel {
  @JsonKey(name: "PageSize")
  final int? pageSize;
  @JsonKey(name: "PageNo")
  final int? pageNo;
  @JsonKey(name: "Skip")
  final int? skip;
  @JsonKey(name: "OrderBy")
  final String? orderBy;
  @JsonKey(name: "SearchBy")
  final String? searchBy;
  @JsonKey(name: "IsAscending")
  final bool? isAscending;

  GetAllServicesParamsBody({
    required this.pageSize,
    required this.pageNo,
    required this.skip,
    required this.orderBy,
    required this.searchBy,
    required this.isAscending,
  });

  factory GetAllServicesParamsBody.fromJson(Map<String, dynamic> json) =>
      _$GetAllServicesParamsBodyFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$GetAllServicesParamsBodyToJson(this);
}
