import 'package:dr_purple/core/utils/constants.dart';
import 'package:dr_purple/features/notifications/data/repositories/notifications_repository.dart';
import 'package:dr_purple/features/notifications/domain/entities/notification_entity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'notifications_event.dart';

part 'notifications_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  final NotificationsRepository _notificationsRepository;
  final List<NotificationEntity> _notifications = List.empty(growable: true);

  List<NotificationEntity> get notifications => _notifications;

  NotificationsBloc(this._notificationsRepository)
      : super(NotificationsInitial()) {
    on<GetAllNotifications>((event, emit) async {
      emit(NotificationsLoading(
          loadingType: NotificationsBlocStateType.getNotifications));
      String errorMessage = Constants.empty;
      var res = await _notificationsRepository.getNotifications();
      bool isError = res.fold((l) {
        errorMessage = l.message;
        return true;
      }, (r) {
        for (int i = r.length - 1; i >= 0; i--) {
          _notifications.add(r[i]);
        }
        return false;
      });
      if (isError) {
        emit(NotificationsError(
          errorType: NotificationsBlocStateType.getNotifications,
          errorMessage: errorMessage,
        ));
      } else {
        emit(NotificationsLoaded(
            loadedType: NotificationsBlocStateType.getNotifications));
      }
    });
  }
}
