part of 'media_upload_bloc.dart';

@immutable
abstract class MediaUploadEvent {}

class MediaUploadInitEvent extends MediaUploadEvent {}

class MediaIsUploadingEvent extends MediaUploadEvent {
  final String taskId;
  final double progress;

  MediaIsUploadingEvent({required this.taskId, required this.progress});
}

class MediaUploadedSuccessfullyEvent extends MediaUploadEvent {
  final String response;
  final String taskId;

  MediaUploadedSuccessfullyEvent({
    required this.taskId,
    required this.response,
  });
}

class ErrorUploadingMediaEvent extends MediaUploadEvent {
  final String taskId;

  ErrorUploadingMediaEvent({required this.taskId});
}

class UploadingMediaCanceledEvent extends MediaUploadEvent {
  final String taskId;

  UploadingMediaCanceledEvent({required this.taskId});
}

class MediaWaitingInQueueEvent extends MediaUploadEvent {
  final String taskId;

  MediaWaitingInQueueEvent({required this.taskId});
}

class UploadMediaEvent extends MediaUploadEvent {
  final String mediaPath;

  UploadMediaEvent({required this.mediaPath});
}

class DeleteMediaEvent extends MediaUploadEvent {
  final String taskId;

  DeleteMediaEvent({
    required this.taskId,
  });
}
