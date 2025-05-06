import 'package:attach/const/app_constante.dart';
import 'package:attach/myfile/screen_dimension.dart';
import 'package:flutter/material.dart';

class ChatPageListTile extends StatelessWidget {
  final Map? data;
  const ChatPageListTile({this.data,super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minTileHeight: SC.from_width(80),

      contentPadding: EdgeInsets.symmetric(horizontal: 14),
      
      
      leading: SizedBox(
        height: SC.from_width(48),
        width: SC.from_width(48),
        child: Stack(
          children: [

            Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                
              ),
              child: Image.network(
                data?['image']??'',
                errorBuilder: (context, error, stackTrace) => Icon(Icons.person),
                fit: BoxFit.cover,),
            ),

            Positioned(
              bottom: 0,right: 0,
              child: Container(
                height: SC.from_width(14),
                width: SC.from_width(14),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.green,
                  border: Border.all(color: Colors.white,width: 2)
                ),
              ),
            )

          ],
        ),
      ),
      
      
      title: Row(
        children: [
          Text('${data?['name']??''}'),
          SizedBox(width: SC.from_width(8),),
          Image.asset("assets/icons/verIcon.png",width: SC.from_width(18),)
        ],
      ),

      subtitle: Text('${data?['lastMessage']??''}'),
      
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
        Text('${data?['lastMessageTime']??''}'),
        SizedBox(height: SC.from_width(15),),
        
        if(data?['unreadCount']>0)
          Container(

            padding: EdgeInsets.symmetric(horizontal: SC.from_width(8)),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100)

            ),
            child: Text('${data?['unreadCount']??''}',style: Const.font_700_16(context,size: SC.from_width(10),color: Colors.black),),
          )
      ],),
      
      leadingAndTrailingTextStyle: Const.poppins_600_14(context,size: SC.from_width(10),color: Color.fromRGBO(230, 230, 250, 1)),


      titleTextStyle: Const.font_900_20(context,size: SC.from_width(16)),
      subtitleTextStyle: Const.font_400_12(context,color: Color.fromRGBO(190, 190, 190, 1))?.copyWith(fontWeight: FontWeight.w700),


    );
  }
}
