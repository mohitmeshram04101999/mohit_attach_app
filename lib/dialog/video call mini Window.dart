
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:attach/myfile/myast%20dart%20file.dart';
import 'package:attach/myfile/screen_dimension.dart';
import 'package:attach/providers/videoCallProvider.dart';
import 'package:attach/screens/dash_board_screen/inbox/tabs/videoCallScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class VideoCallMiniWindow extends StatefulWidget {
  final String channelId;
  final String? callId;
  const VideoCallMiniWindow({required this.callId,required this.channelId,super.key});

  @override
  State<VideoCallMiniWindow> createState() => _VideoCallMiniWindowState();
}

class _VideoCallMiniWindowState extends State<VideoCallMiniWindow> {
  
  
  
  double top = 20;
  double right = 20;

  bool show = true;
  
  
  @override
  Widget build(BuildContext context) {



    return Consumer<VideoCallProvider>(
        builder: (context, p, child) {




          return SafeArea(
            child: Stack(
              children: [
                Positioned(
                  top: 20,
                  right: 20,
                  child: GestureDetector(
                    onPanUpdate: (d){
                      top = d.delta.dy;
                      right = d.delta.dx;
                      setState(() {});
                    },
                    child: Container(
                      height: SC.from_width(250),
                      width: SC.from_width(150),
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Stack(
                        children: [
                          AgoraVideoView(
                            controller: VideoViewController.remote(rtcEngine: p.engine!,
                                canvas: VideoCanvas(uid: p.remoteUid),
                                connection: RtcConnection(channelId: widget.channelId)
                            ),

                          ),

                          Align(
                            alignment: Alignment.bottomRight,
                            child: IconButton(
                              onPressed: (){
                                RoutTo(context, child: (p0, p1) => VideoCallScreen(
                                  user: p.user!,
                                    callId: widget.callId!,
                                    channelId: widget.channelId));
                              },

                              icon: Icon(Icons.fullscreen),),
                          )
                        ],
                      ),
            
                    ),
                  ),
                ),
              ],
            ),
          );
        },);


  }
}
