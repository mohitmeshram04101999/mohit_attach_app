import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:attach/api/apiPath.dart';
import 'package:attach/api/callsApi.dart';
import 'package:attach/api/listners_Api.dart';
import 'package:attach/api/local_db.dart';
import 'package:attach/api/record_api.dart';
import 'package:attach/callScreens/outGoingVideoCallScreen.dart';
import 'package:attach/dialog/video%20call%20mini%20Window.dart';
import 'package:attach/modles/otp_responce.dart';
import 'package:attach/myfile/myast%20dart%20file.dart';
import 'package:attach/noticiation/notificationService.dart';
import 'package:attach/providers/call_kit_mennager.dart';
import 'package:attach/providers/my_hleper.dart';
import 'package:attach/screens/dash_board_screen/inbox/tabs/videoCallScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';

class VideoCallProvider with ChangeNotifier {


  final _appId = "72c9b3e1ba214cd184491351a6767ea5";
  String? _token;   // "<-- Insert Token -->";
  String? _channel = "myChannel";
  String?_callStatus;
  String? _callId;
  User? _user;
  Timer? _callTimeOut;


  bool _onOutGoingCallScreen = false;
  bool get outGoingCallScreen => _onOutGoingCallScreen;

  updateOutGoingCallStatus(bool b)
  {
    _onOutGoingCallScreen = b;
    print("updaet video call scree onOutGoingCallScreen status $_onOutGoingCallScreen");
  }


  onCall(bool c)
  {
    _isOnCallScreen = c;
    print("updaet video call scree  onCall status $_isOnCallScreen");
  }


  bool _init = false;

  bool _isOnCallScreen = false;


  RtcEngine? _engine;
  int? _remoteUid;
  bool _localUserJoined = false;
  bool _listnersSet = false;
  bool _isMicMuted = false;
  bool _isSpeakerOn = true;
  String? _resourceId;
  String? _recordingId;



  PermissionStatus? _microphon;
  PermissionStatus? _camera;


  User? get user => _user;
  bool get isOnCallScreen => _isOnCallScreen;
  bool get isMicMuted =>_isMicMuted;
  bool get isSpeakerOn =>_isSpeakerOn;
  String? get resourceId => _resourceId;
  String? get recordingId => _recordingId;



  RtcEngine? get engine => _engine;

  bool get init => _init;

  bool get isLocalUserJoined => _localUserJoined;

  bool get listnerSet => _listnersSet;

  int? get remoteUid => _remoteUid;
  String? get token => _token;





  Future<void> toggleMic() async {
    _isMicMuted = !_isMicMuted;
    await engine?.muteLocalAudioStream(isMicMuted);
    notifyListeners();
  }


  Future<void> switchCamera() async {
    await engine?.switchCamera();
  }

  // Toggle speaker
  Future<void> toggleSpeaker() async {
    _isSpeakerOn = !_isSpeakerOn;
    await engine?.setEnableSpeakerphone(isSpeakerOn);
    notifyListeners();
  }



  setChanel(String channel,String callId,User user)
  {
    _channel = channel;
    _callId = callId;
    _user = user;
    print("Cennerl is set");
  }

  getPermmission() async
  {
    print('chacking for permmission');
    _microphon = await Permission.microphone.request();
    _camera = await Permission.camera.request();

    print('permission is gete');

    Logger().i("micro = ${_microphon}  camera = ${_camera}");
  }

  initRtc() async
  {
    Logger().w("option one");
    _engine = createAgoraRtcEngine();
    Logger().w("option 2");

    await _engine?.initialize(RtcEngineContext(
      appId: _appId,
      channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
    ));
    Logger().w("option 3");

    _init = true;
    Logger().w("option 4");
    notifyListeners();
  }

  _getToken() async
  {
    var resp =  await http.post(Uri.parse("${PathApi.baseUri}/generateToken"),
        headers:{
          'Content-Type': 'application/json',
        },
        body: jsonEncode( {
          "channelName":_channel,
          "uid":"0",
        }));
    print("${resp.statusCode}\n${resp.body}");
    switch(resp.statusCode)
    {
      case 200:
        var d = jsonDecode(resp.body);

        _token =d['token'];
        break;

    }
  }


  registerEventHandler() async
  {

    if(_init)
    {
      _engine?.registerEventHandler(RtcEngineEventHandler(

          onJoinChannelSuccess: _onJoinChannelSuccess,
          onUserJoined: _onUserJoined,
          onUserOffline:_onUserOffline,
          onTokenPrivilegeWillExpire:_onTokenPrivilegeWillExpire

      ));
      _listnersSet = true;

      notifyListeners();
    }
  }


  join() async
  {


    await _getToken();
    if(_token!=null)
    {
      await _engine?.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
      await _engine?.enableVideo();
      await _engine?.startPreview();


      if(_token!=null)
      {
        await _engine?.joinChannel(
          token: _token!,
          channelId: _channel??'',
          uid: 0,
          options: const ChannelMediaOptions(),
        );
      }
    }

  }









  _onJoinChannelSuccess(RtcConnection connection,int elapsed)
  {
    print("On join Chennel Sucksess");
    _localUserJoined = true;
    notifyListeners();
  }

  void _onUserJoined(RtcConnection connection, int remotId, int elapsed)
  {
    print("User join ");
    _remoteUid =remotId;
    // _startRecord(navigatorKey.currentContext!);
    notifyListeners();
  }

  void _onUserOffline(RtcConnection connection, int remoteUid,
      UserOfflineReasonType reason) {
    // _stopRecord(navigatorKey.currentContext!);
    if(_isOnCallScreen)
      {
        _isOnCallScreen = false;
        Navigator.pop(navigatorKey.currentContext!);
      }
    if(_onOutGoingCallScreen)
      {
        _onOutGoingCallScreen = false;
        Navigator.pop(navigatorKey.currentContext!);
      }
    debugPrint("remote user $remoteUid left channel");
    _remoteUid = null;
    leaveCall();

    notifyListeners();

  }

  void _onTokenPrivilegeWillExpire (RtcConnection connection, String token) {
    debugPrint(
        '[onTokenPrivilegeWillExpire] connection: ${connection.toJson()}, token: $token');
  }









  startVideoCall() async
  {

    Logger().i("thisi is permmisossion statuse ${_camera} ${_microphon}");

    if(_init ==false)
      {

        await initRtc();
        await registerEventHandler();
        await join();
      }

  }




  Future<void> leaveCall({bool update = false}) async {
    try {

      await _engine?.leaveChannel();
      await _engine?.stopPreview();
      _localUserJoined = false;
      _remoteUid = null;
      _token = null;
      _isMicMuted = false;
      _isSpeakerOn = true;
      closetimer();
      _overlayEntry?.remove();
      notifyListeners();
      CallKitManager().callEnd(_callId??'');
      if(update)
        {
          Logger().i("Updatiing user");
          CallsApi().updateCall(callId: _callId??'', status: "COMPLETE",callEndedById: DB.curruntUser?.id);
        }
      _user = null;
      _callId = null;
      _channel = null;
      _isOnCallScreen = false;
      await _engine?.release();
      _engine = null;
      _init  = false;




    } catch (e) {
      debugPrint("Error leaving the call: $e");
    }
  }



  startTimer()
  {
    _callTimeOut = Timer(Duration(seconds: 35), (){

      CallsApi().updateCall(
          callId: _callId??'',
          status: "MISSED",
        callEndedById: _user?.id
      );
      destroyEngine();
    });
  }


  closetimer() async
  {
    _callTimeOut?.cancel();
    _callTimeOut =null;

  }



  createThread(BuildContext context, User userId) async
  {
    var resp = await ListenerApi().createThread(userId.id??'');

    switch (resp.statusCode) {
      case 201:
        var d = jsonDecode(resp.body);
        _channel = '${d['data']['_id']}';
        makeVideoCall(context, user: userId, threadId: d['data']['_id']);
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


  makeVideoCall(BuildContext context,{
    required User user,
    required String threadId,
  }) async
  {
    var resp = await CallsApi().createCall(listenerId: user.id??'', threadId
        : threadId??'',callType: 'VIDEO');



    switch(resp.statusCode)
    {

      case 201:
        var d = jsonDecode(resp.body);
        RoutTo(context, child: (p0, p1) => OutgoingVideoCallScreen(callId: d['data']['_id'],threadId: threadId,user:user,));
        break;

      case 400:
        MyHelper.snakeBar(context,title: 'Can,t make Call',message: '${jsonDecode(resp.body)['message']}',type: SnakeBarType.error);
        break;

      case 403:
        MyHelper.snakeBar(context,title: 'Denied',message: '${jsonDecode(resp.body)['message']}',type: SnakeBarType.error);
        break;

      case 401:
        MyHelper.tokenExp(context);
        break;

      case 500:
        MyHelper.serverError(context, resp.body);
        break;

      default:
        MyHelper.serverError(context, '${resp.statusCode}\n${resp.body}',title: 'Exception');
        break;

    }

  }







  OverlayEntry? _overlayEntry;

  void showOverlay(BuildContext context)
  {
    _overlayEntry = OverlayEntry(
      builder: (context) => VideoCallMiniWindow(channelId: _channel??'',callId: _callId??'',),
    );
    Overlay.of(context).insert(_overlayEntry!);
  }

  void closeOverlay()
  {
    _overlayEntry?.remove();
  }



  destroyEngine({bool? release = false}) async
  {

    await _engine?.leaveChannel();
        await _engine?.stopPreview();
        await _engine?.release();
        _engine = null;


  }


  _acquire(BuildContext context) async
  {
    print("this is for acur ");
    if(_channel!=null&&_remoteUid!=null)
      {
        var resp = await CallRecordApi().acquire(_channel!, _remoteUid!);
    switch(resp.statusCode)
    {
      case 200:
        var d = jsonDecode(resp.body);
        _resourceId  =  d['token']['resourceId'];
        break;

      case 400:
        MyHelper.snakeBar(context,title: 'Can,t acquire record',message: '${jsonDecode(resp.body)['message']}',type: SnakeBarType.error);
        break;

      case 403:
        MyHelper.snakeBar(context,title: 'Denied',message: '${jsonDecode(resp.body)['message']}',type: SnakeBarType.error);
        break;

      case 401:
        MyHelper.tokenExp(context);
        break;

      case 500:
        MyHelper.serverError(context, resp.body);
        break;

      default:
        MyHelper.serverError(context, '${resp.statusCode}\n${resp.body}',title: 'Exception');
        break;

    }
      }
  }





  _startRecord(BuildContext context) async
  {

    await _acquire(context); 

    log("this is for start \n $_channel \n $_remoteUid \n$_resourceId \n$_token");

    if(_resourceId==null||_channel==null||_token==null||_remoteUid==null)
      {
        return;
      }

    var resp = await CallRecordApi().startRecord(
        channelId: _channel!,
        uid: _remoteUid??0,
        resourceId: _resourceId!,
        token: _token!,
    );

    switch (resp.statusCode)
    {
      case 200:
        var d = jsonDecode(resp.body);
        _recordingId = d['token']['sid'];
        break;

      case 400:
        MyHelper.snakeBar(context,title: 'Can,t start record',message: '${jsonDecode(resp.body)['message']}',type: SnakeBarType.error);
        break;

      case 403:
        MyHelper.snakeBar(context,title: 'Denied',message: '${jsonDecode(resp.body)['message']}',type: SnakeBarType.error);
        break;

      case 401:
        MyHelper.tokenExp(context);
        break;

      case 500:
        MyHelper.serverError(context, resp.body);
        break;

      default:
        MyHelper.serverError(context, '${resp.statusCode}\n${resp.body}',title: 'Exception');
        break;
    }
  }
  
  _stopRecord(BuildContext context) async
  {
    log("  \n $_channel \n $_remoteUid \n$_resourceId \n$_recordingId");
    if(_recordingId==null||_channel==null||_remoteUid==null||_recordingId==null)
      {
        return;
      }


    var resp = await CallRecordApi().stopRecord(resourceId: _resourceId!, sid: _recordingId!, channel: _channel!, uid: _remoteUid!);
    switch (resp.statusCode)
    {
      case 200:
        _recordingId = null;
        _resourceId = null;
        break;

      case 400:
        MyHelper.snakeBar(context,title: 'Can,t stop record',message: '${jsonDecode(resp.body)['message']}',type: SnakeBarType.error);
        break;

      case 403:     
        MyHelper.snakeBar(context,title: 'Denied',message: '${jsonDecode(resp.body)['message']}',type: SnakeBarType.error);
        break;

      case 401:
        MyHelper.tokenExp(context);
        break;

      case 500:
        MyHelper.serverError(context, resp.body);
        break;    
        
        default:
        MyHelper.serverError(context, '${resp.statusCode}\n${resp.body}',title: 'Exception');
        break;
    }
  } 




}


