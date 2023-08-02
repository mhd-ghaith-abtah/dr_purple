import 'package:dr_purple/app/app_configurations/app_configurations.dart';
import 'package:dr_purple/core/features/data/remote_data_source/models/params/params_model.dart';
import 'package:dr_purple/core/utils/enums.dart';
import 'package:json_annotation/json_annotation.dart';

part 'media_upload_params.g.dart';

class MediaUploadParams extends ParamsModel<MediaUploadParamsBody> {
  @override
  Map<String, String>? get additionalHeaders => {};

  @override
  RequestType get requestType => RequestType.mediaUpload;

  @override
  String? get url => "User/UploadProfilePic";

  @override
  Map<String, String> get urlParams => {};

  const MediaUploadParams({MediaUploadParamsBody? body})
      : super(body: body, baseUrl: AppConfigurations.baseUrl);

  @override
  List<Object?> get props => [url, urlParams, requestType, body];
}

@JsonSerializable()
class MediaUploadParamsBody extends BaseBodyModel {
  @JsonKey(name: "file")
  final String? filePath;

  MediaUploadParamsBody({required this.filePath});

  factory MediaUploadParamsBody.fromJson(Map<String, dynamic> json) =>
      _$MediaUploadParamsBodyFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MediaUploadParamsBodyToJson(this);
}
