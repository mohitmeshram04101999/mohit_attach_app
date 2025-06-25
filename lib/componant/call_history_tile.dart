import 'dart:async';

import 'package:attach/api/local_db.dart';
import 'package:attach/componant/online_user_Image_widget.dart';
import 'package:attach/const/app_constante.dart';
import 'package:attach/modles/call_history_responce_model.dart';
import 'package:attach/modles/otp_responce.dart';
import 'package:attach/modles/usertype.dart';
import 'package:attach/myfile/myast%20dart%20file.dart';
import 'package:attach/myfile/screen_dimension.dart';
import 'package:attach/providers/audio%20call%20provider.dart';
import 'package:attach/providers/videoCallProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CallHistoryTile extends StatelessWidget {
  final CallHistory? history;
  const CallHistoryTile({this.history,super.key});

  @override
  Widget build(BuildContext context) {

    // return Text('${history?.toJson()}');



     return InkWell(
       child: Container(
         height: SC.from_width(80),
         margin: EdgeInsets.symmetric(horizontal: 14),
         child: Row(
           crossAxisAlignment: CrossAxisAlignment.center,
           children: [
             SizedBox(
               height: SC.from_width(48),
               width: SC.from_width(48),
               child:OnlineUserImageWidget(image: history?.user?.image??'',online: false,),
             ),
             SizedBox(width: SC.from_width(12),),
       
             Expanded(child:
             Column(
               mainAxisAlignment: MainAxisAlignment.center,
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
       
                 Row(
                   children: [
                     Flexible(child: Text(history?.user?.name??'',style: Const.font_900_20(context,size: SC.from_width(16)),
                     overflow: TextOverflow.ellipsis,maxLines: 1,)),
                     // SizedBox(width: SC.from_width(8),),
                     if(history?.user?.verified==true)
                       Image.asset('assets/icons/verIcon.png',width: SC.from_width(16),)
                   ],
                 ),
       
                 Padding(
                   padding: EdgeInsets.only(top: SC.from_width(6)),
       
                   child: Row(
                     children: [
                       Image.asset(
                         history?.call=='INCOMING'?
                         "assets/icons/inboxpageicons/incomming.png":
                         'assets/icons/inboxpageicons/outgoing.png',
                         width: SC.from_width(17),
                         color: history?.status=='COMPLETE'?
                         Colors.green:Colors.red,
                       ),
                       SizedBox(width: SC.from_width(8),),
       
                       Text(history?.dateTime??'',style: Const.font_400_12(context,color: Color.fromRGBO(190, 190, 190, 1)),),
                     ],
                   ),
                 )
       
       
               ],
             )),
       
       
             Consumer<AudioCallProvider>(
               builder: (context, p, child) => IconButton(

                 onPressed:(DB.curruntUser?.userType==UserType.listener)?null: (){
                 if(history?.callType=='VIDEO')
                 {
                   Provider.of<VideoCallProvider>(context,listen: false).makeVideoCall(context, user: User.fromJson(history?.user?.toJson()??{}), threadId: history?.threadId??'');
                 }
                 else
                 {
                   Provider.of<AudioCallProvider>(context,listen: false).makeAudioCall(context, user: User.fromJson(history?.user?.toJson()??{}), threadId: history?.threadId??'');

                 }
               }, icon: history?.callType=='VIDEO'?
               Image.asset(
                 'assets/icons/inboxpageicons/vid.png',
                 width: SC.from_width(25),
               ):
               Image.asset(
                 'assets/icons/inboxpageicons/aud.png',
                 width: SC.from_width(22),
               ),
               ),
             )
       
       
           ],
         ),
       ),
     );

  }
}
