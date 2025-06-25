
import 'dart:io';

import 'package:android_intent_plus/android_intent.dart';
import 'package:attach/api/local_db.dart';
import 'package:attach/noticiation/notificationService.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {


  await Firebase.initializeApp();
  // Make sure Firebase is initialized
  print('🔔 Background message received: ${message.messageId}');

  try {
     DB().saveSomeDate(message.data);
  } catch (e) {
    print('Error parsing JSON: $e');
  }


  // if(message.notification?.android?.channelId=='VIDEO_CALL_CHANNEL')
  //   {
  //     if (Platform.isAndroid) {
  //       const intent = AndroidIntent(
  //         action: 'com.attachchat.app.ACTION_SHOW_CALL_SCREEN',
  //         package: 'com.attachchat.app', // Replace with your package
  //       );
  //
  //       await intent.launch();
  //
  //       if(navigatorKey.currentContext==null)
  //         {
  //           Logger().e('Context is Null ');
  //         }
  //       else
  //         {
  //           showDialog(context: navigatorKey.currentContext!, builder: (context) => AlertDialog(
  //             title: Text("Call is Comming"),
  //             content: Text("${message.data}"),
  //           ),);
  //         }
  //
  //     }
  //   }

  NotificationService().showNotification(message,fromBackGround: true);
}