import 'package:dr_purple/app/app_management/strings_manager.dart';
import 'package:dr_purple/core/features/data/remote_data_source/models/params/params_model.dart';
import 'package:dr_purple/core/features/data/remote_data_source/remote_data_source.dart';
import 'package:dr_purple/core/utils/enums.dart';
import 'package:easy_localization/easy_localization.dart';

extension NonNullString on String? {
  String messageOrEmpty({String? message}) => this ?? message ?? "";
}

extension NonNullInteger on int? {
  int numberOrZero({int? number}) => this ?? number ?? 0;
}

extension TrueOrFalse on int? {
  bool boolValue() => this == null || this == 0 ? false : true;
}

extension GenderExt on Gender {
  String getLocalizedString() {
    switch (this) {
      case Gender.male:
        return AppStrings.male.tr();
      case Gender.female:
        return AppStrings.female.tr();
    }
  }

  int getServerValue() {
    switch (this) {
      case Gender.male:
        return 1;
      case Gender.female:
        return 2;
    }
  }
}

extension HTTPRequestType on RequestType {
  Future<Map<String, dynamic>> getHTTPRequestType(
    RemoteDataSource remoteDataSource,
    ParamsModel model,
  ) async {
    switch (this) {
      case RequestType.post:
        return await remoteDataSource.post(model);
      case RequestType.get:
        return await remoteDataSource.get(model);
      case RequestType.mediaUpload:
        return await remoteDataSource.uploadFile(model);
      case RequestType.delete:
        return await remoteDataSource.delete(model);
      case RequestType.put:
        return await remoteDataSource.put(model);
    }
  }
}
