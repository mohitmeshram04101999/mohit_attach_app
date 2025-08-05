

import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:attach/api/apiPath.dart';
import 'package:attach/api/callsApi.dart';
import 'package:attach/api/listners_Api.dart';
import 'package:attach/api/local_db.dart';
import 'package:attach/callScreens/AudioCallScreen.dart';
import 'package:attach/callScreens/outGoingAudioCallScreen.dart';
import 'package:attach/callScreens/outGoingVideoCallScreen.dart';
import 'package:attach/modles/otp_responce.dart';
import 'package:attach/myfile/myast%20dart%20file.dart';
import 'package:attach/noticiation/notificationService.dart';
import 'package:attach/providers/call_kit_mennager.dart';
import 'package:attach/providers/my_hleper.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;

class AudioCallProvider with ChangeNotifier{


  final _appId = "72c9b3e1ba214cd184491351a6767ea5";
  bool _onOutGoingScreen = false;
  bool _onCallScreen = false;
  bool _isSpeakerOn = false;
  bool _isMicMuted = false;
  bool _init = false;
  String? _token;
  bool _listnersSet = false;
  int? _remoteUid;
  bool _localUserJoined = true;
  RtcEngine? _engine;

  User? _user;
  String? _channel;
  String? _callId;
  Timer? _timer;

  bool get onOutGoingCallScreen => _onOutGoingScreen;
  bool get onCallScreen => _onCallScreen;
  bool get isSpeakerOn => _isSpeakerOn;
  bool get isMicMuted => _isMicMuted;


  updateOutGoingCallScreen(bool b) {

    if(b)
      {
        log("Entero on Otgoing Call Screen");
      }
    else
    {
      log("Leave on Otgoing Call Screen");
    }

    _onOutGoingScreen=b;
  }

  updateOnCallScreen(bool b) {
    if(b)
    {
      log("Entero on Call Screen");
    }
    else
    {
      log("Leave on Call Screen");
    }
    _onCallScreen=b;
  }


  destroyEngine({bool? release = false}) async
  {

    await _engine?.leaveChannel();
    await _engine?.stopPreview();
    await _engine?.release();
    _engine = null;


  }




  setChannels({
    required User u,
    required String channel,
    required String callId,
})
  {
    _user = u;
    _channel = channel;
    _callId = callId;
  }


  // startAudioCall(BuildContext context)
  // {
  //   RoutTo(context, child: (p0, p1) => OutgoingVideoCallScreen(user: DB.curruntUser!, threadId: "threadId", callId: "callId"));
  // }

  Future<void> toggleSpeaker() async {
    _isSpeakerOn = !_isSpeakerOn;
    await _engine?.setEnableSpeakerphone(isSpeakerOn);
    notifyListeners();
  }


  Future<void> toggleMic() async {
    _isMicMuted = !_isMicMuted;
    await _engine?.muteLocalAudioStream(isMicMuted);
    notifyListeners();
  }

  startTimer()
  {
    _timer = Timer(Duration(seconds: 35), (){

      CallsApi().updateCall(
          callId: _callId??'',
          status: "MISSED",
          callEndedById: _user?.id
      );
      if(_onOutGoingScreen)
        {
          navigatorKey.currentState?.pop();
        }
    });
  }

  stopTimer()
  {
    _timer?.cancel();
    _timer = null;
  }

  makeAudioCall(BuildContext context,{
    required User user,
    required String threadId,
  }) async
  {

    var resp = await CallsApi().createCall(
        listenerId: user.id??'',
        threadId: threadId??'',
        callType: 'AUDIO',
    );



    switch(resp.statusCode)
    {

      case 201:

        var d = jsonDecode(resp.body);
         RoutTo(context, child: (p0, p1) => OutgoingAudiolCallScreen(callId: d['data']['_id'],threadId: threadId,user:user));
        break;

      case 400:
        MyHelper.snakeBar(context,title: 'Can,t make call',message: '${jsonDecode(resp.body)['message']}',type: SnakeBarType.error);
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


  joinCall({
    required User u,
    required String threadId,
    required String callId,
  })
  {

    setChannels(u: u, channel: threadId , callId: callId);

    RoutTo(navigatorKey.currentContext!, child:(p0, p1) => AudioCallScreen(user: u, threadId: threadId, callId: callId),);

  }





  _initRtc() async
  {
    _engine = createAgoraRtcEngine();

    await _engine?.initialize(RtcEngineContext(
      appId: _appId,
      channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,

    ));

    _init = true;

    notifyListeners();
  }



  _registerEventHandler() async
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

  _onJoinChannelSuccess(RtcConnection connection,int elapsed) async
  {
    print("On join Chennel Sucksess");
    _localUserJoined = true;

    // await _engine?.setEnableSpeakerphone(false);
    Future.delayed(Duration(milliseconds: 300), () async {
      _isSpeakerOn = false;
      await _engine?.setEnableSpeakerphone(false);
      print("Speakerphone forced OFF after join.");
      notifyListeners();
    });

    notifyListeners();
  }


  void _onUserJoined(RtcConnection connection, int remotId, int elapsed)
  {
    print("User join ");
    _remoteUid =remotId;
    notifyListeners();
  }

  void _onUserOffline(RtcConnection connection, int remoteUid,
      UserOfflineReasonType reason) {
    debugPrint("remote user $remoteUid left channel");
    _remoteUid = null;
   if(navigatorKey.currentContext!=null)
     {
       if(_onCallScreen)
       {
         _onCallScreen  = false;
         navigatorKey.currentState?.pop();
       }
       if(_onOutGoingScreen)
       {
         _onOutGoingScreen = false;
         navigatorKey.currentState?.pop();
       }
     }
    notifyListeners();

  }



  void _onTokenPrivilegeWillExpire (RtcConnection connection, String token) {
    if(navigatorKey.currentContext!=null)
      {
        MyHelper.serverError(navigatorKey.currentContext!,'[onTokenPrivilegeWillExpire] connection: ${connection.toJson()}, token: $token');
      }
    debugPrint(
        '[onTokenPrivilegeWillExpire] connection: ${connection.toJson()}, token: $token');
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


  _join() async
  {


    await _getToken();
    if(_token!=null)
    {
      await _engine?.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
      // await  _engine?.setEnableSpeakerphone(_isSpeakerOn);
      // await _engine?.enableVideo();
      // await _engine?.startPreview();


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


  audionCallStart() async
  {
    if(_init==false)
      {
        await _initRtc();
        await _registerEventHandler();
        await _join();
        // await _engine?.setEnableSpeakerphone(_isSpeakerOn);
      }
  }



  leaveCall({bool update = false}) async
  {
    _init = false;
    await _engine?.leaveChannel();
    await _engine?.stopPreview();
    _localUserJoined = false;
    _remoteUid = null;
    _token = null;
    _isMicMuted = false;
    _isSpeakerOn = false;
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
    _onCallScreen = false;
    await _engine?.release();
    _engine = null;
    stopTimer();

  }



  createThread(BuildContext context, User userId) async
  {
    var resp = await ListenerApi().createThread(userId.id??'');

    switch (resp.statusCode) {
      case 201:
        var d = jsonDecode(resp.body);
        _channel = '${d['data']['_id']}';
        makeAudioCall(context, user: userId, threadId: '${d['data']['_id']}');
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


}