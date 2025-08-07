import 'dart:developer';

import 'package:attach/api/local_db.dart';
import 'package:attach/modles/usertype.dart';
import 'package:attach/noticiation/notificationService.dart';
import 'package:attach/path_configuration/navigation_paths.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:logger/logger.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;



createEvent({
      required String eventName,
      required String componentName
    })
{
  log("create event this is context ${navigatorKey.currentContext}");
 if(navigatorKey.currentContext!=null)
   {
     Provider.of<AnilisticsProvider>(navigatorKey.currentContext!,listen: false).createEvent(eventName: eventName, componentName: componentName);
   }
}


class AnilisticsProvider with ChangeNotifier
{

  String? _curruntScreen;


  io.Socket? _socket;


  setSocket(io.Socket s) async
  {
    _socket = s;
    _socket!.on("analysisStarted", _analysisStarted);
    _socket!.emit("startAnalysis",{
      'userId':DB.curruntUser?.id??'',
      "eventName":AnilisticsEvent.navigation,
      "screenName":_curruntScreen??((DB.curruntUser?.userType==UserType.user)?Screens.homeScreen:Screens.listnerHomeScreen)
    });
  }


  _analysisStarted(dynamic data)
  {
    Logger().i("Anilistyc event create created $data");
  }


  createEvent({
    required String eventName,
    required String componentName
})
  {
    bool navigation = eventName == AnilisticsEvent.navigation;

    if(navigation)
      {
        _curruntScreen = componentName;
      }

    log("create event inside Provider create log  checkeing if socket os null ${_socket==null}");
    if(_socket!=null)
      {
        var parLoad = {
          'userId':DB.curruntUser?.id??'',
          "eventName":eventName,
          "screenName":(navigation)?_curruntScreen:componentName
        };
        log("create event paloade is redy and ");
        _socket?.emit("startAnalysis",parLoad);
      }
  }

  disconnectSocket()
  {
    _socket?.offAny();
    _socket?.destroy();
    _socket = null;
  }



}

class AnilisticsEvent
{
  static String navigation = "navigation";
  static String dialogOpen = 'dialogOpen';
  static String buttonClick = 'buttonClick';
  static String online = 'online';
  static String interaction = 'interaction';
}