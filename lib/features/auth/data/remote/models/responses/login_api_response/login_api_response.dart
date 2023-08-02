import 'package:dr_purple/core/features/data/remote_data_source/models/responses/base_response_model.dart';
import 'package:dr_purple/features/auth/domain/entities/login_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_api_response.g.dart';

@JsonSerializable()
class LoginAPIResponse extends BaseResponseModel {
  @JsonKey(name: "data")
  LoginAPIResult? result;

  LoginAPIResponse({required this.result});

  factory LoginAPIResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginAPIResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$LoginAPIResponseToJson(this);

  @override
  LoginEntity toEntity() => LoginEntity(
        accessToken: result?.accessToken,
        refreshToken: result?.refreshToken,
      );
}

@JsonSerializable()
class LoginAPIResult {
  @JsonKey(name: "accessToken")
  String? accessToken;
  @JsonKey(name: "refreshToken")
  String? refreshToken;

  LoginAPIResult({required this.accessToken, required this.refreshToken});

  factory LoginAPIResult.fromJson(Map<String, dynamic> json) =>
      _$LoginAPIResultFromJson(json);

  Map<String, dynamic> toJson() => _$LoginAPIResultToJson(this);
}
