part of 'media_upload_bloc.dart';

abstract class MediaUploadState {
  final MediaObject? mediaObject;

  MediaUploadState(this.mediaObject);
}

class MediaUploadInitialState extends MediaUploadState {
  MediaUploadInitialState({MediaObject? mediaObject}) : super(mediaObject);
}

class LoadingUploadMediaState extends MediaUploadState {
  LoadingUploadMediaState({MediaObject? mediaObject}) : super(mediaObject);
}

class UploadingMediaStartedState extends MediaUploadState {
  UploadingMediaStartedState(MediaObject? mediaObject) : super(mediaObject);
}

class MediaIsUploadingState extends MediaUploadState {
  final double progress;

  MediaIsUploadingState(MediaObject? mediaObject, {required this.progress})
      : super(mediaObject);
}

class ErrorUploadingMediaState extends MediaUploadState {
  final String errorMessage;

  ErrorUploadingMediaState({
    required this.errorMessage,
    MediaObject? mediaObject,
  }) : super(mediaObject);
}

class UploadingMediaCanceledState extends MediaUploadState {
  UploadingMediaCanceledState(MediaObject? mediaObject) : super(mediaObject);
}

class MediaHasBeenUploadedState extends MediaUploadState {
  final String imageId;
  final String imageUrl;

  MediaHasBeenUploadedState(
    MediaObject? mediaObject, {
    required this.imageUrl,
    required this.imageId,
  }) : super(mediaObject);
}

class MediaIsWaitingInQueueState extends MediaUploadState {
  MediaIsWaitingInQueueState(MediaObject? mediaObject) : super(mediaObject);
}

class MediaDeleted extends MediaUploadState {
  MediaDeleted() : super(null);
}
