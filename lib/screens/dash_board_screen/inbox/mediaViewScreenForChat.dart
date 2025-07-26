import 'package:attach/const/app_constante.dart';
import 'package:attach/myfile/screen_dimension.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';




class MediaViewScreenForChat extends StatefulWidget {
  final String url;
  final String type;
  const MediaViewScreenForChat({required this.type,required this.url,super.key});

  @override
  State<MediaViewScreenForChat> createState() => _MediaViewScreenForChatState();
}

class _MediaViewScreenForChatState extends State<MediaViewScreenForChat> {

  bool imagError = false;


  VideoPlayerController? videoPlayerController;


  initVideo () async
  {
    videoPlayerController = VideoPlayerController.network(widget.url);
    await videoPlayerController!.initialize();
    setState(() {});
    videoPlayerController!.play();
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initVideo();
  }




  @override
  Widget build(BuildContext context) {



    if(widget.type=='video'){
      return Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.black,
        child: InteractiveViewer(
          minScale: 1,
          maxScale: imagError?1:4,
          child: (videoPlayerController?.value.isInitialized==true)?
          AspectRatio(
            aspectRatio: videoPlayerController?.value.aspectRatio??1,
              child: VideoPlayer(videoPlayerController!)):Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }





    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.black,
        child: InteractiveViewer(
          minScale: 1,
          maxScale: imagError?1:4,
          child: Image.network(
              widget.url,
            errorBuilder: (context, error, stackTrace) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (!imagError) {
                  setState(() {
                    imagError = true;
                  });
                }
              });

                return Center(child: Padding(
                  padding: const EdgeInsets.all(40),
                  child: Image.asset("assets/icons/inboxpageicons/img.png"),
                ),);
            },
          ),
        ),

    );
  }
}
