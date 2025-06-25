import 'package:attach/api/local_db.dart';
import 'package:attach/modles/chat_contect_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:socket_io_client/socket_io_client.dart';


class ChatListProvider with ChangeNotifier
{

  Socket? _socket;
  bool _chatListConnect= false;

  List<ChatContact> _contact = [];
  int _totalUnreade = 0;


  List<ChatContact> get contacts => _contact;
  int get  totalUnread =>_totalUnreade;




  setSocket(Socket s)
  {
    _socket= s;
    getContact();
  }


  getContact()
  {

    if(_chatListConnect==false)
      {
        var payload= {
          'userId' :DB.curruntUser?.id??''
        };

        _socket!.emit("loadAllThreads",payload);
        _socket!.on("allThreads", _allThreads);
      }
  }

  _allThreads(dynamic data)
  {
    if(_chatListConnect==false)
      {
        _chatListConnect = true;
      }

    print('this is from all threads');
    Logger().i(data);

    List d = data;

    _contact = d.map((e) => ChatContact.fromJson(e),).toList();
    _totalUnreade = 0;
    _contact.forEach((e){
      _totalUnreade = _totalUnreade+(e.unseenCount??0);
    });
    notifyListeners();

  }

  ErId? getUserInfo(String id)
  {
    ErId? d;

    _contact.forEach((element) {
      if(element.user?.id==id)
        {
          d = element.user;
        }
    },);
    return d;
  }

  clear(){
    _contact = [];
    _totalUnreade = 0;
    _chatListConnect = false;
  }


  disconnectSocket() {
       // Stop listening to 'message' event
    _socket?.offAny();            // (Optional) Remove all event listeners
    _socket?.disconnect();        // Disconnect the socket
    _socket?.destroy();
    clear();
    // (Optional) Completely destroy the socket
  }





}