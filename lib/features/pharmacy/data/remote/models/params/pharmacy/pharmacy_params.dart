import 'package:dr_purple/app/app_configurations/app_configurations.dart';
import 'package:dr_purple/core/features/data/remote_data_source/models/params/params_model.dart';
import 'package:dr_purple/core/utils/enums.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pharmacy_params.g.dart';

class PharmacyParams extends ParamsModel<PharmacyParamsBody> {
  @override
  Map<String, String>? get additionalHeaders => {};

  @override
  RequestType get requestType => RequestType.get;

  @override
  String? get url => 'SubDepartment/Sale/All';

  @override
  Map<String, dynamic>? get urlParams => body?.toJson();

  const PharmacyParams({PharmacyParamsBody? body})
      : super(body: body, baseUrl: AppConfigurations.baseUrl);

  @override
  bool? get useDataForPostRequest => false;

  @override
  List<Object?> get props => [url, urlParams, requestType, body];
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class PharmacyParamsBody extends BaseBodyModel {
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

  PharmacyParamsBody({
    required this.pageSize,
    required this.pageNo,
    required this.skip,
    required this.orderBy,
    required this.searchBy,
    required this.isAscending,
  });

  factory PharmacyParamsBody.fromJson(Map<String, dynamic> json) =>
      _$PharmacyParamsBodyFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PharmacyParamsBodyToJson(this);
}
