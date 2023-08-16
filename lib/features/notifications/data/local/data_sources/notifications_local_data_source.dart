import 'package:dr_purple/app/storage/database/notifications_database_helper.dart';
import 'package:dr_purple/core/features/data/local_data_source/local_data_source.dart';
import 'package:dr_purple/features/notifications/data/local/models/notification_database_model/notification_database_model.dart';

abstract class INotificationsLocalDataSource extends LocalDataSource {
  Future<bool> addNotification(NotificationDatabaseModel notification);

  Future<List<NotificationDatabaseModel>?> getNotifications();
}

class NotificationsLocalDataSource extends INotificationsLocalDataSource {
  final NotificationsDatabaseHelper _notificationsDatabaseHelper;

  NotificationsLocalDataSource(this._notificationsDatabaseHelper);

  @override
  Future<bool> addNotification(NotificationDatabaseModel notification) async {
    var res = await _notificationsDatabaseHelper.addNotification(
      notification: notification,
    );
    return Future.value(res);
  }

  @override
  Future<List<NotificationDatabaseModel>?> getNotifications() async {
    var res = await _notificationsDatabaseHelper.getNotifications();
    return Future.value(
      res != null && res.isNotEmpty
          ? res
              .map((notification) =>
                  NotificationDatabaseModel.fromJson(notification))
              .toList()
          : null,
    );
  }
}
