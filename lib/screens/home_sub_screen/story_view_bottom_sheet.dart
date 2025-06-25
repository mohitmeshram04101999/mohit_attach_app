import 'package:attach/api/fake_db.dart';
import 'package:attach/componant/online_user_Image_widget.dart';
import 'package:attach/const/app_constante.dart';
import 'package:attach/modles/home_data_responce_model.dart';
import 'package:attach/myfile/screen_dimension.dart';
import 'package:attach/other/date_time_manager.dart';
import 'package:attach/providers/selfStoryProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';




class StoryViewBottomSheet extends StatelessWidget {
  final int? i;
  const StoryViewBottomSheet({this.i,super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Consumer<SelfStoryProvider>(
        builder: (context, p, child) => BottomSheet(
          clipBehavior: Clip.hardEdge,

          backgroundColor: Const.primeColor,
          enableDrag: true,

          onClosing: (){},
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6)
          ),
          builder: (context) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 14),
                height: SC.from_width(58),
                color: Const.primeColor,
                  child: Row(
                    children: [
                      Expanded(child: Text('View By ${p.story[i??0].seenCount}',style: Const.font_700_16(context,size: SC.from_width(18)),)),


                      //
                      PopupMenuButton(
                        color: Colors.white,
                        itemBuilder: (context) => [
                          PopupMenuItem(
                              onTap: () async{

                                await Provider.of<SelfStoryProvider>(context,listen: false).deleteStory(context, p.story[i??0].id??'');
                                Navigator.pop(context);
                              },
                              height: SC.from_width(10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Icons.delete,color: Colors.red,),
                                  SizedBox(width: SC.from_width(5),),
                                  Text("Remove",style: Const.font_400_12(context,color: Colors.black,size: SC.from_width(14)),)
                                ],
                              ))
                        ],)
                    ],
                  ),
              ),


              if((p.story[i??0].seen?.length??0)<4)...[
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for(SeenBy seenBy in p.story[i??0].seen??[])...[
                      ListTile(
                        tileColor: Const.scaffoldColor,
                        leading: SizedBox(
                            height: SC.from_width(38),
                            width: SC.from_width(38),
                            child: OnlineUserImageWidget(image:seenBy.userId?.image??'',online: false,)),
                        title: Text(seenBy.userId?.name??''),
                        subtitle: Text(DateTimeManager().timeAgo(seenBy.seenTime)),
                        trailing: (seenBy.like==true)?Icon(CupertinoIcons.heart_fill,color: Colors.red,):null,
                      ),
                    ]
                  ],
                )
                ]
              else...[
                Expanded(
                  child: ListView.builder(
                      itemCount: p.story[i??0].seen?.length??0,
                      shrinkWrap: true,
                      itemBuilder: (context,myIndex){
                        SeenBy seenBy  =  p.story[i??0].seen![myIndex];
                        return  ListTile(
                          tileColor: Const.scaffoldColor,
                          leading: SizedBox(
                              height: SC.from_width(38),
                              width: SC.from_width(38),
                              child: OnlineUserImageWidget(image:seenBy.userId?.image??'',online: false,)),
                          title: Text(seenBy.userId?.name??''),
                          subtitle: Text(DateTimeManager().timeAgo(seenBy.seenTime)),
                          trailing: (seenBy.like==true)?Icon(CupertinoIcons.heart_fill,color: Colors.red,):null,
                        );

                      }),
                )
              ]


            ],
          ),),
      ),
    );
  }
}
