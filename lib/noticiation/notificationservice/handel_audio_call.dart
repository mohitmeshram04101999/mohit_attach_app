import 'dart:convert';

import 'package:attach/modles/otp_responce.dart';

import 'package:attach/noticiation/notificationService.dart';
import 'package:attach/providers/audio%20call%20provider.dart';
import 'package:attach/providers/call_kit_mennager.dart';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

handleAudioCall(RemoteMessage message) async
{


  var u = User.fromJson(jsonDecode(message.data['user']));
  if(message.data['status']=='INCOMING')
  {
    CallKitManager().receiveAudioCall(u,message.data,message.notification?.android?.channelId??'');
  }
  if(message.data['status']=="REJECTED")
  {
    CallKitManager().callEnd(message.data['callId']);
    AwesomeNotifications().createNotification(
      content: NotificationContent(id: 0, channelKey: "AUDIO_CALL_CHANNEL",
        title: "${u.name}",
        body: 'Call Decline',

      ),
    );
    Logger().i("this is context status ${navigatorKey.currentContext==null}");
    if(navigatorKey.currentContext!=null)
      {
        var p =  Provider.of<AudioCallProvider>(navigatorKey.currentContext!,listen: false);
        print("chackin if user is on call screen ${p.onCallScreen} ${p.onOutGoingCallScreen}");
        if(p.onCallScreen||p.onOutGoingCallScreen)
        // if(p.onOutGoingCallScreen)
        {
          print("Call id declined closing screen");
          Navigator.pop(navigatorKey.currentContext!);
        }
        p.leaveCall();
      }
  }
  if(message.data['status']=="MISSED")
  {
    CallKitManager().callEnd(message.data['callId']);
    AwesomeNotifications().createNotification(
      content: NotificationContent(id: 0, channelKey: "AUDIO_CALL_CHANNEL",
        title: "${u.name}",
        body: 'Call Not Receive',
      ),
    );
    var p = Provider.of<AudioCallProvider>(navigatorKey.currentContext!,listen: false);
    print("chackin if user is on call screen ${p.onCallScreen}");

    if(p.onCallScreen ||p.onOutGoingCallScreen)
    {
      Navigator.pop(navigatorKey.currentContext!);
    }
    p.leaveCall();
  }


  if(message.data['status']=="ANSWERED")
  {

    var user  = User.fromJson(jsonDecode(message.data['user']));
  if(navigatorKey.currentContext!=null)
    {
      var p = Provider.of<AudioCallProvider>(navigatorKey.currentContext!,listen: false);
      if(p.onOutGoingCallScreen)
      {
        Navigator.pop(navigatorKey.currentContext!);
      }
      p.joinCall(u: user, threadId: message.data['threadId'], callId: message.data['callId']);
    }

  }

  if(message.data['status']=="COMPLETE")
  {
    CallKitManager().callEnd(message.data['callId']);
    if(navigatorKey.currentContext!=null)
      {
        var p = Provider.of<AudioCallProvider>(navigatorKey.currentContext!,listen: false);
        print("chackin if user is on call screen ${p.onCallScreen}");
        if(p.onCallScreen)
        {
          Navigator.pop(navigatorKey.currentContext!);
        }
        p.leaveCall(update: false);
      }
  }

}