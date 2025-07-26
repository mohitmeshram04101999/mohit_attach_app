import 'package:attach/api/local_db.dart';
import 'package:attach/const/app_constante.dart';
import 'package:attach/modles/load_chat_model.dart';
import 'package:attach/myfile/myast%20dart%20file.dart';
import 'package:attach/myfile/screen_dimension.dart';
import 'package:attach/other/date_time_manager.dart';
import 'package:attach/screens/dash_board_screen/inbox/mediaViewScreenForChat.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class MessageMediaWidget extends StatefulWidget {
  final Message message;
  final Widget seen;
  const MessageMediaWidget({
    required this.seen,
    required this.message,super.key});

  @override
  State<MessageMediaWidget> createState() => _MessageMediaWidgetState();
}

class _MessageMediaWidgetState extends State<MessageMediaWidget> {


  VideoPlayerController? controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.message.mediaType=='VIDEO')
      {
        controller = VideoPlayerController.networkUrl(Uri.parse(widget.message.media??''));
        controller?.initialize().then((d){setState(() {

        });});
      }
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller?.pause();
    controller?.dispose();
  }


  @override
  Widget build(BuildContext context) {

    bool self = widget.message.sender == DB.curruntUser?.id;


    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius:   BorderRadius.circular(8),
        color: self?Const.primeColor:Colors.white,
      ),
      alignment: self?Alignment.centerRight:Alignment.centerLeft,
      margin: EdgeInsets.only(
        left: self?SC.from_width(70):0,
        right: self?0:SC.from_width(70),
        top: 8,
      ),
      child: Column(
        crossAxisAlignment: self?CrossAxisAlignment.end:CrossAxisAlignment.start,
        children: [

          if(widget.message.mediaType=='VIDEO')
            ClipRRect(
              clipBehavior:   Clip.hardEdge,
              borderRadius: BorderRadius.circular(8),
              child: AspectRatio(
                  aspectRatio: controller?.value.aspectRatio??1,
                child: (controller?.value.isInitialized==true)?Stack(
                  children: [
                    GestureDetector(
                        onTap: (){
                      RoutTo(context, child: (p0, p1) => MediaViewScreenForChat(type: 'video', url: widget.message.media??''),);
                        },
                        child: VideoPlayer(controller!)),
                    if(controller?.value.isPlaying!=true)
                      Align(
                      alignment: Alignment.center,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black26,
                        ),
                        child: IconButton(
                          icon: const Icon(
                            Icons.play_arrow,
                            color: Colors.white,
                            size: 50,
                          ),
                          onPressed: (){
                            RoutTo(context, child: (p0, p1) => MediaViewScreenForChat(type: 'video', url: widget.message.media??''),);
                            setState(() {

                            });
                          },
                        ),
                      ),
                    ),
                  ]
                ):Center(child: CircularProgressIndicator(
                  color: Const.yellow,
                ),),
              ),
            ),

          if(widget.message.mediaType=='IMAGE')
            AspectRatio(
            aspectRatio: 1.4,
            child: GestureDetector(
              onTap: (){
                RoutTo(context, child: (p0, p1) => MediaViewScreenForChat(type: 'img', url: widget.message.media??''),);
              },
              child: Container(

                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Image.network(widget.message.media??'',fit:  BoxFit.cover,
                  errorBuilder:  (context, error, stackTrace) => Center(child: Image.asset("assets/icons/inboxpageicons/img.png",width: SC.from_width(100),)),
                  )),
            ),
          ),

          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if(widget.message.message!=null)
                Flexible(
                  child: Padding(

                    padding: const EdgeInsets.only(left: 8),
                    child: Text(widget.message.message??'',style: Const.font_400_14(
                      context,
                      color:
                      self ? Colors.white : const Color.fromRGBO(58, 61, 64, 1),
                    ),),
                  ),
                ),
              const SizedBox(width: 8),
              Padding(
                padding: const EdgeInsets.only(bottom: 2,top: 5),
                child: Text(
                  DateTimeManager().formatTime12Hour(
                    widget.message?.createdAt?.add(
                      const Duration(minutes: 330),
                    ),
                  ) ??
                      '',
                  style: Const.font_500_16(
                    context,
                    color: Colors.grey,
                    size: SC.from_width(8),
                  )?.copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(width: 8),

              if(self)
                widget.seen
            ],
          )
        ],
      ),
    );



  }
}
