

import 'dart:io';

import 'package:attach/noticiation/notificationservice/call_kit_action_handler.dart';
import 'package:attach/noticiation/notificationservice/handel_audio_call.dart';
import 'package:attach/noticiation/notificationservice/handle_video_call.dart';
import 'package:attach/providers/my_hleper.dart';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';
import 'package:logger/logger.dart';









final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();


class NotificationService{



  final _messaging = FirebaseMessaging.instance;
  final _notification = AwesomeNotifications();

  getNotificationPermission() async
  {
    // var  p = await Permission.notification.request();
   var p = await AwesomeNotifications().requestPermissionToSendNotifications(
      permissions: [
        NotificationPermission.Vibration,
        NotificationPermission.Sound,
        NotificationPermission.Alert,
        NotificationPermission.Badge,
        NotificationPermission.CriticalAlert,
        NotificationPermission.FullScreenIntent,

      ]
    );

   // var p2 = await FlutterCallkitIncoming.requestFullIntentPermission();

   Logger().t("statuseer of full Screen Permmision");
    // var  p = await _messaging.requestPermission(
    //   criticalAlert: true,
    //   alert: true,
    //   sound: true,
    //   providesAppNotificationSettings: true,
    //
    // );
    String? s = await getToken();
    await initChannel();
    startListen();
    Logger().i('this is notification permission $p \n $s');
}


  Future<String?> getToken() async {
   if(kDebugMode)
     {
       var d = await  FirebaseMessaging.instance.getToken();
       return d;
     }
   else
     {
       try {
         NotificationSettings settings = await FirebaseMessaging.instance.requestPermission();

         if (settings.authorizationStatus == AuthorizationStatus.authorized) {
           String? token = await FirebaseMessaging.instance.getToken();
           print('FCM Token: $token');
           return token;

         }

       } catch (e) {
         print('Error getting FCM token: $e');
         MyHelper.snakeBar(navigatorKey.currentContext!, title: 'Failed to get FCM token', message: "Please Check Your Internet Connection or Update Your Google Play Services", type: SnakeBarType.error);
       }
     }
  }




  // Future<String?> getToken() async {
  //   try {
  //     if (Platform.isAndroid) {
  //       await FirebaseMessaging.instance.isSupported();
  //     }
  //
  //     NotificationSettings settings = await FirebaseMessaging.instance.requestPermission();
  //
  //     if (settings.authorizationStatus == AuthorizationStatus.authorized) {
  //
  //       int retryCount = 0;
  //       const maxRetries = 3;
  //
  //       while (retryCount < maxRetries) {
  //         try {
  //           String? token = await FirebaseMessaging.instance.getToken();
  //           if (token != null) {
  //             print('FCM Token: $token');
  //             return token;
  //           } else {
  //             throw Exception('Token is null');
  //           }
  //         } catch (e) {
  //           retryCount++;
  //           print('Attempt $retryCount failed: $e');
  //           if (retryCount >= maxRetries) {
  //             MyHelper.snakeBar(
  //               navigatorKey.currentContext!,
  //               title: 'Failed to get FCM token',
  //               message: 'Please check your internet connection or Google Play Services.',
  //               type: SnakeBarType.error,
  //               duration: Duration(seconds: 5)
  //             );
  //             return null;
  //           }
  //           await Future.delayed(Duration(seconds: 2)); // Wait before retrying
  //         }
  //       }
  //     } else {
  //
  //
  //       MyHelper.snakeBar(
  //         navigatorKey.currentContext!,
  //         title: 'Notification Permission Denied',
  //         message: 'Please allow notification permissions.',
  //       );
  //       return null;
  //     }
  //
  //   } catch (e) {
  //     print('Error getting FCM token: $e');
  //     MyHelper.snakeBar(
  //       navigatorKey.currentContext!,
  //       title: 'Failed to get FCM token',
  //       message: "$e",
  //       type: SnakeBarType.error,
  //     );
  //     return null;
  //   }
  //   return null;
  // }


  startListen()
 {
   FirebaseMessaging.onMessage.listen((message) {
     Logger().i("notification recived ${message.toMap()}");

     showNotification(message);


   },);

/*   FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
     //TODO
     Logger().i("App Opne From Fire base");
     OpenDailogWithAnimation(navigatorKey.currentContext!, dailog: (animation, secondryAnimation) =>AlertDialog(
       title: Text("Appp Opneby fire baser"),
     ),);
   });*/
 }

 initChannel() async
 {

   Logger().i("initing notification channesl");


   await AwesomeNotifications().initialize(
       null, //'resource://drawable/res_app_icon',//
       [
         NotificationChannel(
             channelKey: 'NOTIFICATION_CHANNEL',
             channelName: 'NOTIFICATION_CHANNEL',
             channelDescription: 'Notification tests as alerts',
             playSound: true,
             onlyAlertOnce: true,
             groupAlertBehavior: GroupAlertBehavior.Children,
             importance: NotificationImportance.High,
             defaultPrivacy: NotificationPrivacy.Private,
             defaultColor: Colors.deepPurple,
             ledColor: Colors.deepPurple
         )
       ],
       debug: true);



   await AwesomeNotifications().initialize(
       null, //'resource://drawable/res_app_icon',//
       [
         NotificationChannel(
             channelKey: 'TEST',
             channelName: 'TEST',
             channelDescription: 'Notification tests as alerts',
             playSound: true,
             onlyAlertOnce: true,
             groupAlertBehavior: GroupAlertBehavior.Children,
             locked: true,
             criticalAlerts: true,
             importance: NotificationImportance.Max,
             defaultPrivacy: NotificationPrivacy.Private,
             defaultColor: Colors.deepPurple,
             ledColor: Colors.deepPurple
         )
       ],
       debug: true);

   await AwesomeNotifications().initialize(
       null, //'resource://drawable/res_app_icon',//
       [
         NotificationChannel(
             channelKey: 'VIDEO_CALL_CHANNEL',
             channelName: 'VIDEO_CALL_CHANNEL',
             channelDescription: 'Notification tests as alerts',
             playSound: true,
             onlyAlertOnce: true,
             groupAlertBehavior: GroupAlertBehavior.Children,
           criticalAlerts: true,
           locked: true,

             importance: NotificationImportance.Max,
             defaultPrivacy: NotificationPrivacy.Private,
             defaultColor: Colors.deepPurple,
             ledColor: Colors.deepPurple,


         )
       ],
       debug: true);

   await AwesomeNotifications().initialize(
       null, //'resource://drawable/res_app_icon',//
       [
         NotificationChannel(
             channelKey: 'AUDIO_CALL_CHANNEL',
             channelName: 'AUDIO_CALL_CHANNEL',
             channelDescription: 'Notification tests as alerts',
           playSound: true,
           onlyAlertOnce: true,
           groupAlertBehavior: GroupAlertBehavior.Children,
           criticalAlerts: true,
           locked: true,

           importance: NotificationImportance.Max,
           defaultPrivacy: NotificationPrivacy.Private,
           defaultColor: Colors.deepPurple,
           ledColor: Colors.deepPurple,

         )
       ],
       debug: true);



   await AwesomeNotifications().initialize(
       null, //'resource://drawable/res_app_icon',//
       [
         NotificationChannel(
           channelKey: 'UPLOAD_FILE',
           channelName: 'UPLOAD_FILE',
           channelDescription: 'Notification tests as alerts',
           playSound: true,
           onlyAlertOnce: true,
           groupAlertBehavior: GroupAlertBehavior.Children,
           criticalAlerts: true,
           locked: true,
           importance: NotificationImportance.Max,
           defaultPrivacy: NotificationPrivacy.Private,
           defaultColor: Colors.deepPurple,
           ledColor: Colors.deepPurple,

         )
       ],
       debug: true);


   // initCallKitListener();
 }





  void initCallKitListener() {
    FlutterCallkitIncoming.onEvent.listen((event) {
      callKitActionhanlde(event);
    });
  }


 showNotification(RemoteMessage message,{bool fromBackGround =false}) async
 {


   Logger().i('this is Data \n${message.data['status']}  \n${message.notification?.android?.channelId} \n${message.data}');


   if(message.notification?.android?.channelId=="VIDEO_CALL_CHANNEL")
   {
     handleVideoCall(message);
   }


   if(message.notification?.android?.channelId=="AUDIO_CALL_CHANNEL")
   {
     handleAudioCall(message);
   }


   if(message.notification?.android?.channelId=="NOTIFICATION_CHANNEL")
     {

       print("teying teh notification");
       await  AwesomeNotifications().createNotification(
           content: NotificationContent(
             id: 0,
             channelKey: "NOTIFICATION_CHANNEL",
             title: message.notification?.title??'',
             body: message.notification?.body??'',
             fullScreenIntent: true,
             wakeUpScreen: true,
             criticalAlert: false,
             // category: NotificationCategory.Alarm,
             notificationLayout: NotificationLayout.Default,
             autoDismissible: true,
             locked: true,

           )
       );
     }

   if(message.notification?.android?.channelId=="TEST")
     {
       AwesomeNotifications().createNotification(
           content: NotificationContent(
             id: 0,
             channelKey: "TEST",
             title: message.notification?.title??'',
             body:"this is from backgound $fromBackGround",
             fullScreenIntent: true,
             wakeUpScreen: true,
             criticalAlert: true,

             // category: NotificationCategory.Alarm,
             notificationLayout: NotificationLayout.Default,
             autoDismissible: false,
             locked: true,
           ),
       );



       // AwesomeNotifications().createNotification(
       //   content: NotificationContent(
       //     id: 0,
       //     channelKey: "TEST",
       //     title: "Title",
       //     body:"Body",
       //     fullScreenIntent: true,
       //     wakeUpScreen: true,
       //     criticalAlert: true,
       //     // category: NotificationCategory.Alarm,
       //     notificationLayout: NotificationLayout.Default,
       //     autoDismissible: false,
       //     locked: true,
       //   ),
       // );

     }



 }




}




