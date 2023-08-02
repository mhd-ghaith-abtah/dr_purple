import 'package:dr_purple/core/features/data/remote_data_source/models/responses/base_response_model.dart';
import 'package:dr_purple/features/auth/domain/entities/refresh_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'refresh_api_response.g.dart';

@JsonSerializable()
class RefreshAPIResponse extends BaseResponseModel {
  @JsonKey(name: "data")
  RefreshAPIResult? result;

  RefreshAPIResponse({required this.result});

  factory RefreshAPIResponse.fromJson(Map<String, dynamic> json) =>
      _$RefreshAPIResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$RefreshAPIResponseToJson(this);

  @override
  RefreshEntity toEntity() => RefreshEntity(
        accessToken: result?.accessToken,
        refreshToken: result?.refreshToken,
      );
}

@JsonSerializable()
class RefreshAPIResult {
  @JsonKey(name: "accessToken")
  String? accessToken;
  @JsonKey(name: "refreshToken")
  String? refreshToken;

  RefreshAPIResult({required this.accessToken, required this.refreshToken});

  factory RefreshAPIResult.fromJson(Map<String, dynamic> json) =>
      _$RefreshAPIResultFromJson(json);

  Map<String, dynamic> toJson() => _$RefreshAPIResultToJson(this);
}
