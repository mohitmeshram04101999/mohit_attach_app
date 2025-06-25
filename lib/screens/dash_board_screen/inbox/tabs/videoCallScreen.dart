import 'dart:async';
import 'dart:ui';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:attach/api/local_db.dart';
import 'package:attach/const/app_constante.dart';
import 'package:attach/modles/otp_responce.dart';
import 'package:attach/myfile/screen_dimension.dart';
import 'package:attach/noticiation/notificationService.dart';
import 'package:attach/providers/videoCallProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VideoCallScreen extends StatefulWidget {
  final String channelId;
  final String callId;
  final User user;
  const VideoCallScreen({required this.user,required this.callId,required this.channelId, super.key});

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  @override
  void initState() {
    super.initState();

    final provider = Provider.of<VideoCallProvider>(context, listen: false);
    provider.closeOverlay();
    provider.closetimer();
    provider.getPermmission();
    provider.setChanel(widget.channelId,widget.callId,widget.user);
    provider.onCall(true);
    provider.startVideoCall();
    DB().deleteCallEvent();

  }


  dispose(){
    super.dispose();
    final provider = Provider.of<VideoCallProvider>(navigatorKey.currentContext!, listen: false);
    provider.onCall(false);
  }




  bool canTap = true;

  @override
  Widget build(BuildContext context) {
    return Consumer<VideoCallProvider>(
      builder: (context, p, child) => WillPopScope(
        onWillPop: ()async{
          if(p.isLocalUserJoined)
            {
              p.showOverlay(context);
            }
          p.onCall(false);
          return true;
        },
        child: Scaffold(
          backgroundColor: Colors.black,
          body: Stack(
            children: [
              // Fullscreen remote video
              Positioned.fill(
                child: p.remoteUid != null
                    ? AgoraVideoView(
                  controller: VideoViewController.remote(
                    rtcEngine: p.engine!,
                    canvas: VideoCanvas(uid: p.remoteUid),
                    connection: RtcConnection(channelId: widget.channelId),
                  ),
                )
                    :
                Text("Waiting......"),
                //
                // Stack(
                //   children: [
                //     Positioned.fill(
                //       child: ImageFiltered(
                //         imageFilter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                //         child: Image.network(
                //           "${p.user?.image ?? ''}",
                //           fit: BoxFit.cover,
                //         ),
                //       ),
                //     ),
                //
                //     Center(
                //       heightFactor: 1.9,
                //       child: Column(
                //         mainAxisSize: MainAxisSize.min,
                //         children: [
                //           Container(
                //             height: SC.from_width(210),
                //             width: SC.from_width(210),
                //             clipBehavior: Clip.hardEdge,
                //             decoration: BoxDecoration(
                //               shape: BoxShape.circle,
                //             ),
                //               child: Image.network("${p.user?.image??''}",fit: BoxFit.cover,)),
                //           SizedBox(height: SC.from_width(10),),
                //           Text("${p.user?.name??''}",style: Const.font_700_30(context,size: SC.from_width(24)),),
                //           SizedBox(height: SC.from_width(10),),
                //           Text("Calling...",style: Const.font_400_14(context),),
                //         ],
                //       ),
                //     )
                //   ],
                // ),
              ),

              // Top bar
              // if(p.remoteUid!=null)
                Positioned(
                top: SC.from_width(80),
                left: 16,
                right: 16,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text('${p.user?.name??''}', style: TextStyle(color: Colors.white, fontSize: 20)),
                        SizedBox(height: 4),
                        // Text("15:36 mins", style: TextStyle(color: Colors.white70, fontSize: 14)),
                        if(p.remoteUid!=null)...[
                          CallTimer()
                        ]
                        else...[
                          Text("Calling")
                        ]
                      ],
                    ),
                  ],
                ),
              ),

              // Local user video
              if (p.isLocalUserJoined )
                Positioned(
                  bottom: SC.from_width(170),
                  right: 16,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      width: SC.from_width(120),
                      height: SC.from_width(160),
                      color: Colors.black,
                      child: Stack(
                        children: [
                          AgoraVideoView(
                            controller: VideoViewController(
                              rtcEngine: p.engine!,
                              canvas: VideoCanvas(uid: 0),
                            ),
                          ),
                          Positioned(
                            bottom: 8,
                            right: 8,
                            child: GestureDetector(
                              onTap: ()=>p.switchCamera(),
                              child: CircleAvatar(
                                radius: 15,
                                backgroundColor: Colors.black.withOpacity(.3),
                                child: Icon(Icons.cameraswitch_sharp, color: Colors.white,size: SC.from_width(18),),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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



                    // SizedBox(width: 40),
                    // GestureDetector(
                    //   onTap: ()=>p.switchCamera(),
                    //   child: CircleAvatar(
                    //     radius: 28,
                    //     backgroundColor: Colors.black.withOpacity(.3),
                    //     child: Icon(Icons.cameraswitch_sharp, color: Colors.white,),
                    //   ),
                    // ),


                    GestureDetector(
                      onTap: ()async{
                        if(canTap)
                          {
                            canTap = false;
                            await p.leaveCall(update: true);
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
    );
  }
}




class CallTimer extends StatefulWidget {
  const CallTimer({super.key});

  @override
  State<CallTimer> createState() => _CallTimerState();
}

class _CallTimerState extends State<CallTimer> {
  int timeInSeconds = 0;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        timeInSeconds++;
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  String get formattedTime {
    final minutes = timeInSeconds ~/ 60;
    final seconds = timeInSeconds % 60;
    final minutesStr = minutes.toString().padLeft(2, '0');
    final secondsStr = seconds.toString().padLeft(2, '0');
    return "$minutesStr:$secondsStr mins";
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      formattedTime,
      style: const TextStyle(color: Colors.white70, fontSize: 14),
    );
  }
}

