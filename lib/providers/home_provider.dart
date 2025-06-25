import 'package:attach/noticiation/notificationService.dart';
import 'package:attach/providers/chatListProvider.dart';
import 'package:attach/providers/chatProvider.dart';
import 'package:attach/providers/home_provider_1.dart';
import 'package:attach/providers/listener_filer_provider.dart';
import 'package:attach/providers/selfStoryProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as Io;

class Socket_Provider with ChangeNotifier
{

  bool _connect  = false;
  BuildContext? _appContext;

  Io.Socket? _socket;

  bool get  connect =>_connect;


  getAppContext(BuildContext context)
  {
    _appContext =  context;
  }


  connectSocket( )
  {

   if(_connect==false)
     {
       print("Connect");

       _socket = Io.io('http://attach.loader.co.in:5643 ',
           Io.OptionBuilder()
               .setTransports(['websocket'])
               .setExtraHeaders({'foo': 'bar'})
               .disableAutoConnect()
               .build()
       );
       _socket!.connect();

       _socket!.onError(_onError);

       _socket!.onConnect(_onConnect);
       print("asdf");
     }

  }

  _onConnect(dynamic data)
  {
    print('Socket Connect d');
    Logger().i(data);
    share(navigatorKey.currentContext!);
    _connect = true;
  }

  _onError(dynamic data)
  {
    _connect = false;
    Logger().i("Error \n $data");
  }



  share(BuildContext context)
  {
    print("this is share");

    print("socket is no Connected");
    Provider.of<HomeProvider>(context,listen: false).setSocket(_socket!);
    Provider.of<ChatProvider>(context,listen: false).setSocket(_socket!);
    Provider.of<ChatListProvider>(context,listen: false).setSocket(_socket!);
    Provider.of<ListenerFilterProvider>(context,listen: false).setSocket(_socket!);
    print("reaching to selc Provider");
    Provider.of<SelfStoryProvider>(context,listen: false).setSocket(_socket!);
    print("Self Provider stoy");
  }

  void disconnectSocket(BuildContext context) {
    // Stop listening to 'message' event
    _socket?.offAny();            // (Optional) Remove all event listeners
    _socket?.disconnect();        // Disconnect the socket
    _socket?.destroy();

    Provider.of<HomeProvider>(context,listen: false).disconnectSocket();
    Provider.of<ChatProvider>(context,listen: false).disconnectSocket();
    Provider.of<ChatListProvider>(context,listen: false).disconnectSocket();
    Provider.of<ListenerFilterProvider>(context,listen: false).disconnectSocket();
    Provider.of<SelfStoryProvider>(context,listen: false).disconnectSocket();
    _connect = false;
    _socket = null;

    // (Optional) Completely destroy the socket
  }

}