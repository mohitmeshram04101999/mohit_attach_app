
import 'package:attach/myfile/screen_dimension.dart';
import 'package:attach/providers/chatProvider.dart';
import 'package:attach/providers/chat_screen_message_field.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class CustomEmojiPicker extends StatelessWidget {
  const CustomEmojiPicker({super.key});

  @override
  Widget build(BuildContext context) {
    return  BottomSheet(onClosing: (){}, builder: (context) => SizedBox(
      height: SC.Screen_width,
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 0,
        child: Consumer<ChatProvider>(
          builder: (context, p, child) =>  Column(
            children: [
              Hero(tag: "messageTag", child: ChatScreenMessageField(emoji: false,),),
              Expanded(
                child: SizedBox(),
                // child: EmojiPicker(
                //
                //
                //
                //
                //   config: Config(
                //     height: 9,
                //
                //
                //
                //     categoryViewConfig: CategoryViewConfig(
                //       backgroundColor: Const.primeColor,
                //      iconColorSelected: Const.yellow,
                //
                //       iconColor: Colors.white,
                //
                //
                //     ),
                //
                //     emojiViewConfig: EmojiViewConfig(
                //       backgroundColor: Const.scaffoldColor,
                //       emojiSizeMax: SC.from_width(20),
                //
                //     ),
                //
                //
                //     bottomActionBarConfig: BottomActionBarConfig(
                //       backgroundColor: Const.primeColor,
                //       buttonColor: Const.yellow,
                //       enabled: false
                //     ),
                //     searchViewConfig: SearchViewConfig(
                //       backgroundColor: Colors.white,
                //       inputTextStyle: Const.font_400_16(context,size: SC.from_width(14),color: Colors.black),
                //     ),
                //   ),
                //   textEditingController: p.textEditingController,
                //   onEmojiSelected: (category, emoji){
                //     print("${emoji.emoji} ${emoji.name}");
                //   },
                //
                // ),
              ),
            ],
          ),
        ),
      ),
    ),
    );
  }
}
