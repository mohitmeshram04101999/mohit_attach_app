import 'dart:convert';
import 'dart:developer';

import 'package:attach/api/bankpai/mediaApi.dart';
import 'package:attach/api/bankpai/other_api.dart';
import 'package:attach/api/callsApi.dart';
import 'package:attach/api/listners_Api.dart';
import 'package:attach/api/local_db.dart';
import 'package:attach/const/app_constante.dart';
import 'package:attach/dialog/listener_ratting_dailog.dart';
import 'package:attach/modles/chat_contect_model.dart';
import 'package:attach/modles/load_chat_model.dart';
import 'package:attach/modles/otp_responce.dart';
import 'package:attach/myfile/animated%20dilog.dart';
import 'package:attach/myfile/myast%20dart%20file.dart';
import 'package:attach/noticiation/notificationService.dart';
import 'package:attach/providers/my_hleper.dart';
import 'package:attach/providers/profileProvider.dart';
import 'package:attach/screens/dash_board_screen/inbox/chat_screen.dart';
import 'package:attach/screens/dash_board_screen/inbox/tabs/edit_chat_post.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';

class ChatProvider with ChangeNotifier {
  Socket? _socket;
  ErId? _user;
  bool _typing = false;
  bool _userisTyping = false;
  String? _threadId;
  Message? _selectedMessage;
  bool _sessionExpired = false;
  final TextEditingController _textEditingController = TextEditingController();
  bool _loading = true;
  String? _sessionId;
  bool _onChatScreen = false;


  List<Message> _messages = [];
  List<Message> get message => _messages;
  ErId? get user => _user;
  bool get typing => _typing;
  bool get userIsTyping => _userisTyping;
  TextEditingController get textEditingController => _textEditingController;
  String? get threadId => _threadId;
  Message? get selectedMessage => _selectedMessage;
  bool get sessionExpired => _sessionExpired;
  bool get loading => _loading;
  String? get sessionId => _sessionId;
  bool get  onChatScreen => _onChatScreen;


  setOnChatScreen(bool b){
    _onChatScreen = b;

  }

  selectMessage(Message m) {
    print("selectd");
    _selectedMessage = m;
    notifyListeners();
  }

  setSocket(Socket s) {
    _socket = s;
    if(_threadId!=null)
      {
        startChat(_threadId);
      }
  }

  startTyping() async{
    Logger().i("Start Typing");
    if (_typing == false) {
      var p = {'threadId': _threadId, 'toUserId': _user?.id};
      _socket?.emit("typing", p);
      _typing = true;
      notifyListeners();

    }
  }

  stopTyping() {
    if (_typing) {
      var p = {'threadId': _threadId, 'toUserId': _user?.id};
      _socket?.emit("stopTyping", p);
      _typing = false;
      notifyListeners();
    }
  }

  createThread(BuildContext context, String userId) async {
    var resp = await ListenerApi().createThread(userId);

    switch (resp.statusCode) {
      case 201:
        var d = jsonDecode(resp.body);
        _threadId = '${d['data']['_id']}';
        startChat(_threadId);
        RoutTo(context, child: (p0, p1) => ChatScreen());
        break;

      case 400:
        MyHelper.snakeBar(
          context,
          title: 'Bad Request',
          message: '${jsonDecode(resp.body)['message']}',
          type: SnakeBarType.error,
        );
        break;

      case 403:
        MyHelper.snakeBar(
          context,
          title: 'Denied',
          message: '${jsonDecode(resp.body)['message']}',
          type: SnakeBarType.error,
        );
        break;

      case 401:
        MyHelper.tokenExp(context);
        break;

      case 500:
        MyHelper.serverError(context, resp.body);
        break;

      default:
        MyHelper.serverError(
          context,
          '${resp.statusCode}\n${resp.body}',
          title: 'Exception',
        );
        break;
    }
  }

  startChat(String? threadId) async{
    stopChat();


    _threadId = threadId;

    _socket?.on("threadMessages", _threadMessages);
    _socket?.on("userTyping", _userTyping);
    _socket?.on("messageSeen", _messageSeen);
    _socket?.on("newMessage", _newMessage);
    _socket?.on("messageStatusM", _messageStatusM);
    _socket?.on("sessionEnded", _sessionEnded);
    _socket?.on("chatSessionStart",_chatSessionStart);
    _socket?.on("restrictMessage",_restrictMessage );





    var seenPayloade = {
      'seenByUserId': DB.curruntUser?.id ?? '',
      'userId': _user?.id ?? '',
      'threadId': threadId,
    };

    var loadPay = {'threadId': threadId, 'userId': DB.curruntUser?.id ?? ''};

    _socket?.emit("loadThreadMessages", loadPay);

    _socket?.emit("messageSeen", seenPayloade);


    await Future.delayed(Duration(seconds: 1));
    _loading = false;
    notifyListeners();
  }


  _restrictMessage(dynamic data)
  {
    Logger().i(data);
    MyHelper.snakeBar(navigatorKey.currentContext!, title: "Message Restricted", message: data['message'],type: SnakeBarType.error);
  }
  _chatSessionStart(dynamic data)
  {
    print(
      "this is chatSessionStart event ${data['threadId']} ${_threadId == data['threadId']}",
    );
    Logger().i(data);

    _sessionId = data['sessionId'];
    notifyListeners();


  }


  _sessionEnded(dynamic data) {
    Logger().i(
      "this is sessionEnded event ${_threadId == data['threadId']}",
    );
    Logger().i(data);
    _sessionExpired = true;
    _sessionId = null;
    MyHelper.snakeBar(
      Get.context!,
      title: 'Session Expired',
      message: data['message'],
      type: SnakeBarType.error,
    );

    var t = DB.curruntUser?.token;

    Map<String, dynamic>? userMap = data['user'];

    if(userMap != null)
    {
      userMap['token'] = t ?? '';
      Provider.of<ProfileProvider>(navigatorKey.currentContext!,listen: false).setUser(User.fromJson(userMap));
    }
    notifyListeners();
  }
  _messageStatusM(dynamic data) {
    Logger().i(
      "this is messageStatusM event ${data['threadId']} ${_threadId == data['threadId']}",
    );
    if (_threadId == data['threadId']) {
      Map d = data;
      print("this is load tgh --- ");

      Logger().i(data);
      var _d = LoadChatResponce.fromJson(data);
      _messages = _d.messages ?? [];
      notifyListeners();
    }
  }

  sendMessage({String? mediaType, String? media,String? message}) {
    if ((message !=null ||_textEditingController.text.trim().isNotEmpty) || mediaType != null) {
      var p = {
        'toUserId': _user?.id ?? '',
        'message': message??((mediaType == null) ? _textEditingController.text : null),
        'mediaType': mediaType,
        'media': media,
        "messageType": (mediaType == null) ? null : 'DOC_MESSAGE',
      };
      _socket!.emit("sendMessage", p);
      _textEditingController.clear();
    }
  }

  _messageSeen(dynamic data) {
    Logger().i("this is messageSeen ${data}");
  }

  _newMessage(dynamic data) {
    if (_threadId == data['threadId']) {
      Logger().i("this is newMessage ${data}");

      var seenPayloade = {
        'seenByUserId': DB.curruntUser?.id ?? '',
        'userId': _user?.id ?? '',
        'threadId': _threadId,
      };

      _socket?.emit("messageSeen", seenPayloade);
      var m = Message.fromJson(data);
      // _messages.insert(0,m);

      var d = {'messageId': m.id, 'recipientId': DB.curruntUser?.id};
      notifyListeners();
    }
  }

  _userTyping(dynamic data) {
    if (_threadId == data['threadId']) {
      Logger().i("this is user typing ${data}");
      _userisTyping = data['isTyping'];
      Logger().w("user is typing $_userisTyping");
      notifyListeners();
    }
  }

  cleaProvider() {
    _user = null;
    _messages = [];
    _threadId = null;
    _userisTyping = false;
    _typing = false;
    _sessionExpired = false;
    _textEditingController.clear();
    _sessionId = null;
    print("chat provider is clear");
  }

  _threadMessages(dynamic data) {
    Map d = data;
    Logger().i("this is load tgh --- \n $d \n ---");

    print("Chat receved");
    Logger().t(d);
    var _d = LoadChatResponce.fromJson(data);
    _messages = _d.messages ?? [];
    _user = _d.user;
    notifyListeners();

  }

  stopChat() {
    print("Stop Chat");
    // _socket?.offAny();
    Logger().i('');


    // _socket?.on("threadMessages", _threadMessages);
    // _socket?.on("userTyping", _userTyping);
    // _socket?.on("messageSeen", _messageSeen);
    // _socket?.on("newMessage", _newMessage);
    // _socket?.on("messageStatusM", _messageStatusM);
    // _socket?.on("sessionEnded", _sessionEnded);
    // _socket?.on("chatSessionStart",_chatSessionStart);
    // _socket?.on("restrictMessage",_restrictMessage );


    _socket?.off("newMessage", (d) => Logger().i("newMessage is of $d"));
    _socket?.off('userTyping', (d) => Logger().i("userTyping is of $d"));
    _socket?.off('messageSeen', (d) => Logger().i("messageSeen is of $d"));
    _socket?.off(
      'threadMessages',
      (d) => Logger().i("threadMessages is of $d"),
    );
    _socket?.off("messageStatusM");
    _socket?.off("sessionEnded");
    _socket?.off("chatSessionStart");
    _socket?.off("restrictMessage");
    _messages = [];
    _user = null;
    _threadId = null;
    _userisTyping = false;
    _typing = false;
    _sessionExpired = false;
    _textEditingController.clear();
    _loading = true;
    _sessionId = null;
  }

  void disconnectSocket() {
    print("Disconnect socket");

    stopChat();

    _socket?.disconnect(); // Disconnect the socket
    _socket?.destroy(); // (Optional) Completely destroy the socket
  }

  uploadMediaFromCamera(BuildContext context,{bool isVideo = false}) async {
    ImagePicker imagePicker = ImagePicker();

     XFile? image;

    if(isVideo){
      image = await imagePicker.pickVideo(
        maxDuration: Duration(seconds: 30),
          preferredCameraDevice: CameraDevice.front,
        source: ImageSource.camera,
      );

    }else{
      image = await imagePicker.pickImage(
          source: ImageSource.camera
      );
    }


    if (image != null) {



      var p  = await OpenDailogWithAnimation(
          navigatorKey.currentContext!, dailog: (animation, secondryAnimation) =>
          EditChatPostDialog(filePath: image?.path??''));

      if(p!=true)
      {
        print("return");
        return;
      }


      String? attachMessage = _textEditingController.text.isEmpty?null:_textEditingController.text.trim();

      var resp = await MediaApi().sendMediaInMessage(image.path ?? '', (
          d,
          ) async {
        await AwesomeNotifications().createNotification(
          content: NotificationContent(
            id: 1004, // keep same ID to update
            channelKey: 'UPLOAD_FILE',
            title: 'Uploading Media...',
            color: Const.yellow,
            body: '${(d * 100).toString().split(".").first}% uploaded',
            notificationLayout: NotificationLayout.ProgressBar,
            progress: d * 100,
            locked: true,
            autoDismissible: false,
          ),
        );
      });

      AwesomeNotifications().dismiss(1004);

      switch (resp.statusCode) {
        case 201:
          {

            print("Media is uploaded");
            var d = jsonDecode(resp.body);

            String url = d['media'];

            print("url is $url");

            print('this is file tiye ${url.isImageFileName}  ${url.isVideoFileName}');


            if (url.isImageFileName) {
              sendMessage(mediaType: 'IMAGE', media: url,message: attachMessage);
            } else if (url.isVideoFileName) {
              sendMessage(mediaType: "VIDEO", media: url);
            } else {
              sendMessage(mediaType: 'DOCUMENT', media: url);
            }

            print("Media is send ");
          }
          break;

        case 400:
          MyHelper.snakeBar(
            context,
            title: 'Error',
            message: jsonDecode(resp.body)['message'],
          );
          break;

        case 401:
          MyHelper.tokenExp(context);
          break;

        case 500:
          MyHelper.serverError(context, resp.body);
          break;

        default:
          MyHelper.serverError(context, resp.body);
          break;
      }
    }
  }



  uploadMedia(BuildContext context) async {
    ImagePicker imagePicker = ImagePicker();

    FilePickerResult? d = await FilePicker.platform.pickFiles(
      type: FileType.custom,

      allowedExtensions: ['jpg', 'png', 'jpeg', 'mp4', 'avi', 'mov'],
    );
    print("file is picked = $d");
    if (d != null && d.files.isNotEmpty)
    
    {

      //
      await Future.delayed(Duration(milliseconds: 300));

      var p  = await OpenDailogWithAnimation(
          navigatorKey.currentContext!, dailog: (animation, secondryAnimation) =>
      EditChatPostDialog(filePath: d.files.first.path??''));

      if(p!=true)
        {
          print("return");
          return;
        }
      //
      
      var resp = await MediaApi().sendMediaInMessage(d.files.first.path ?? '', (
        d,
      ) async {
        await AwesomeNotifications().createNotification(
          content: NotificationContent(
            id: 1004, // keep same ID to update
            channelKey: 'UPLOAD_FILE',
            title: 'Uploading Media...',
            color: Const.yellow,
            body: '${(d * 100).toString().split(".").first}% uploaded',
            notificationLayout: NotificationLayout.ProgressBar,
            progress: d * 100,
            locked: true,
            autoDismissible: false,
          ),
        );
      });

      AwesomeNotifications().dismiss(1004);

      switch (resp.statusCode) {
        case 201:
          {
            log("Media is upload and sendMessageCalled");
            var d = jsonDecode(resp.body);
            log("Media is decode");

            String url = d['media'];
            String mediaType = d['mediaType'];

            log("checkin media type and set for uload");

            if (url.isImageFileName) {
              sendMessage(mediaType: 'IMAGE', media: url);
            } else if (url.isVideoFileName) {
              sendMessage(mediaType: "VIDEO", media: url);
            } else {
              sendMessage(mediaType: 'DOCUMENT', media: url);
            }


            print("Media is upload and sendMessageCalled");
          }
          break;

        case 400:
          MyHelper.snakeBar(
            context,
            title: 'Error',
            message: jsonDecode(resp.body)['message'],
          );
          break;

        case 401:
          MyHelper.tokenExp(context);
          break;

        case 500:
          MyHelper.serverError(context, resp.body);
          break;

        default:
          MyHelper.serverError(context, resp.body);
          break;
      }
    }
  }



  endSession(BuildContext context) async{

    var resp = await OtherApi().endSession(_sessionId??'');


    switch (resp.statusCode) {
        case 200:
          MyHelper.snakeBar(
            context,
            title: 'Session Closed',
            message: 'Session closed successfully',
            type: SnakeBarType.success,
          );

          _sessionId = null;
          notifyListeners();

          OpenDailogWithAnimation(navigatorKey.currentContext!,
            barriarColor: Colors.white.withOpacity(.5),dailog: (animation, secondryAnimation) => ListenerRatingDialog(listenerId: _user?.id??'',),);
          break;

        case 400:
          MyHelper.snakeBar(
            context,
            title: 'Error',
            message: jsonDecode(resp.body)['message'],
            type: SnakeBarType.error,
          );
          break;

        case 401:
          MyHelper.tokenExp(context);
          break;

        case 500:
          MyHelper.serverError(context, resp.body);
          break;

        default:
          MyHelper.serverError(context, resp.body);
          break;
      }




  }

}
