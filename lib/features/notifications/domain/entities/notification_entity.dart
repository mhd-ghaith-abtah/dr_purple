import 'package:dr_purple/core/features/domain/entities/entity.dart';
import 'package:dr_purple/features/notifications/data/local/models/notification_database_model/notification_database_model.dart';

class NotificationEntity extends Entity {
  final int? id;
  final String? title;
  final String? body;
  final String? date;
  final String? time;

  NotificationEntity({this.id, this.title, this.body, this.date, this.time});

  NotificationDatabaseModel toDatabaseModel() {
    return NotificationDatabaseModel(
      id: id,
      title: title,
      body: body,
      date: date,
      time: time,
    );
  }

  @override
  List<Object?> get props => [id, title, body, date, time];
}
