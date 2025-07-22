

import 'package:attach/api/local_db.dart';
import 'package:attach/api/storyApi.dart';
import 'package:attach/componant/online_user_Image_widget.dart';
import 'package:attach/componant/show_self_story_widget.dart';
import 'package:attach/componant/storyProgress.dart';
import 'package:attach/const/app_constante.dart';
import 'package:attach/modles/home_data_responce_model.dart';
import 'package:attach/myfile/screen_dimension.dart';
import 'package:attach/other/date_time_manager.dart';
import 'package:attach/providers/profileProvider.dart';
import 'package:attach/providers/selfStoryProvider.dart';
import 'package:attach/providers/story_provider.dart';
import 'package:attach/screens/home_sub_screen/story_view_bottom_sheet.dart';
import 'package:attach/screens/storyView/ShowStoryWidget.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import 'package:provider/provider.dart';

class SelfStoryViewPage extends StatefulWidget {
  const SelfStoryViewPage({super.key});

  @override
  State<SelfStoryViewPage> createState() => _SelfStoryViewPageState();
}

class _SelfStoryViewPageState extends State<SelfStoryViewPage> {


  int pad =0;
  final PageController  controller = PageController();

  @override
  void initState() {
    // TODO: implement initState`1
    super.initState();
    Provider.of<SelfStoryProvider>(context,listen: false).updatePageController(context,controller);
  }

  bool _isVideoLode =false;
  Duration _duration = Duration(seconds: 10);




  @override
  Widget build(BuildContext context) {



    return Consumer<SelfStoryProvider>(
      builder: (context, p, child) =>  WillPopScope(
        onWillPop: ()async{
          p.clear();
          return true;
        },
        child: SafeArea(
          child: Scaffold(


            // floatingActionButton: kDebugMode?FloatingActionButton(onPressed: (){
            //   p.changePage(context);
            // }):null,


            body: Column(
              children: [

                Row(
                  children: [
                    for(var s in p.story)
                      Expanded(
                          child:
              ((s.mediaType!="VIDEO"||(s.mediaType=='VIDEO' && _isVideoLode))&&s.id==p.story[p.storyIndex].id)
                  ?StoryProgressBar(duration: _duration)
                          :Container(
                            margin: EdgeInsets.symmetric(horizontal: 2,vertical: 3),
                            height: 2,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade500,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          )
                      ),
                  ],
                ),



                //show self prfile
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: SC.from_width(14)),
                  child: Row(children: [
                    Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: Colors.white,
                              width: 2
                          )
                      ),
                      height: SC.from_width(36),
                      width: SC.from_width(36),
                      child: OnlineUserImageWidget(image: DB.curruntUser?.image??'',online: false,asset: false,),),
                    SizedBox(width: SC.from_width(10),),
                    Expanded(
                      child: Consumer<ProfileProvider>(
                        builder: (context, prof, child) =>  Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('My Story',style: Const.font_700_16(context),),
                                SizedBox(width: SC.from_width(5),),
                                if(prof.user?.userVerified==true)
                                  Image.asset("assets/icons/verIcon.png",width: SC.from_width(13),),
                              ],
                            ),
                            Text(DateTimeManager().formatTime12Hour(p.story[pad].createdAt)??'',style: Const.font_900_20(context,size: SC.from_width(10),color: Colors.grey),)
                          ],),
                      ),
                    ),
                    PopupMenuButton(
                      color: Colors.white,
                      itemBuilder: (context) => [
                      PopupMenuItem(
                        onTap: (){
                          Provider.of<SelfStoryProvider>(context,listen: false).deleteStory(context, p.story[pad].id??'');
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

                  ],),
                ),
                SizedBox(height: SC.from_width(10),),

                // this is story
                Expanded(child:
                PageView(
                  controller: controller,
                  onPageChanged: (d){
                    _duration = Duration(seconds: 10);
                    print(d);
                    _isVideoLode = false;
                    pad  = d;
                    p.updateIndex(d);
                    p.resatTimer(context);
                    setState(() {});
                  },
                  children: [
                    for(SelfStoryModel s in p.story)
                      ShowStoryWidgetForSelf(
                        key: ValueKey(s.id),
                        story: s,isVideo: s.mediaType=="VIDEO",
                        onVideoStart: (d){
                          _duration = d;
                          _isVideoLode = true;
                          setState(() {

                          });
                        },
                      )

                  ],
                )),

                Container(
                  height: SC.from_width(80),

                  color: Const.scaffoldColor,
                  padding: EdgeInsets.symmetric(vertical: SC.from_width(20),horizontal: 14),
                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(onPressed: ()async{
                     if((p.story[pad].seenCount??0)>0)
                       {
                         p.stopTimer();
                         await showModalBottomSheet(
                           backgroundColor: Colors.transparent,
                           context: context, builder: (context) =>
                             StoryViewBottomSheet(i: pad,),
                         );
                         p.startAgainTimer(context);
                       }
                      }, icon: Image.asset("assets/icons/eyeButtone.png",width: SC.from_width(29),)),
                      Text("${p.story[pad].seenCount}",style: Const.font_400_16(context),)
                    ],
                  ),
                ),

              ],
            ),












            floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,


          ),
        ),
      ),
    );
  }
}