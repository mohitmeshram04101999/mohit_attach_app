import 'package:flutter/material.dart';
import 'package:flutter_callkit_incoming/entities/android_params.dart';
import 'package:flutter_callkit_incoming/entities/call_kit_params.dart';
import 'package:flutter_callkit_incoming/entities/notification_params.dart';
import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';
import 'package:permission_handler/permission_handler.dart';

class AudioCallProvider with ChangeNotifier {


  requestNotification() async{
    var p = await Permission.notification.request();
    print(p);
  }

  receiveCall() async {
    CallKitParams callKitParams = CallKitParams(
      id: '022',
      nameCaller: 'Hien Nguyen',
      appName: 'Callkit',
      avatar: 'https://i.pravatar.cc/100',
      handle: '0123456789',
      type: 0,
      textAccept: 'Accept',
      textDecline: 'Decline',

      missedCallNotification: NotificationParams(
        showNotification: true,
        isShowCallback: true,
        subtitle: 'Missed call',
        callbackText: 'Call back',
      ),



      callingNotification: const NotificationParams(
        showNotification: true,
        isShowCallback: true,
        subtitle: 'Calling...',
        callbackText: 'Hang Up',
      ),

      duration: 30000,
      extra: <String, dynamic>{'userId': '1a2b3c4d'},
      headers: <String, dynamic>{'apiKey': 'Abc@123!', 'platform': 'flutter'},
      android: const AndroidParams(
        isCustomSmallExNotification: true,
          isCustomNotification: true,
          isShowLogo: false,
          logoUrl: 'https://i.pravatar.cc/100',
          ringtonePath: 'system_ringtone_default',
          backgroundColor: '#10001B',
          backgroundUrl: 'https://i.pravatar.cc/500',
          actionColor: '#4CAF50',
          textColor: '#ffffff',
          incomingCallNotificationChannelName: "Incoming Call",
          missedCallNotificationChannelName: "Missed Call",
          isShowCallID: false,
      ),
    );
    await FlutterCallkitIncoming.showCallkitIncoming(callKitParams);
  }



  startCall() async
  {
    CallKitParams params = CallKitParams(
        id: "this._currentUuid",
        nameCaller: 'Hien Nguyen',
        handle: '0123456789',
        type: 1,
        extra: <String, dynamic>{'userId': '1a2b3c4d'},
        callingNotification: const NotificationParams(
          showNotification: true,
          isShowCallback: true,
          subtitle: 'Calling...',
          callbackText: 'Hang Up',
        ),
        android: const AndroidParams(
          isCustomNotification: true,
          isShowCallID: true,
          backgroundColor: '#10001B'
        )
    );
    await FlutterCallkitIncoming.startCall(params);
  }



}
