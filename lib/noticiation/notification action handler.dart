
import 'package:attach/myfile/myast%20dart%20file.dart';
import 'package:attach/noticiation/notificationService.dart';
import 'package:attach/providers/chatProvider.dart';
import 'package:attach/screens/dash_board_screen/inbox/chat_screen.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

@pragma("vm:entry-point")
Future<void> notificationActionHandler(ReceivedAction action)async{
  print("Tap On notification ");

  ChatProvider? chatProvider;
   Map<String,dynamic>? data = action.payload;

  if(navigatorKey.currentContext!=null)
    {
      chatProvider =  Provider.of<ChatProvider>(navigatorKey.currentContext!,listen: false);
    }

  if(data?["type"]=='NEW_MESSAGE'&&chatProvider!=null)
    {
      print("tap on notitficaotn =");
      String? threadId = data?['threadId'];
      print("tap on notitficaotn = ${threadId}");
      // chatProvider.startChat(threadId);
      if(chatProvider.onChatScreen)
        {
          print("tap on notitficaotn = ${threadId}");
          chatProvider.startChat(threadId);
        }
      else
        {
          chatProvider.startChat(threadId);
          RoutTo(navigatorKey.currentContext!, child: (p0, p1) => ChatScreen(contactId: threadId,),);
        }
    }

  Logger().i(action.payload);


}