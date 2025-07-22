import 'dart:ui';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:attach/api/callsApi.dart';
import 'package:attach/api/local_db.dart';
import 'package:attach/const/app_constante.dart';
import 'package:attach/modles/otp_responce.dart';
import 'package:attach/myfile/screen_dimension.dart';
import 'package:attach/noticiation/notificationService.dart';
import 'package:attach/providers/audio%20call%20provider.dart';
import 'package:attach/providers/videoCallProvider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class OutgoingAudiolCallScreen extends StatefulWidget {
  final User user;
  final String threadId;
  final String callId;
  const OutgoingAudiolCallScreen({
    required this.user,
    required this.threadId,
    required this.callId,
    super.key});

  @override
  State<OutgoingAudiolCallScreen> createState() => _OutgoingAudiolCallScreenState();
}

class _OutgoingAudiolCallScreenState extends State<OutgoingAudiolCallScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myInit();
  }

  myInit() async
  {
    var p =  Provider.of<AudioCallProvider>(context,listen: false);
    p.setChannels(u: widget.user,callId: widget.callId,channel: widget.callId);
    p.startTimer();

    p.updateOutGoingCallScreen(true);
    await p.audionCallStart();
  }




  bool canTap = true;



  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    var p =  Provider.of<AudioCallProvider>(navigatorKey.currentContext!,listen: false);
    p.updateOutGoingCallScreen(false);
  }


  @override
  Widget build(BuildContext context) {


    return Consumer<AudioCallProvider>(
      builder: (context, p, child) => WillPopScope(
        onWillPop: ()async{
          p.updateOutGoingCallScreen(false);
          return false;
        },
        child: Scaffold(

          body: Stack(
            children: [
              // Fullscreen remote video
              Positioned.fill(
                child:  Stack(
                  children: [
                    // Positioned.fill(
                    //   child: ImageFiltered(
                    //     imageFilter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    //     child: Image.network(
                    //       widget.user.image??'',
                    //       fit: BoxFit.cover,
                    //     ),
                    //   ),
                    // ),

                    Center(
                      heightFactor: 1.9,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                              height: SC.from_width(140),
                              width: SC.from_width(140),
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: Image.network(widget.user.image??'',fit: BoxFit.cover,)),
                          SizedBox(height: SC.from_width(10),),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Text(widget.user.name??'',maxLines: 1,overflow: TextOverflow.ellipsis,style: Const.font_700_30(context,size: SC.from_width(24)),),
                          ),
                          SizedBox(height: SC.from_width(10),),
                          Text("Calling...",style: Const.font_400_14(context),),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              
              
              
              if(kDebugMode)
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Speaker = ${p.isSpeakerOn}"),
                      Text("mikeMute = ${p.isMicMuted}")
                    ],
                  ),
                ),




              // Bottom buttons
              Positioned(
                bottom: SC.from_width(80),
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: ()=>p.toggleSpeaker(),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Color.fromRGBO(230,230,250,1),width: .5),
                          shape: BoxShape.circle
                        ),
                        child: CircleAvatar(

                          radius: 35,
                          // backgroundColor: Colors.black.withOpacity(.3),
                          backgroundColor: p.isSpeakerOn?Colors.white:Const.primeColor,
                          child: Icon(Icons.volume_up,
                            color: p.isSpeakerOn?Const.primeColor:Colors.white,
                          ),
                        ),
                      ),
                    ),

                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Color.fromRGBO(230,230,250,1),width: .5),
                          shape: BoxShape.circle
                      ),
                      child: GestureDetector(
                        onTap: ()=>p.toggleMic(),
                        child: CircleAvatar(
                          radius: 35,
                          backgroundColor: p.isMicMuted?Const.primeColor:Colors.white,
                          child: Icon((p.isMicMuted)?Icons.mic_off:Icons.mic,
                              color: p.isMicMuted?Colors.white:Const.primeColor,
                          ),
                        ),
                      ),
                    ),





                    GestureDetector(
                      onTap: ()async{

                        if(canTap)
                          {
                            canTap = false;
                            await CallsApi().updateCall(
                              callId: widget.callId,
                              status: "REJECTED",
                              callEndedById: DB.curruntUser?.id,
                            );
                            await p.leaveCall();
                            p.updateOutGoingCallScreen(false);
                            Navigator.pop(context);
                            canTap = true;
                          }
                      },
                      child: CircleAvatar(
                        radius: 35,
                        backgroundColor: Colors.red,
                        child: Icon(Icons.call_end, color: Colors.white,size: SC.from_width(30),),
                      ),
                    ),

                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );;
  }
}