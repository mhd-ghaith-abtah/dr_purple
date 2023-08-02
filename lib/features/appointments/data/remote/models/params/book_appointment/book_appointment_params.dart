import 'package:dr_purple/app/app_configurations/app_configurations.dart';
import 'package:dr_purple/core/features/data/remote_data_source/models/params/params_model.dart';
import 'package:dr_purple/core/utils/enums.dart';
import 'package:json_annotation/json_annotation.dart';

part 'book_appointment_params.g.dart';

class BookAppointmentParams extends ParamsModel<BookAppointmentParamsBody> {
  @override
  Map<String, String>? get additionalHeaders => {};

  @override
  RequestType get requestType => RequestType.post;

  @override
  String? get url => 'Appointment/Book';

  @override
  Map<String, dynamic>? get urlParams => body?.toJson();

  @override
  bool? get useDataForPostRequest => false;

  const BookAppointmentParams({BookAppointmentParamsBody? body})
      : super(body: body, baseUrl: AppConfigurations.baseUrl);

  @override
  List<Object?> get props => [url, urlParams, requestType, body];
}

@JsonSerializable(explicitToJson: true)
class BookAppointmentParamsBody extends BaseBodyModel {
  @JsonKey(name: "id")
  final int? id;

  BookAppointmentParamsBody({required this.id});

  factory BookAppointmentParamsBody.fromJson(Map<String, dynamic> json) =>
      _$BookAppointmentParamsBodyFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$BookAppointmentParamsBodyToJson(this);
}
