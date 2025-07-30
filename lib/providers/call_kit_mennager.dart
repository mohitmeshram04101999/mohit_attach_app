
import 'package:attach/modles/otp_responce.dart';
import 'package:attach/providers/videoCallProvider.dart';
import 'package:flutter_callkit_incoming/entities/android_params.dart';
import 'package:flutter_callkit_incoming/entities/call_kit_params.dart';
import 'package:flutter_callkit_incoming/entities/notification_params.dart';
import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';

class CallKitManager
{



  startCall() async
  {
    CallKitParams params = CallKitParams(
        id: "0",
        nameCaller: 'Hien Nguyen',
        handle: '0123456789',
        duration: 3000,
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



  receiveCall(User user,Map<String,dynamic> data,String channel) async {
    CallKitParams callKitParams = CallKitParams(

      id: '${data['callId']}',

      // id: '${data['callId']}',
      nameCaller: '${user.name}',
      appName: 'Callkit',
      avatar: '${user.image}',
      handle: '0123456789',
      type: 0,
      textAccept: 'Accept',
      textDecline: 'Decline',

      missedCallNotification: NotificationParams(
        showNotification: false,
        isShowCallback: false,
        subtitle: 'Missed call',
        callbackText: 'Call back',
      ),




      callingNotification: const NotificationParams(
        showNotification: false,
        isShowCallback:false,
        subtitle: 'Calling...',
        callbackText: 'Hang Up',
      ),




      duration: 30000,

      extra: data,
      headers: <String,dynamic>{'cannel': channel, 'platform': 'flutter'},
      android:  AndroidParams(
        isCustomSmallExNotification: true,
        isCustomNotification: true,
        isShowLogo: false,
        logoUrl: 'https://i.pravatar.cc/100',
        ringtonePath: 'system_ringtone_default',
        backgroundColor: '#10001B',
        backgroundUrl:'${user.image}',
        actionColor: '#4CAF50',
        textColor: '#ffffff',
        incomingCallNotificationChannelName: channel,
        missedCallNotificationChannelName: "Missed Call",
        isShowCallID: false,
      ),
    );
    await FlutterCallkitIncoming.showCallkitIncoming(callKitParams);
  }


  receiveAudioCall(User user,Map<String,dynamic> data,String channel) async {
    CallKitParams callKitParams = CallKitParams(

      id: '${data['callId']}',

      // id: '${data['callId']}',
      nameCaller: '${user.name}',
      appName: 'Callkit',
      avatar: '${user.image}',
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

      extra: data,
      headers: <String,dynamic>{'cannel': channel, 'platform': 'flutter'},
      android:  AndroidParams(
        isCustomSmallExNotification: true,
        isCustomNotification: true,
        isShowLogo: false,
        logoUrl: 'https://i.pravatar.cc/100',
        ringtonePath: 'custom_ring',
        backgroundColor: '#10001B',

        actionColor: '#4CAF50',
        textColor: '#ffffff',
        incomingCallNotificationChannelName: channel,
        missedCallNotificationChannelName: "Missed Call",
        isShowCallID: false,
      ),
    );
    await FlutterCallkitIncoming.showCallkitIncoming(callKitParams);
  }

  callEnd(String id){
    FlutterCallkitIncoming.endCall(id);
  }




  callConnected(String id)
  {
    FlutterCallkitIncoming.setCallConnected(id);
  }

}