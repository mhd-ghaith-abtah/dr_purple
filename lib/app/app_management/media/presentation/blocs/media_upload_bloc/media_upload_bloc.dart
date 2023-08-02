import 'package:dr_purple/app/app_management/media/data/remote/models/params/media_upload_params.dart';
import 'package:dr_purple/app/app_management/media/data/remote/models/responses/media_upload_response/media_upload_api_response.dart';
import 'package:dr_purple/app/app_management/media/domain/entities/background_uploader_entity.dart';
import 'package:dr_purple/app/app_management/media/domain/use_cases/background_uploader_use_case.dart';
import 'package:dr_purple/app/app_management/strings_manager.dart';
import 'package:dr_purple/core/freezed_data_classes/media_object/media_object.dart';
import 'package:dr_purple/core/services/background_uploader/background_uploader.dart';
import 'package:dr_purple/core/utils/constants.dart';
import 'package:dr_purple/core/utils/enums.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'media_upload_event.dart';

part 'media_upload_state.dart';

class MediaUploadBloc extends Bloc<MediaUploadEvent, MediaUploadState> {
  final BackgroundUploaderUseCase _backgroundUploaderUseCase;

  final List<MediaObject> _media = List.empty(growable: true);

  List<MediaObject> get media => _media;

  MediaUploadBloc(this._backgroundUploaderUseCase)
      : super(MediaUploadInitialState()) {
    on<UploadMediaEvent>((event, emit) async {
      int idx =
          _media.indexWhere((element) => element.mediaPath == event.mediaPath);
      if (idx == -1) {
        _media.add(MediaObject(
          event.mediaPath,
          Constants.empty,
          UploadState.init,
          null,
          Constants.empty,
        ));
      }
      emit(LoadingUploadMediaState());

      String errorMessage = Constants.empty;
      BackgroundUploaderEntity? backgroundUploaderResponse;

      var res = await _backgroundUploaderUseCase.call(MediaUploadParams(
        body: MediaUploadParamsBody(filePath: event.mediaPath),
      ));
      bool isError = res.fold((l) {
        errorMessage = l.message;
        return true;
      }, (r) {
        backgroundUploaderResponse = r;
        return false;
      });

      ///if there is an error occurred during API Request, emit error state
      if (isError) {
        emit(ErrorUploadingMediaState(errorMessage: errorMessage));
      } else {
        int idx = _media
            .indexWhere((element) => element.mediaPath == event.mediaPath);
        _media[idx] = _media[idx].copyWith(
          mediaTaskId: backgroundUploaderResponse?.taskId ?? Constants.empty,
          uploadState: UploadState.loading,
        );
        emit(UploadingMediaStartedState(_media[idx]));
      }
    });

    on<MediaWaitingInQueueEvent>((event, emit) async {
      int idx =
          _media.indexWhere((element) => element.mediaTaskId == event.taskId);
      emit(MediaIsWaitingInQueueState(_media[idx]));
    });

    on<MediaIsUploadingEvent>((event, emit) async {
      int idx =
          _media.indexWhere((element) => element.mediaTaskId == event.taskId);
      _media[idx] = _media[idx].copyWith(progress: event.progress);
      emit(MediaIsUploadingState(_media[idx], progress: event.progress));
    });

    on<MediaUploadedSuccessfullyEvent>((event, emit) async {
      final response = MediaUploadAPIResponse.fromString(event.response);
      int idx =
          _media.indexWhere((element) => element.mediaTaskId == event.taskId);
      if (response.succsess == true) {
        _media[idx] = _media[idx].copyWith(
          uploadState: UploadState.done,
          progress: null,
          id: response.result?.id ?? Constants.empty,
        );
        emit(MediaHasBeenUploadedState(
          _media[idx],
          imageId: response.result?.id ?? Constants.empty,
          imageUrl: response.result?.url ?? Constants.empty,
        ));
      } else {
        _media[idx] = _media[idx]
            .copyWith(uploadState: UploadState.error, progress: null);
        emit(ErrorUploadingMediaState(
          errorMessage: AppStrings.errorUploadingImage.tr(),
          mediaObject: _media[idx],
        ));
      }
    });

    on<ErrorUploadingMediaEvent>((event, emit) async {
      int idx =
          _media.indexWhere((element) => element.mediaTaskId == event.taskId);
      if (idx != -1) {
        _media[idx] = _media[idx]
            .copyWith(uploadState: UploadState.error, progress: null);
        emit(ErrorUploadingMediaState(
          errorMessage: AppStrings.errorUploadingImage.tr(),
          mediaObject: _media[idx],
        ));
      }
    });

    on<UploadingMediaCanceledEvent>((event, emit) async {
      int idx =
          _media.indexWhere((element) => element.mediaTaskId == event.taskId);
      if (idx != -1) {
        _media[idx] = _media[idx]
            .copyWith(uploadState: UploadState.canceled, progress: null);
        emit(UploadingMediaCanceledState(_media[idx]));
      }
    });

    on<MediaUploadInitEvent>((event, emit) async {
      _media.clear();
      try {
        await BackgroundUploader.cancelAllFilesUploading();
      } catch (e) {
        if (kDebugMode) {
          print(e.toString());
        }
      }
      emit(MediaUploadInitialState());
    });

    on<DeleteMediaEvent>((event, emit) async {
      _media.removeWhere((element) => element.mediaTaskId == event.taskId);
      try {
        await BackgroundUploader.cancelFileUploading(taskId: event.taskId);
      } catch (e) {
        if (kDebugMode) {
          print(e.toString());
        }
      }
      emit(MediaDeleted());
    });
  }
}
