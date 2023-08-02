import 'package:dr_purple/app/app_configurations/app_configurations.dart';
import 'package:dr_purple/core/features/data/remote_data_source/models/params/params_model.dart';
import 'package:dr_purple/core/utils/enums.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cancel_appointment_params.g.dart';

class CancelAppointmentParams extends ParamsModel<CancelAppointmentParamsBody> {
  @override
  Map<String, String>? get additionalHeaders => {};

  @override
  RequestType get requestType => RequestType.delete;

  @override
  String? get url => 'Appointment/Cancel';

  @override
  Map<String, dynamic>? get urlParams => body?.toJson();

  @override
  bool? get useDataForPostRequest => false;

  const CancelAppointmentParams({CancelAppointmentParamsBody? body})
      : super(body: body, baseUrl: AppConfigurations.baseUrl);

  @override
  List<Object?> get props => [url, urlParams, requestType, body];
}

@JsonSerializable(explicitToJson: true)
class CancelAppointmentParamsBody extends BaseBodyModel {
  @JsonKey(name: "id")
  final int? id;

  CancelAppointmentParamsBody({required this.id});

  factory CancelAppointmentParamsBody.fromJson(Map<String, dynamic> json) =>
      _$CancelAppointmentParamsBodyFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CancelAppointmentParamsBodyToJson(this);
}
