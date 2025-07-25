

import 'dart:async';

import 'package:attach/componant/customEmojiPIcker.dart';
import 'package:attach/const/app_constante.dart';
import 'package:attach/myfile/animated%20dilog.dart';
import 'package:attach/myfile/screen_dimension.dart';
import 'package:attach/providers/chatProvider.dart';
import 'package:attach/providers/my_hleper.dart';
import 'package:attach/providers/profileProvider.dart';
import 'package:attach/screens/dash_board_screen/inbox/tabs/attach_doc_dailog_option.dart';
// import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ChatScreenMessageField extends StatefulWidget {
  final bool emoji;
  const ChatScreenMessageField({this.emoji = true,super.key});

  @override
  State<ChatScreenMessageField> createState() => _ChatScreenMessageFieldState();
}

class _ChatScreenMessageFieldState extends State<ChatScreenMessageField> {
  Timer? _timer;

  @override
  Widget build(BuildContext context) {
    return  Consumer<ChatProvider>(
      builder: (context, p, child) => Container(
        color: Const.scaffoldColor,
        padding: EdgeInsets.only(
          top: 5,
          bottom: SC.from_width(10),
          left: 8,
          right: 8,
        ),
        child: SizedBox(
          // height: SC.from_width(50),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(child:
              Container(

                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(SC.from_width(30))
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [


                    SizedBox(width: SC.from_width(20),),

                    Expanded(
                      child: TextFormField(
                        controller: p.textEditingController,
                        readOnly: !widget.emoji,
                        onChanged: (d){
                          p.startTyping();

                          _timer?.cancel();
                          _timer = Timer(Duration(milliseconds: 800), (){
                            p.stopTyping();
                          });

                        },


                        style: Const.font_400_16(context,size: SC.from_width(14),color: Colors.black),
                        maxLines: 5,
                        minLines: 1,
                        inputFormatters: [

                        ],

                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          hintText: 'Write Your Message',
                          hintStyle: Const.font_400_16(context,size: SC.from_width(14),color: Colors.grey),
                          filled: true,
                          contentPadding: EdgeInsets.zero,

                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30),borderSide: BorderSide.none),
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30),borderSide: BorderSide.none),
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30),borderSide: BorderSide.none),
                          errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30),borderSide: BorderSide.none),
                          focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30),borderSide: BorderSide.none),
                          disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30),borderSide: BorderSide.none),
                        ),
                      ),
                    ),





                    GestureDetector(
                        onPanDown: (d){
                          // p.sendVideo(context);



                          OpenDailogWithAnimation(context,
                            duration: Duration(milliseconds: 500),
                            animation: dailogAnimation.clip,
                            barriarColor: Colors.transparent,
                            clipSartRect: Rect.fromLTWH(d.globalPosition.dx, d.globalPosition.dy, 0, 0),
                            // clipSartRect: Rect.fromLTWH(d.globalPosition.dx, d.globalPosition.dy, SC.Screen_width , SC.Screen_height),
                            dailog: (animation, secondryAnimation) =>
                                AttachDocDialogOption(),
                          );
                        },
                        child: Container(

                          height: SC.from_width(30),
                          margin: EdgeInsets.only(bottom: SC.from_width(8),right: SC.from_width(8)),
                          width: SC.from_width(30),
                            child: Center(child: Image.asset("assets/icons/attac.png",width: SC.from_width(25),)))),


                  ],),
              ),),
              SizedBox(width: SC.from_width(4),),

              SizedBox(
                width: SC.from_width(50),
                height: SC.from_width(50),
                child: Container(



                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Const.yellow
                    ),



                    child: InkWell(
                      onTap: (){
                        if(p.textEditingController.text.isNotEmpty)
                          {
                            print("${(Provider.of<ProfileProvider>(context,listen: false).user?.wallet??0)<= 0}");
                            if((Provider.of<ProfileProvider>(context,listen: false).user?.wallet??0)<= 0)
                              // if(true)
                                {
                              MyHelper.snakeBar(context,title: 'Can,t send Message',message: 'You don\'t have enough balance',type: SnakeBarType.error);
                            }else {
                              p.sendMessage();
                            }
                          }
                      },
                        child: Padding(
                          padding: const EdgeInsets.all(13),
                          child: Image.asset("assets/icons/inboxpageicons/image 36.png",width: SC.from_width(22),),
                        )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
