import 'package:dr_purple/core/features/data/remote_data_source/models/responses/base_response_model.dart';
import 'package:dr_purple/features/auth/domain/entities/verify_account_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'verify_account_api_response.g.dart';

@JsonSerializable()
class VerifyAccountAPIResponse extends BaseResponseModel {
  @JsonKey(name: "data")
  VerifyAccountAPIResult? result;

  VerifyAccountAPIResponse({required this.result});

  factory VerifyAccountAPIResponse.fromJson(Map<String, dynamic> json) =>
      _$VerifyAccountAPIResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$VerifyAccountAPIResponseToJson(this);

  @override
  VerifyAccountEntity toEntity() => VerifyAccountEntity(
        accessToken: result?.accessToken,
        refreshToken: result?.refreshToken,
      );
}

@JsonSerializable()
class VerifyAccountAPIResult {
  @JsonKey(name: "accessToken")
  String? accessToken;
  @JsonKey(name: "refreshToken")
  String? refreshToken;

  VerifyAccountAPIResult(
      {required this.accessToken, required this.refreshToken});

  factory VerifyAccountAPIResult.fromJson(Map<String, dynamic> json) =>
      _$VerifyAccountAPIResultFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyAccountAPIResultToJson(this);
}
