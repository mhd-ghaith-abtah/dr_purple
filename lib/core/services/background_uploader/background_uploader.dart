import 'dart:io';

import 'package:dr_purple/app/app_management/language_manager/language_manager.dart';
import 'package:dr_purple/app/app_management/media/presentation/blocs/media_upload_bloc/media_upload_bloc.dart';
import 'package:dr_purple/app/app_management/strings_manager.dart';
import 'package:dr_purple/app/dependency_injection/dependency_injection.dart';
import 'package:dr_purple/core/error_handler/error_handler.dart';
import 'package:dr_purple/core/services/notification_service/notification_service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:easy_localization/src/easy_localization_controller.dart';
import 'package:easy_localization/src/localization.dart';
import 'package:flutter_uploader/flutter_uploader.dart';

class BackgroundUploader {
  BackgroundUploader._();

  static final _uploader = FlutterUploader();

  static void initializeListeners() {
    _uploader.progress.listen(
      (currentUploadingFile) {
        if (currentUploadingFile.status == UploadTaskStatus.enqueued ||
            currentUploadingFile.status == UploadTaskStatus.undefined) {
          instance<MediaUploadBloc>().add(
            MediaWaitingInQueueEvent(taskId: currentUploadingFile.taskId),
          );
        } else if (currentUploadingFile.status == UploadTaskStatus.complete ||
            currentUploadingFile.status == UploadTaskStatus.canceled ||
            currentUploadingFile.status == UploadTaskStatus.failed) {
          _uploader.clearUploads();
        } else if (currentUploadingFile.status == UploadTaskStatus.running) {
          instance<MediaUploadBloc>().add(
            MediaIsUploadingEvent(
              taskId: currentUploadingFile.taskId,
              progress: currentUploadingFile.progress! / 100,
            ),
          );
        }
      },
      cancelOnError: true,
    );

    _uploader.result.listen((currentUploadingFile) async {
      if (currentUploadingFile.status == UploadTaskStatus.complete) {
        instance<MediaUploadBloc>().add(
          MediaUploadedSuccessfullyEvent(
            response: currentUploadingFile.response ?? "",
            taskId: currentUploadingFile.taskId,
          ),
        );
        _uploader.clearUploads();
      } else if (currentUploadingFile.status == UploadTaskStatus.paused) {
        _uploader.cancel(taskId: currentUploadingFile.taskId);
        _uploader.clearUploads();
      } else if (currentUploadingFile.status == UploadTaskStatus.canceled) {
        instance<MediaUploadBloc>().add(
          UploadingMediaCanceledEvent(taskId: currentUploadingFile.taskId),
        );
        _uploader.clearUploads();
      } else if (currentUploadingFile.status == UploadTaskStatus.failed) {
        instance<MediaUploadBloc>().add(
          ErrorUploadingMediaEvent(taskId: currentUploadingFile.taskId),
        );
        _uploader.clearUploads();
      }
    });
  }

  static Future<Map<String, dynamic>> enqueueFile({
    required String filePath,
    required Map<String, String> headers,
    required String url,
  }) async {
    try {
      final taskId = await _uploader.enqueue(
        MultipartFormDataUpload(
          url: url,
          headers: headers,
          files: [FileItem(path: filePath, field: "profilePic")],
        ),
      );
      return {
        AppStrings.taskId: taskId,
        AppStrings.message: null,
        AppStrings.code: ResponseCode.success,
        AppStrings.success: true,
      };
    } catch (e) {
      if (kDebugMode) {
        print("Error while starting upload image to server: ${e.toString()}");
      }
      throw ErrorHandler.handle(DataSource.backgroundUploaderError);
    }
  }

  static Future<void> cancelFileUploading({
    required String taskId,
  }) async =>
      await _uploader.cancel(taskId: taskId);

  static Future<void> cancelAllFilesUploading() async =>
      await _uploader.cancelAll();

  static Future<void> clearAllUploadedFiles() async =>
      await _uploader.clearUploads();

  static Future<void> setFlutterUploaderBackgroundHandler() async =>
      await _uploader.setBackgroundHandler(flutterUploaderBackgroundHandler);
}

@pragma("vm:entry-point")
Future<void> flutterUploaderBackgroundHandler() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalizationController.initEasyLocation();
  final controller = EasyLocalizationController(
    saveLocale: true,
    fallbackLocale: SupportedLanguages.all[0],
    supportedLocales: SupportedLanguages.all,
    assetLoader: const RootBundleAssetLoader(),
    useOnlyLangCode: false,
    useFallbackTranslations: true,
    path: translationAssetsPath,
    onLoadError: (FlutterError e) {},
  );
  await controller.loadTranslations();
  Localization.load(
    controller.locale,
    translations: controller.translations,
    fallbackTranslations: controller.fallbackTranslations,
  );
  neededInBackgroundUploaderModule();
  final notificationService = instance<NotificationService>();
  BackgroundUploader._uploader.progress.listen(
    (value) async {
      if (Platform.isAndroid) {
        await notificationService.createAttachmentProgressNotification(
          progress: value.progress ?? 0,
          taskId: value.taskId.hashCode,
          buttons: [
            AndroidNotificationAction(
              value.taskId,
              AppStrings.cancelAction.tr(),
              showsUserInterface: true,
            ),
          ],
        );
      }
    },
  );
  BackgroundUploader._uploader.result.listen((value) {
    if (value.status == UploadTaskStatus.complete) {
      notificationService
        ..dismissNotification(value.taskId.hashCode)
        ..createAttachmentCompleteOrFailedNotification(
          taskId: value.taskId.hashCode,
          body: AppStrings.mediaUploadedNotification.tr(),
        );
    } else if (value.status == UploadTaskStatus.failed) {
      notificationService
        ..dismissNotification(value.taskId.hashCode)
        ..createAttachmentCompleteOrFailedNotification(
          taskId: value.taskId.hashCode,
          body: AppStrings.mediaUploadingFailedNotification.tr(),
        );
    } else if (value.status == UploadTaskStatus.canceled) {
      notificationService
        ..dismissNotification(value.taskId.hashCode)
        ..createAttachmentCompleteOrFailedNotification(
          taskId: value.taskId.hashCode,
          body: AppStrings.mediaUploadingCanceledNotification.tr(),
        );
    }
  });
}
