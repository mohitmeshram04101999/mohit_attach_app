import 'package:attach/modles/home_data_responce_model.dart';
import 'package:attach/myfile/screen_dimension.dart';
import 'package:attach/providers/selfStoryProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class ShowStoryWidgetForSelf extends StatefulWidget {
  final SelfStoryModel story;
  final bool isVideo;
  final Function(Duration duration)? onVideoStart;
  const ShowStoryWidgetForSelf({this.onVideoStart,this.isVideo=false,required this.story,super.key});

  @override
  State<ShowStoryWidgetForSelf> createState() => _ShowStoryWidgetForSelfState();
}

class _ShowStoryWidgetForSelfState extends State<ShowStoryWidgetForSelf> {

  VideoPlayerController? _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("statuse of seen ${widget.story.seen}");

    if(widget.isVideo)
    {
      _controller = VideoPlayerController.networkUrl(Uri.parse(widget.story.imageOrVideo??''));
      _controller?.initialize().then((d){
        //
        Provider.of<SelfStoryProvider>(context,listen: false).resatTimer(context,d: _controller?.value.duration);

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

    if(widget.isVideo)
    {


      return Stack(
        children: [



          Container(
            // child:Image.network(widget.story.imageOrVideo??''),
            alignment: Alignment.center,
            child: (_controller?.value.isInitialized==true)? AspectRatio(
              aspectRatio: _controller!.value.aspectRatio,
              child: VideoPlayer(_controller!),
            ):Center(child: CircularProgressIndicator()),
          ),

          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: (){
                    Provider.of<SelfStoryProvider>(context,listen: false).previousPage();
                  },
                  child: Container(
                    height: double.infinity,
                    width:SC.from_width(150),

                  ),
                ),
              ),
              Expanded(
                child: Card(
                  color: Colors.transparent,
                  elevation: 0,
                  child: InkWell(
                    onTap: (){
                      Provider.of<SelfStoryProvider>(context,listen: false).nextPage(context);
                    },
                    child: Container(
                      width: SC.from_width(150),
                      height: double.infinity,

                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      );

    }

    return Stack(
      children: [



        Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: double.infinity,
          child:Image.network(widget.story.imageOrVideo??''),
          // child: Text("${widget.story.toJson()}"),
        ),

        Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: (){
                  Provider.of<SelfStoryProvider>(context,listen: false).previousPage();
                },
                child: Container(
                  height: double.infinity,
                  width:SC.from_width(150),

                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: (){
                  Provider.of<SelfStoryProvider>(context,listen: false).nextPage(context);
                },
                child: Container(
                  width: SC.from_width(150),
                  height: double.infinity,

                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}