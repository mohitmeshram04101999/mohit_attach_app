import 'package:attach/api/storyApi.dart';
import 'package:attach/modles/home_data_responce_model.dart';
import 'package:attach/providers/story_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';




class ShowStoryWidget extends StatefulWidget {
  final Story story;
  final bool isVideo;
  final void Function(Duration duration)? onVideoStart;
  const ShowStoryWidget({this.onVideoStart,this.isVideo=false,required this.story,super.key});

  @override
  State<ShowStoryWidget> createState() => _ShowStoryWidgetState();
}

class _ShowStoryWidgetState extends State<ShowStoryWidget> {

  VideoPlayerController? _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("statuse of seen ${widget.story.seen}");
    if(widget.story.seen!=true)
    {
      StoryApi().seenStory(storyId: widget.story.id??'');
    }

    if(widget.isVideo)
      {
        _controller = VideoPlayerController.networkUrl(Uri.parse(widget.story.imageOrVideo??''));
        _controller?.initialize().then((d){
          //
          Provider.of<StoryProvider>(context,listen: false).resetTime(context,duration: _controller?.value.duration);

          if(widget.isVideo&&widget.onVideoStart!=null)
            {
              widget.onVideoStart!(_controller!.value.duration);
            }

          //
          _controller!.play();
          //

          setState(() {

          });
        });
      }
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if(_controller!=null)
      {
        _controller?.dispose();

      }
  }

  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [
        Consumer(builder: (context, p, child) {
          if(widget.isVideo)
          {

            return Container(
              alignment: Alignment.center,
              // child:Image.network(widget.story.imageOrVideo??''),
              child: (_controller?.value.isInitialized==true)? AspectRatio(
                aspectRatio: _controller!.value.aspectRatio,
                child: VideoPlayer(_controller!),
              ):Center(child: CircularProgressIndicator()),
            );
          }

          return Container(
            alignment: Alignment.center,
            child:Image.network(widget.story.imageOrVideo??''),
            // child: Text("${widget.story.toJson()}"),
          );
        },),

        Card(
          color: Colors.transparent,
          elevation: 0,
          child: Row(children: [
            Expanded(child:InkWell(

              onTap: (){
                Provider.of<StoryProvider>(context,listen: false).previousPage();
              },
                child: Container(color: Colors.black38,)),),

            //
            Expanded(child:InkWell(onTap: (){
              Provider.of<StoryProvider>(context,listen: false).changePage(context);
              },child: Center(child: Container(color: Colors.black38,)),)),
            ],),
        )
      ]);
  }
}


