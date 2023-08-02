import 'package:dr_purple/core/utils/enums.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'media_object.freezed.dart';

@freezed
class MediaObject with _$MediaObject {
  factory MediaObject(
    String mediaPath,
    String mediaTaskId,
    UploadState uploadState,
    double? progress,
    String id,
  ) = _MediaObject;
}
