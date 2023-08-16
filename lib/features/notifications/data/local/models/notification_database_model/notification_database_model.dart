import 'package:dr_purple/core/features/data/local_data_source/models/base_database_model.dart';
import 'package:dr_purple/features/notifications/domain/entities/notification_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'notification_database_model.g.dart';

@JsonSerializable()
class NotificationDatabaseModel extends BaseDatabaseModel {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "body")
  String? body;
  @JsonKey(name: "date")
  String? date;
  @JsonKey(name: "time")
  String? time;

  NotificationDatabaseModel(
      {this.id, this.title, this.body, this.date, this.time});

  factory NotificationDatabaseModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationDatabaseModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationDatabaseModelToJson(this);

  NotificationDatabaseModel copyWith({
    int? id,
    String? title,
    String? body,
    String? date,
    String? time,
  }) =>
      NotificationDatabaseModel(
        id: id ?? this.id,
        title: title ?? this.title,
        body: body ?? this.body,
        date: date ?? this.date,
        time: time ?? this.time,
      );

  NotificationDatabaseModel copyWithObject({
    NotificationDatabaseModel? notificationDatabaseModel,
  }) =>
      NotificationDatabaseModel(
        id: notificationDatabaseModel?.id ?? id,
        title: notificationDatabaseModel?.title ?? title,
        body: notificationDatabaseModel?.body ?? body,
        date: notificationDatabaseModel?.date ?? date,
        time: notificationDatabaseModel?.time ?? time,
      );

  @override
  NotificationEntity toEntity() => NotificationEntity(
      id: id, title: title, body: body, date: date, time: time);
}
