import 'package:dr_purple/app/app_configurations/app_configurations.dart';
import 'package:dr_purple/core/features/data/remote_data_source/models/params/params_model.dart';
import 'package:dr_purple/core/utils/enums.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_appointment_params.g.dart';

class GetAppointmentParams
    extends ParamsModel<GetAllAppointmentsTimeParamsBody> {
  @override
  Map<String, String>? get additionalHeaders => {};

  @override
  RequestType get requestType => RequestType.get;

  @override
  String? get url => 'Appointment/Get';

  @override
  Map<String, dynamic>? get urlParams => body?.toJson();

  const GetAppointmentParams({GetAllAppointmentsTimeParamsBody? body})
      : super(body: body, baseUrl: AppConfigurations.baseUrl);

  @override
  List<Object?> get props => [url, urlParams, requestType, body];
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class GetAllAppointmentsTimeParamsBody extends BaseBodyModel {
  @JsonKey(name: "id")
  final int? id;

  GetAllAppointmentsTimeParamsBody({required this.id});

  factory GetAllAppointmentsTimeParamsBody.fromJson(
          Map<String, dynamic> json) =>
      _$GetAllAppointmentsTimeParamsBodyFromJson(json);

  @override
  Map<String, dynamic> toJson() =>
      _$GetAllAppointmentsTimeParamsBodyToJson(this);
}
