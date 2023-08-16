import 'package:dartz/dartz.dart';
import 'package:dr_purple/core/error_handler/error_handler.dart';
import 'package:dr_purple/core/features/domain/entities/error_entity.dart';
import 'package:dr_purple/features/notifications/data/local/data_sources/notifications_local_data_source.dart';
import 'package:dr_purple/features/notifications/data/local/models/notification_database_model/notification_database_model.dart';
import 'package:dr_purple/features/notifications/domain/entities/notification_entity.dart';
import 'package:dr_purple/features/notifications/domain/repositories/inotifications_repository.dart';
import 'package:flutter/foundation.dart';

class NotificationsRepository extends INotificationsRepository {
  final NotificationsLocalDataSource _localDataSource;

  NotificationsRepository(this._localDataSource);

  @override
  Future<Either<ErrorEntity, bool>> addNotification(
      NotificationDatabaseModel notification) async {
    try {
      final res = await _localDataSource.addNotification(notification);
      if (res) {
        return Right(res);
      } else {
        return Left(
          ErrorEntity(
            statusCode: ResponseCode.databaseError,
            message: ResponseMessage.databaseError,
          ),
        );
      }
    } on ErrorHandler catch (e) {
      if (kDebugMode) {
        print("error while adding notification into database: ${e.toString()}");
      }
      return Left(e.errorEntity);
    } catch (e) {
      if (kDebugMode) {
        print("error while adding notification into database: ${e.toString()}");
      }
      return Left(ErrorHandler.handle(DataSource.databaseError).errorEntity);
    }
  }

  @override
  Future<Either<ErrorEntity, List<NotificationEntity>>>
      getNotifications() async {
    try {
      final res = await _localDataSource.getNotifications();
      if (res != null) {
        List<NotificationEntity> valetPoints =
            List<NotificationEntity>.empty(growable: true);
        for (var valetPoint in res) {
          valetPoints.add(valetPoint.toEntity());
        }
        return Right(valetPoints);
      } else {
        return Left(
          ErrorEntity(
            statusCode: ResponseCode.databaseNullError,
            message: ResponseMessage.databaseNullError,
          ),
        );
      }
    } on ErrorHandler catch (e) {
      if (kDebugMode) {
        print(
            "error while getting notification from database: ${e.toString()}");
      }
      return Left(e.errorEntity);
    } catch (e) {
      if (kDebugMode) {
        print(
            "error while getting notification from database: ${e.toString()}");
      }
      return Left(ErrorHandler.handle(DataSource.databaseError).errorEntity);
    }
  }
}
