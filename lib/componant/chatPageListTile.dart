import 'package:attach/componant/online_user_Image_widget.dart';
import 'package:attach/const/app_constante.dart';
import 'package:attach/modles/chat_contect_model.dart';
import 'package:attach/myfile/myast%20dart%20file.dart';
import 'package:attach/myfile/screen_dimension.dart';
import 'package:attach/other/date_time_manager.dart';
import 'package:attach/providers/chatProvider.dart';
import 'package:attach/providers/my_hleper.dart';
import 'package:attach/screens/dash_board_screen/inbox/chat_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatPageListTile extends StatelessWidget {
  final Map? data;
  final ChatContact? contact;
  const ChatPageListTile({this.contact,this.data,super.key});

  @override
  Widget build(BuildContext context) {



     return InkWell(

       onLongPress:(kReleaseMode)?null: (){
         MyHelper.serverError(context, "${contact?.toJson()}");
       },

       onTap: (){
         print("Tap");
         Provider.of<ChatProvider>(context,listen: false).startChat(contact?.id??'');
         RoutTo(context, child: (p0, p1) => ChatScreen(contact: contact),);
       },
       child: Container(
         // color: Colors.red,
         height: SC.from_width(80),
         margin: EdgeInsets.only(
           left: 14,
           right: 14
         ),
         child: Row(
          children: [
            Hero(
                tag: 'chat_page${contact?.user?.id}${contact?.user?.image??''}',
                child: OnlineUserImageWidget(
                  online: contact?.user?.online??false,
                  busy: contact?.user?.isBusy??false,
                    image: contact?.user?.image??'',
                )),
            SizedBox(width: SC.from_width(12),),

            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(child: Text(contact?.user?.name??'',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Const.font_900_20(context,size: SC.from_width(16)),)),
                    SizedBox(width: SC.from_width(8),),
                    if(contact?.user?.userVerified??false)
                      Image.asset("assets/icons/verIcon.png",width: SC.from_width(18),),
                  ],
                ),

                Text(contact?.lastMessage?.message??'',maxLines: 1,overflow: TextOverflow.ellipsis,style: Const.font_400_12(context,color: Color.fromRGBO(190, 190, 190, 1))?.copyWith(fontWeight: FontWeight.w500),)
              ],
            )),

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(DateTimeManager().formatTime12Hour(contact?.lastMessage?.createdAt?.add(Duration(minutes: 330)))??'',style: Const.font_400_14(context,size: SC.from_width(10),color: Color.fromRGBO(190, 190, 190, 1)),),
                SizedBox(height: SC.from_width(13),),

                if((contact?.unseenCount??0)>0)
                  Container(

                    padding: EdgeInsets.symmetric(horizontal: SC.from_width(8)),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(100)

                    ),
                    child: Text('${contact?.unseenCount??''}',style: Const.font_700_16(context,size: SC.from_width(10),color: Colors.black),),
                  ),

              ],)

          ],
             ),
       ),
     );

  }
}
