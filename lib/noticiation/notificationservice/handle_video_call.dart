

import 'dart:convert';

import 'package:attach/modles/otp_responce.dart';
import 'package:attach/myfile/myast%20dart%20file.dart';
import 'package:attach/noticiation/notificationService.dart';
import 'package:attach/providers/call_kit_mennager.dart';
import 'package:attach/providers/videoCallProvider.dart';
import 'package:attach/screens/dash_board_screen/inbox/tabs/videoCallScreen.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';

import 'package:provider/provider.dart';

handleVideoCall(RemoteMessage message) async
{


  var u = User.fromJson(jsonDecode(message.data['user']));
  if(message.data['status']=='INCOMING')
  {

    CallKitManager().receiveCall(u,message.data,message.notification?.android?.channelId??'');
  }
  if(message.data['status']=="REJECTED")
  {
    CallKitManager().callEnd(message.data['callId']);
    AwesomeNotifications().createNotification(
      content: NotificationContent(id: 0, channelKey: "VIDEO_CALL_CHANNEL",
        title: "${u.name}",
        body: 'Call Decline',

      ),
    );
    var p =  Provider.of<VideoCallProvider>(navigatorKey.currentContext!,listen: false);
    print("chackin if user is on call screen ${p.isOnCallScreen}");

    if(p.isOnCallScreen)
    {
      p.onCall(false);
      Navigator.pop(navigatorKey.currentContext!);
    }
    if(p.outGoingCallScreen)
      {
        p.updateOutGoingCallStatus(false);
        Navigator.pop(navigatorKey.currentContext!);
      }
    Provider.of<VideoCallProvider>(navigatorKey.currentContext!,listen: false).leaveCall();
  }
  if(message.data['status']=="MISSED")
  {
    CallKitManager().callEnd(message.data['callId']);

    AwesomeNotifications().createNotification(
      content: NotificationContent(id: 0, channelKey: "VIDEO_CALL_CHANNEL",
        title: "${u.name}",
        body: 'Call Not Receive',
      ),
    );

    var p = Provider.of<VideoCallProvider>(navigatorKey.currentContext!,listen: false);
    print("chackin if user is on call screen ${p.isOnCallScreen}");

    if(p.isOnCallScreen)
    {
      p.onCall(false);
      Navigator.pop(navigatorKey.currentContext!);
    }
    if(p.outGoingCallScreen)
      {
        p.updateOutGoingCallStatus(false);
        Navigator.pop(navigatorKey.currentContext!);
      }
    Provider.of<VideoCallProvider>(navigatorKey.currentContext!,listen: false).leaveCall();
  }


  if(message.data['status']=="ANSWERED")
    {

      var user  = User.fromJson(jsonDecode(message.data['user']));
      if(navigatorKey.currentContext!=null)
        {
          var p = Provider.of<VideoCallProvider>(navigatorKey.currentContext!,listen: false);
          if(p.outGoingCallScreen)
          {
            p.updateOutGoingCallStatus(false);
            Navigator.pop(navigatorKey.currentContext!);
          }
          RoutTo(navigatorKey.currentContext!, child: (p0, p1) =>VideoCallScreen(user: user, callId: message.data['callId'], channelId: message.data['threadId']),);
        }
    }

  if(message.data['status']=="COMPLETE")
  {
    CallKitManager().callEnd(message.data['callId']);
    var p = Provider.of<VideoCallProvider>(navigatorKey.currentContext!,listen: false);
    print("chackin if user is on call screen ${p.isOnCallScreen} or ${p.outGoingCallScreen}");
    if(p.isOnCallScreen)
    {
      p.onCall(false);
      Navigator.pop(navigatorKey.currentContext!);
    }
    if(p.outGoingCallScreen)
      {
        p.updateOutGoingCallStatus(false);
        Navigator.pop(navigatorKey.currentContext!);
      }
    Provider.of<VideoCallProvider>(navigatorKey.currentContext!,listen: false).leaveCall(update: false);
  }

}