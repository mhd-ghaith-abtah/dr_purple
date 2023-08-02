import 'package:dr_purple/app/app_configurations/app_configurations.dart';
import 'package:dr_purple/core/features/data/remote_data_source/models/params/params_model.dart';
import 'package:dr_purple/core/utils/enums.dart';
import 'package:json_annotation/json_annotation.dart';

part 'update_profile_params.g.dart';

class UpdateProfileParams extends ParamsModel<UpdateProfileParamsBody> {
  @override
  Map<String, String>? get additionalHeaders => {};

  @override
  RequestType get requestType => RequestType.put;

  @override
  String? get url => 'User/Update';

  @override
  Map<String, dynamic>? get urlParams => {"id": body?.id};

  const UpdateProfileParams({UpdateProfileParamsBody? body})
      : super(body: body, baseUrl: AppConfigurations.baseUrl);

  @override
  List<Object?> get props => [url, urlParams, requestType, body];
}

@JsonSerializable(explicitToJson: true)
class UpdateProfileParamsBody extends BaseBodyModel {
  @JsonKey(name: "firstName")
  final String? firstName;
  @JsonKey(name: "lastName")
  final String? lastName;
  @JsonKey(name: "userName")
  final String? userName;
  @JsonKey(name: "password")
  final String? password;
  @JsonKey(name: "contactNumber")
  final String? contactNumber;
  @JsonKey(name: "email")
  final String? email;
  @JsonKey(name: "gender")
  final int? gender;
  @JsonKey(name: "address")
  final String? address;
  @JsonKey(name: "id")
  final int? id;

  UpdateProfileParamsBody({
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.password,
    required this.contactNumber,
    required this.gender,
    required this.email,
    required this.address,
    required this.id,
  });

  factory UpdateProfileParamsBody.fromJson(Map<String, dynamic> json) =>
      _$UpdateProfileParamsBodyFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UpdateProfileParamsBodyToJson(this);
}
