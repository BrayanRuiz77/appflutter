import 'package:flutter_riverpod/flutter_riverpod.dart';

final notificationProvider = StateNotifierProvider<NotificationProvider, bool>(
    (ref) => NotificationProvider());

class NotificationProvider extends StateNotifier<bool> {
  NotificationProvider() : super(false);

  void setNotifications(bool value) {
    state = value;
  }
}
