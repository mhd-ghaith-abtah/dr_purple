import 'package:dartz/dartz.dart';
import 'package:dr_purple/core/features/domain/entities/error_entity.dart';
import 'package:dr_purple/core/features/domain/repositories/irepository.dart';
import 'package:dr_purple/features/notifications/data/local/models/notification_database_model/notification_database_model.dart';
import 'package:dr_purple/features/notifications/domain/entities/notification_entity.dart';

abstract class INotificationsRepository extends IRepository {
  Future<Either<ErrorEntity, bool>> addNotification(
    NotificationDatabaseModel notification,
  );

  Future<Either<ErrorEntity, List<NotificationEntity>>> getNotifications();
}
