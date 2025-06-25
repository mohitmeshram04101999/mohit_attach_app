import 'dart:convert';

import 'package:attach/api/callsApi.dart';
import 'package:attach/api/local_db.dart';
import 'package:attach/modles/custom_calls_info.dart';
import 'package:attach/modles/otp_responce.dart';
import 'package:attach/noticiation/notificationService.dart';
import 'package:attach/providers/audio%20call%20provider.dart';
import 'package:attach/providers/videoCallProvider.dart';
import 'package:attach/screens/dash_board_screen/inbox/tabs/videoCallScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_callkit_incoming/entities/call_event.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

callKitActionhanlde(CallEvent? event,{ServiceInstance? service}) {
  Logger().i(event?.body);
  Logger().i("context check = ${navigatorKey.currentContext == null}");

  String? chanelName =
      event?.body['android']['incomingCallNotificationChannelName'];

  //
  if (chanelName == 'VIDEO_CALL_CHANNEL') {
    _callKitEventHandlerForVideoCall(event,service: service);
  }
  if (chanelName == 'AUDIO_CALL_CHANNEL') {
    _callKitEventHandlerForAudioCall(event,service: service);
  }
}

_callKitEventHandlerForVideoCall(CallEvent? event,{ServiceInstance? service}) async {
  Map data = event?.body;



  switch (event?.event) {
    // On Call accept

  // On Call accept ------------------------------------------------------------------------------------------------------------------------------------------------
    case Event.actionCallAccept:
      Map data = event?.body['extra'];

      CallsApi().updateCall(callId: data['callId'], status: "ANSWERED");
      var user = User.fromJson(jsonDecode(data['user']));

      var d = MyCallEvent(
        eventName: CustomCallEventName.videoCallPicked,
        callId: data['callId'],
        user: user,
        threadId: data['threadId'],
      );
       await DB().saveCallEvent(d);


      if(service!=null) {
        service.invoke(CustomCallEventName.videoCallPicked,d.toJson());
      }

      break;


      // On Call Decline ------------------------------------------------------------------------------------------------------------------------------------------------

    case Event.actionCallDecline:
      {
        Map extra = data['extra'];
        String callId = extra['callId'];

        CallsApi().updateCall(
          callId: callId,
          status: "REJECTED",
          callEndedById: DB.curruntUser?.id,
        );
      }

      break;

    case Event.actionCallEnded:
      {
        print("call ended");
        // Map extra = data['extra'];
        // String callId = extra['callId'];
        //
        // CallsApi().updateCall(
        //   callId: callId,
        //     status: 'COMPLETE',
        //     callEndedById: DB.curruntUser?.id,
        // );
      }

      break;

    case Event.actionCallTimeout:
      {
        Map extra = data['extra'];
        String callId = extra['callId'];

        CallsApi().updateCall(
          callId: callId,
          status: "MISSED",
          callEndedById: DB.curruntUser?.id,
        );
      }

      break;

    case Event.actionCallCallback:
      break;

    default:
      print("Unhandled CallKit event: ${event?.event}");
      break;
  }
}

_callKitEventHandlerForAudioCall(CallEvent? event,{ServiceInstance? service}) async {
  Map data = event?.body;

  switch (event?.event) {
    // On Call accept
    case Event.actionCallAccept:
      Map data = event?.body['extra'];
      await CallsApi().updateCall(callId: data['callId'], status: "ANSWERED");
      var user = User.fromJson(jsonDecode(data['user']));


      var d = MyCallEvent(
        eventName: CustomCallEventName.audioCallPicked,
        callId: data['callId'],
        user: user,
        threadId: data['threadId'],
      );
      await DB().saveCallEvent(d);


      if(service!=null) {
        service.invoke(CustomCallEventName.audioCallPicked,d.toJson());
      }

      break;

    case Event.actionCallDecline:
      {
        Map extra = data['extra'];
        String callId = extra['callId'];

        print("diclineing call ${extra['callId']}");

        var p = await CallsApi().updateCall(
          callId: callId,
          status: "REJECTED",
          callEndedById: DB.curruntUser?.id,
        );

        Logger().i("Call decline with ${p.body}");
      }

      break;




    case Event.actionCallEnded:
      {
        print('this is call HangUp');
        // Map extra = data['extra'];
        // String callId = extra['callId'];
        //
        // CallsApi().updateCall(
        //   callId: callId,
        //     status: 'COMPLETE',
        //     callEndedById: DB.curruntUser?.id,
        // );
      }

      break;

    case Event.actionCallTimeout:
      {
        Map extra = data['extra'];
        String callId = extra['callId'];

        CallsApi().updateCall(
          callId: callId,
          status: "MISSED",
          callEndedById: DB.curruntUser?.id,
        );
      }

      break;

    case Event.actionCallCallback:
      break;



    default:
      print("Unhandled CallKit event: ${event?.event}");
      break;
  }
}






