import 'package:dr_purple/app/app_configurations/app_configurations.dart';
import 'package:dr_purple/core/features/data/remote_data_source/models/params/params_model.dart';
import 'package:dr_purple/core/utils/enums.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_all_service_time_params.g.dart';

class GetAllServiceTimeParams
    extends ParamsModel<GetAllServiceTimeParamsBody> {
  @override
  Map<String, String>? get additionalHeaders => {};

  @override
  RequestType get requestType => RequestType.get;

  @override
  String? get url => 'Service/ServiceTime/All';

  @override
  Map<String, dynamic>? get urlParams => body?.toJson();

  const GetAllServiceTimeParams({GetAllServiceTimeParamsBody? body})
      : super(body: body, baseUrl: AppConfigurations.baseUrl);

  @override
  List<Object?> get props => [url, urlParams, requestType, body];
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class GetAllServiceTimeParamsBody extends BaseBodyModel {
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

  GetAllServiceTimeParamsBody({
    required this.pageSize,
    required this.pageNo,
    required this.skip,
    required this.orderBy,
    required this.searchBy,
    required this.isAscending,
  });

  factory GetAllServiceTimeParamsBody.fromJson(Map<String, dynamic> json) =>
      _$GetAllServiceTimeParamsBodyFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$GetAllServiceTimeParamsBodyToJson(this);
}
