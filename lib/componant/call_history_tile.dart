import 'dart:async';

import 'package:attach/const/app_constante.dart';
import 'package:attach/myfile/screen_dimension.dart';
import 'package:attach/providers/audioCallProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CallHistoryTile extends StatelessWidget {
  final Map? data;
  const CallHistoryTile({this.data,super.key});

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

      subtitle: Padding(
        padding: EdgeInsets.only(top: SC.from_width(6)),

        child: Row(
          children: [
            Image.asset(
              data?['direction']=='incoming'?
              "assets/icons/inboxpageicons/incomming.png":
              'assets/icons/inboxpageicons/outgoing.png',
              width: SC.from_width(17),
              color: data?['status']=='completed'?
                  Colors.green:Colors.red,
            ),
            SizedBox(width: SC.from_width(8),),

            Text('${data?['time']??''}'),
          ],
        ),
      ),

      trailing:Consumer<AudioCallProvider>(
        builder: (context, p, child) => IconButton(onPressed: (){
          if(data?['callType']=='video')
            {
              p.requestNotification();
            }
          else
            {
              Timer(Duration(seconds: 3),(){
                print("asfd");
                p.receiveCall();
              });
            }
        }, icon: Image.asset(
          data?['callType']=='video'?
          'assets/icons/inboxpageicons/vid.png':
          'assets/icons/inboxpageicons/aud.png',
          width: SC.from_width(20),
        )),
      ),





      titleTextStyle: Const.font_900_20(context,size: SC.from_width(16)),
      subtitleTextStyle: Const.font_400_12(context,color: Color.fromRGBO(190, 190, 190, 1)),


    );
  }
}
