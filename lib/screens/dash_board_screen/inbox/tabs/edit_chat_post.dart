import 'dart:io';

import 'package:attach/const/app_constante.dart';
import 'package:attach/myfile/screen_dimension.dart';
import 'package:attach/providers/chatProvider.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';



class EditChatPostDialog extends StatefulWidget {
  final String filePath;
  const EditChatPostDialog({required this.filePath,super.key});

  @override
  State<EditChatPostDialog> createState() => _EditChatPostDialogState();
}

class _EditChatPostDialogState extends State<EditChatPostDialog> {


   VideoPlayerController?
  videoController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.filePath.isVectorFileName)
      {
        videoController = VideoPlayerController.file(File(widget.filePath));

        
        videoController?.initialize().then((d){
          setState(() {});
        });
      }
  }



  @override
  Widget build(BuildContext context) {
    return  Consumer<ChatProvider>(
      builder: (context, p, child) =>  Card(
        color: Const.scaffoldColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [

              if(widget.filePath.isImageFileName) ...[
                Expanded(child: Image.file(File(widget.filePath),fit: BoxFit.cover,)),
              ]
              else if(widget.filePath.isVideoFileName) ...[
                Expanded(
                  
                  
                  // -----------------
                  // child: AspectRatio(
                  //   aspectRatio: videoController?.value.aspectRatio??1,
                  //   child:(videoController?.value.isInitialized==true)? VideoPlayer(videoController!):Center(child: CircularProgressIndicator(),),
                  // ),
                  
                  child: Center(child: Card(

                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.videocam_rounded,size: SC.from_width(30),color: Colors.white,),
                          SizedBox(width: SC.from_width(10),),
                          Flexible(child: Text(widget.filePath.split("/").last,style: Const.font_400_14(context,color: Colors.white),)),
                        ],

                      ),
                    ),
                  )),
                ),
              ]
              else ...[
               
                Text("file")
              ],
              

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: p.textEditingController,
                        style: Const.font_400_14(context,color: Colors.black),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100)),

                          fillColor: Colors.white,
                          filled: true,
                          hintText: 'Add Text....',
                          hintStyle: Const.font_400_14(context,color: Colors.grey),
                      
                        ),
                      ),
                    ),
                    SizedBox(width: 8,),

                    FloatingActionButton(onPressed: (){
                      Navigator.pop(context,true);
                    },
                      child: Image.asset("assets/icons/inboxpageicons/image 36.png",width: SC.from_width(22),),
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

