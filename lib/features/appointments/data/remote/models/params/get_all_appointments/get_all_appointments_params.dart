import 'package:dr_purple/app/app_configurations/app_configurations.dart';
import 'package:dr_purple/core/features/data/remote_data_source/models/params/params_model.dart';
import 'package:dr_purple/core/utils/enums.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_all_appointments_params.g.dart';

class GetAllAppointmentsParams
    extends ParamsModel<GetAllAppointmentsParamsBody> {
  @override
  Map<String, String>? get additionalHeaders => {};

  @override
  RequestType get requestType => RequestType.get;

  @override
  String? get url => 'Appointment/MyAppointments';

  @override
  Map<String, dynamic>? get urlParams => body?.toJson();

  const GetAllAppointmentsParams({GetAllAppointmentsParamsBody? body})
      : super(body: body, baseUrl: AppConfigurations.baseUrl);

  @override
  List<Object?> get props => [url, urlParams, requestType, body];
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class GetAllAppointmentsParamsBody extends BaseBodyModel {
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

  GetAllAppointmentsParamsBody({
    required this.pageSize,
    required this.pageNo,
    required this.skip,
    required this.orderBy,
    required this.searchBy,
    required this.isAscending,
  });

  factory GetAllAppointmentsParamsBody.fromJson(Map<String, dynamic> json) =>
      _$GetAllAppointmentsParamsBodyFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$GetAllAppointmentsParamsBodyToJson(this);
}
