part of 'notifications_bloc.dart';

@immutable
abstract class NotificationsState {}

class NotificationsInitial extends NotificationsState {}

class NotificationsLoading extends NotificationsState {
  final NotificationsBlocStateType loadingType;

  NotificationsLoading({required this.loadingType});
}

class NotificationsLoaded extends NotificationsState {
  final NotificationsBlocStateType loadedType;

  NotificationsLoaded({required this.loadedType});
}

class NotificationsError extends NotificationsState {
  final NotificationsBlocStateType errorType;
  final String errorMessage;

  NotificationsError({required this.errorType, required this.errorMessage});
}

enum NotificationsBlocStateType { getNotifications }
