

import 'dart:convert';
import 'dart:io';

import 'package:attach/noticiation/notification%20action%20handler.dart';
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




  startListen()
 {
   FirebaseMessaging.onMessage.listen((message) {
     Logger().i("notification recived ${message.toMap()}");

     showNotification(message);


   },);


 }

 initChannel() async
 {

   Logger().i("initing notification channesl");


   await AwesomeNotifications().initialize(
       null, //'resource://drawable/res_app_icon',//
       [
         NotificationChannel(
             channelKey: 'NOTIFICATION_CHANNEL',
             channelName: 'Notification Channel',
             channelDescription: 'For Displaying Notification and Alerts',
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



  if(kDebugMode)
    {
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
    }

   await AwesomeNotifications().initialize(
       null, //'resource://drawable/res_app_icon',//
       [
         NotificationChannel(
             channelKey: 'VIDEO_CALL_CHANNEL',
             channelName: 'Video Call Channel',
             channelDescription: 'If you disable this channel, you will not receive video call notifications.',
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
             channelName: 'Audio Call Channel',
             channelDescription: 'If you disable this channel, you will not receive audio call notifications.',
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
           channelName: 'Upload File Channel',
           channelDescription: 'For Uploading Files',
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


     if(message.notification?.android?.channelId=="MESSAGE_CHANNEL")
     {
       await  AwesomeNotifications().createNotification(
           content: NotificationContent(
             id: 0,
             channelKey: "MESSAGE_CHANNEL",
             title: message.notification?.title??'',
             body: message.notification?.body??'',
             fullScreenIntent: true,
             wakeUpScreen: true,
             criticalAlert: false,
             payload:{"Mene data bheja":"On thune reecve kyou nahi kiya"},
             // category: NotificationCategory.Alarm,
             notificationLayout: NotificationLayout.Default,
             autoDismissible: true,

           )
       );
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
             payload:(message.data!=null)?message.data.map((key, value) => MapEntry(key, value.toString())):null,
             // category: NotificationCategory.Alarm,
             notificationLayout: NotificationLayout.Default,
             autoDismissible: true,

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
             payload:  {"Mene data bheja":"On thune reecve kyou nahi kiya"},
             // category: NotificationCategory.Alarm,
             notificationLayout: NotificationLayout.Default,
             autoDismissible: false,
             locked: true,
           ),
       );


     }



 }




}




