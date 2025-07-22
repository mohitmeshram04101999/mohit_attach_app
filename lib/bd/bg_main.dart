import 'dart:async';
import 'dart:ui';
import 'package:attach/api/local_db.dart';
import 'package:attach/bd/bd_call_event_handler.dart';
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


bool bgServiceIsRunning  = false;




Future<void> initBgService() async {




  if(bgServiceIsRunning){
    print("bg service is already running");
    return;
  }

  Logger().i("Init bg service is Called");




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
    iosConfiguration: IosConfiguration(
      autoStart: true,
      onForeground: _onStart,
    ),

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


  service.startService();

}


//
// @pragma('vm:entry-point')
// void _onStart(ServiceInstance service) async{
//   WidgetsFlutterBinding.ensureInitialized();
//   DartPluginRegistrant.ensureInitialized();
//
//
//
//
//
//
//
//
//   await Firebase.initializeApp();
//
//
//
//   // Create initial notification
//   AwesomeNotifications().createNotification(
//
//     content: NotificationContent(
//       id: 77470,
//       channelKey: 'basic_channel',
//       title: '',
//       body: '',
//       autoDismissible: false,
//
//     ),
//   );
//
//
//   service.invoke("soem thiin happend",{'asd':'asdfadsadsf'});
//
//   print("soem thiin happend ${navigatorKey.currentState==null}");
//
//
//
//   initCallKitListener(service);
//
//
//
//
//
//   // Connect the socket globally
//
// }




@pragma('vm:entry-point')
void _onStart(ServiceInstance service) async {


  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();


  bgServiceIsRunning = true;
  Logger().e("BackGround SService has been Started");

  if (service is AndroidServiceInstance) {


    service.setForegroundNotificationInfo(
      title: "Attach Is Running",
      content: "Online",
    );
  }

  await Firebase.initializeApp();

  initCallKitListener(service);




  Timer.periodic(Duration(seconds: 15), (timer) async {
    if (service is AndroidServiceInstance) {
 
      service.setForegroundNotificationInfo(
        title: "Attach Is Running",
        content: "Online",
      );
    }


    service.invoke('update', {
      'timestamp': DateTime.now().toString(),
    });


    // service.on("stop").listen((d){
    //
    //   service.invoke("stopCallListener");
    //   service.stopSelf();
    //   Logger().e("BackGround SService has been Storp");
    //   bgServiceIsRunning = false;
    // });

    service.on("stop").listen((d) {
      service.invoke("stopCallListener");// stop listeners
      service.stopSelf();
      bgServiceIsRunning = false;
      Logger().e("Background Service stopped");
    });






  });
}




void initCallKitListener(ServiceInstance serviceInstance) {
  Logger().i("initCallKitListener called");
  FlutterCallkitIncoming.onEvent.listen((event) {
    callKitActionhanlde(event,serviceInstance: serviceInstance);  }
  );

}


