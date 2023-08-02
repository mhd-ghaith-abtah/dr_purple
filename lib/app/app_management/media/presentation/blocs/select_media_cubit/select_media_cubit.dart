import 'package:dr_purple/app/app_management/media/presentation/blocs/media_upload_bloc/media_upload_bloc.dart';
import 'package:dr_purple/app/dependency_injection/dependency_injection.dart';
import 'package:dr_purple/core/services/background_uploader/background_uploader.dart';
import 'package:dr_purple/core/utils/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'select_media_state.dart';

class SelectMediaCubit extends Cubit<SelectMediaState> {
  SelectMediaCubit() : super(SelectMediaInitial());

  String? _selectedMedia;
  String? _taskId;

  String? get selectedMedia => _selectedMedia;

  void selectMedia({required XFile media}) {
    emit(SelectingMedia());
    _selectedMedia = media.path;
    instance<MediaUploadBloc>().add(UploadMediaEvent(
      mediaPath: _selectedMedia ?? Constants.empty,
    ));
    emit(MediaSelected());
  }

  Future<void> removeMedia() async {
    emit(RemovingMedia());
    try {
      instance<MediaUploadBloc>().add(MediaUploadInitEvent());
      await BackgroundUploader.cancelFileUploading(
          taskId: _taskId ?? Constants.empty);
    } catch (e) {
      instance<MediaUploadBloc>().add(MediaUploadInitEvent());
      if (kDebugMode) {
        print("Error while canceling upload: ${e.toString()}");
      }
    }
    _selectedMedia = null;
    _taskId = null;
    emit(MediaRemoved());
  }

  void setTaskId(String taskId) => _taskId = taskId;

  void retryUpload() => instance<MediaUploadBloc>().add(UploadMediaEvent(
        mediaPath: _selectedMedia ?? Constants.empty,
      ));
}
