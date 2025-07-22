
import 'dart:async';
import 'dart:developer';

import 'package:attach/callScreens/AudioCallScreen.dart';
import 'package:attach/modles/custom_calls_info.dart';


import 'package:attach/myfile/myast%20dart%20file.dart';
import 'package:attach/noticiation/notificationService.dart';
import 'package:attach/providers/audio%20call%20provider.dart';
import 'package:attach/providers/videoCallProvider.dart';
import 'package:attach/screens/dash_board_screen/inbox/tabs/videoCallScreen.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:provider/provider.dart';




//---------------------------------------------------------------------------------------



addBGListener()async{


 FlutterBackgroundService().on(CustomCallEventName.videoCallPicked).listen((event)async{
    var d = MyCallEvent.fromJson(event??{});
    log("event call picked in call handele listener${d.toJson()}");
    if(navigatorKey.currentContext!=null){
      RoutTo(navigatorKey.currentContext!, child: (p0, p1) => VideoCallScreen(user: d.user!, callId: d.callId!, channelId: d.threadId??''),);
    }
  });






  FlutterBackgroundService().on(CustomCallEventName.audioCallPicked).listen((event)async{
    var d = MyCallEvent.fromJson(event??{});
    log("call picked ${d.toJson()}");
    if(navigatorKey.currentContext!=null){
      RoutTo(navigatorKey.currentContext!, child: (p0, p1) => AudioCallScreen(user: d.user!, callId: d.callId!, threadId: d.threadId??''),);
    }
  });

 FlutterBackgroundService().on("timeOut").listen((event)async{

   if(navigatorKey.currentContext!=null){
     var vP =  Provider.of<VideoCallProvider>(navigatorKey.currentContext!,listen: false);
     var aP =  Provider.of<AudioCallProvider>(navigatorKey.currentContext!,listen: false);
     vP.destroyEngine();
     aP.destroyEngine();
   }


 });

  // FlutterBackgroundService().on('stopCallListener').listen((event)async{
  //
  //
  //   _videoCallSubscription?.cancel();
  //   _audioCallSubscription?.cancel();
  //   _stopCallSubscription?.cancel();
  //   _serviceInstanceForCallKit = null;
  //
  // });




}





