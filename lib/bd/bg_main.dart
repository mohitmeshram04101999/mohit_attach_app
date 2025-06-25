import 'dart:ui';
import 'package:attach/api/local_db.dart';
import 'package:attach/noticiation/notificationService.dart';
import 'package:attach/noticiation/notificationservice/call_kit_action_handler.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';
import 'package:logger/logger.dart';
import 'package:socket_io_client/socket_io_client.dart' as Io;


final service = FlutterBackgroundService();



Future<void> initBgService() async {



  String channelId = 'basic_channel';
  String channelName = 'Basic notifications';
  String channelDescription = 'Notification channel for basic tests';

  await Firebase.initializeApp();

  await AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
        channelKey: channelId,
        channelName: channelName,
        channelDescription: channelDescription,
        playSound: false,
        enableVibration: false,
        locked: true,
        importance: NotificationImportance.Min,
        onlyAlertOnce: true,
        channelShowBadge: false,
      )
    ],
  );

  service.configure(
    iosConfiguration: IosConfiguration(),
    androidConfiguration: AndroidConfiguration(
      onStart: _onStart,
      autoStartOnBoot: true,
      isForegroundMode: true,
      autoStart: true,
      notificationChannelId: channelId,
      initialNotificationTitle: '',
      initialNotificationContent: '',
      foregroundServiceNotificationId: 77470,

    ),
  );
}

@pragma('vm:entry-point')
void _onStart(ServiceInstance service) async{
  await WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();


  await Firebase.initializeApp();

  // Create initial notification
  AwesomeNotifications().createNotification(

    content: NotificationContent(
      id: 77470,
      channelKey: 'basic_channel',
      title: '',
      body: '',
      autoDismissible: false,

    ),
  );


  service.invoke("soem thiin happend",{'asd':'asdfadsadsf'});

  print("soem thiin happend ${navigatorKey.currentState==null}");



  initCallKitListener(service);





  // Connect the socket globally

}




void initCallKitListener(ServiceInstance service) {
  FlutterCallkitIncoming.onEvent.listen((event) {
    callKitActionhanlde(event,service: service);  }
  );
}

