import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:azaadi_vpn_android/controller/notification_controller.dart';
import 'package:flutter/material.dart';

class TempNotificationsPage extends StatefulWidget {
  const TempNotificationsPage({super.key});

  @override
  State<TempNotificationsPage> createState() => _TempNotificationsPageState();
}

class _TempNotificationsPageState extends State<TempNotificationsPage> {
  @override
  void initState() {
    super.initState();
    AwesomeNotifications().setListeners(
        onActionReceivedMethod: NotificationController.onActionReceivedMethod,
        onDismissActionReceivedMethod:
            NotificationController.onDismissActionReceivedMethod,
        onNotificationCreatedMethod:
            NotificationController.onNotificationCreateMethod,
        onNotificationDisplayedMethod:
            NotificationController.onNotificationDisplayedMethod);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              Future.delayed(Duration(seconds: 2)).then((value) {
                AwesomeNotifications().createNotification(
                    content: NotificationContent(
                        id: 0,
                        channelKey: 'connection_status',
                        title: 'First',
                        body: 'This is a notification 22'));
              });
            },
            child: Text('Notification')),
      ),
    );
  }
}
