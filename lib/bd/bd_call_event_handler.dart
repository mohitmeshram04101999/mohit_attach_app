
import 'package:attach/callScreens/AudioCallScreen.dart';
import 'package:attach/modles/custom_calls_info.dart';


import 'package:attach/myfile/myast%20dart%20file.dart';
import 'package:attach/noticiation/notificationService.dart';
import 'package:attach/screens/dash_board_screen/inbox/tabs/videoCallScreen.dart';
import 'package:flutter_background_service/flutter_background_service.dart';


addBGListener()async{

  FlutterBackgroundService().on(CustomCallEventName.videoCallPicked).listen((event)async{
    var d = MyCallEvent.fromJson(event??{});
    print("call picked ${d.toJson()}");
    if(navigatorKey.currentContext!=null){
      RoutTo(navigatorKey.currentContext!, child: (p0, p1) => VideoCallScreen(user: d.user!, callId: d.callId!, channelId: d.threadId??''),);
    }
  });


  FlutterBackgroundService().on(CustomCallEventName.audioCallPicked).listen((event)async{
    var d = MyCallEvent.fromJson(event??{});
    print("call picked ${d.toJson()}");
    if(navigatorKey.currentContext!=null){
      RoutTo(navigatorKey.currentContext!, child: (p0, p1) => AudioCallScreen(user: d.user!, callId: d.callId!, threadId: d.threadId??''),);
    }
  });


}