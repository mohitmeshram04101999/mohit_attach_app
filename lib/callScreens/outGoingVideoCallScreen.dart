import 'dart:ui';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:attach/api/callsApi.dart';
import 'package:attach/api/local_db.dart';
import 'package:attach/const/app_constante.dart';
import 'package:attach/modles/otp_responce.dart';
import 'package:attach/myfile/screen_dimension.dart';
import 'package:attach/noticiation/notificationService.dart';
import 'package:attach/providers/videoCallProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class OutgoingVideoCallScreen extends StatefulWidget {
  final User user;
  final String threadId;
  final String callId;
  const OutgoingVideoCallScreen({
    required this.user,
    required this.threadId,
    required this.callId,
    super.key});

  @override
  State<OutgoingVideoCallScreen> createState() => _OutgoingVideoCallScreenState();
}

class _OutgoingVideoCallScreenState extends State<OutgoingVideoCallScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   var p =  Provider.of<VideoCallProvider>(context,listen: false);
   p.startTimer();
   p.setChanel(widget.threadId, widget.callId, widget.user);
   p.updateOutGoingCallStatus(true);
  }


  bool canTap = true;


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    var p =  Provider.of<VideoCallProvider>(navigatorKey.currentContext!,listen: false);
    p.updateOutGoingCallStatus(false);

  }



  @override
  Widget build(BuildContext context) {
    return Consumer<VideoCallProvider>(
      builder: (context, p, child) => WillPopScope(
        onWillPop: ()async{
          p.updateOutGoingCallStatus(false);
          return false;
        },
        child: Scaffold(
          backgroundColor: Colors.black,
          body: Stack(
            children: [
              // Fullscreen remote video
              Positioned.fill(
                child:  Stack(
                  children: [
                    Positioned.fill(
                      child: ImageFiltered(
                        imageFilter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Image.network(
                          widget.user.image??'',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace){

                            return Text("Image not found");

                             return widget.user.gender=="FEMALE"?Image.asset("assets/avtars/femaleFix.jpg",fit: BoxFit.cover,):Image.asset("assets/avtars/maleFix.jpg",fit: BoxFit.cover,);
                          },
                        ),
                      ),
                    ),

                    Center(
                      heightFactor: 1.9,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                              height: SC.from_width(210),
                              width: SC.from_width(210),
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: Image.network(widget.user.image??'',fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                if(widget.user.gender=="FEMALE")
                                  {
                                    return Image.asset("assets/avtars/femaleFix.jpg",fit: BoxFit.cover,);
                                  }

                                return Image.asset("assets/avtars/maleFix.jpg",fit: BoxFit.cover,);
                                },
                              )),
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
                      child: CircleAvatar(
                        radius: 35,
                        backgroundColor: Colors.black.withOpacity(.3),
                        child: Icon(p.isSpeakerOn?Icons.volume_up:Icons.volume_off, color:Colors.white),
                      ),
                    ),

                    GestureDetector(
                      onTap: ()=>p.toggleMic(),
                      child: CircleAvatar(
                        radius: 35,
                        backgroundColor: Colors.black.withOpacity(.3),
                        child: Icon(p.isMicMuted? Icons.mic_off:Icons.mic, color: Colors.white,),
                      ),
                    ),





                    GestureDetector(
                      onTap: ()async{
                        if(canTap)
                          {
                            canTap =  false;
                            await CallsApi().updateCall(
                              callId: widget.callId,
                              status: "REJECTED",
                              callEndedById: DB.curruntUser?.id,
                            );
                            p.updateOutGoingCallStatus(false);
                            p.leaveCall();

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
