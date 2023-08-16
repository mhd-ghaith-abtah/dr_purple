// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_database_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationDatabaseModel _$NotificationDatabaseModelFromJson(
        Map<String, dynamic> json) =>
    NotificationDatabaseModel(
      id: json['id'] as int?,
      title: json['title'] as String?,
      body: json['body'] as String?,
      date: json['date'] as String?,
      time: json['time'] as String?,
    );

Map<String, dynamic> _$NotificationDatabaseModelToJson(
        NotificationDatabaseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'body': instance.body,
      'date': instance.date,
      'time': instance.time,
    };
