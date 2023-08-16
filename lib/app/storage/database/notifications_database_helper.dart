import 'package:dr_purple/app/storage/database/dr_purple_database.dart';
import 'package:dr_purple/core/error_handler/error_handler.dart';
import 'package:dr_purple/features/notifications/data/local/models/notification_database_model/notification_database_model.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

class NotificationsDatabaseHelper {
  final DrPurpleDatabase _db;

  NotificationsDatabaseHelper(this._db);

  /// notifications table methods
  Future<bool> addNotification(
      {required NotificationDatabaseModel notification}) async {
    try {
      Database? db = await _db.createDb();
      await db!.insert(_db.kNotificationsTable, notification.toJson());
      return true;
    } catch (e) {
      if (kDebugMode) {
        print(
            "Error while adding new notification into database: ${e.toString()}");
      }
      throw ErrorHandler.handle(DataSource.databaseError);
    }
  }

  Future<List<Map<String, Object?>>?> getNotifications() async {
    try {
      Database? db = await _db.createDb();
      return await db!.query(_db.kNotificationsTable);
    } catch (e) {
      if (kDebugMode) {
        print(
            "Error while getting notifications from database: ${e.toString()}");
      }
      throw ErrorHandler.handle(DataSource.databaseError);
    }
  }
}
