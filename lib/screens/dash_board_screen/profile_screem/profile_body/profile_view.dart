import 'package:attach/componant/custom_star_ratting.dart';
import 'package:attach/componant/profile_aVTAR.dart';
import 'package:attach/const/app_constante.dart';
import 'package:attach/modles/home_data_responce_model.dart';
import 'package:attach/modles/otp_responce.dart';
import 'package:attach/modles/usertype.dart';
import 'package:attach/myfile/myast%20dart%20file.dart';
import 'package:attach/myfile/screen_dimension.dart';
import 'package:attach/providers/profileProvider.dart';
import 'package:attach/providers/selfStoryProvider.dart';
import 'package:attach/screens/storyView/self_story_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatelessWidget {
  final Map? data;
  final User? listener;
  final String heroTag;
  const ProfileView({this.heroTag='',this.listener,this.data,super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

      Hero(
        tag: heroTag,
          child: ProfileAvtar(image: listener?.image??'',imageType: ImageType.network,
          gender: listener?.gender,)
      ),
      SizedBox(width: SC.from_width(18),),

      Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
        
            //
            Row(
              children: [
                Flexible(child: Text(listener?.name??'',maxLines: 1,overflow: TextOverflow.ellipsis,style: Const.font_700_16(context,size: SC.from_width(20)),)),
                SizedBox(width: SC.from_width(5),),
                if(listener?.userVerified??false)
                  Image.asset("assets/icons/verIcon.png",width: SC.from_width(14),),

              ],
            ),
            SizedBox(height: SC.from_width(10),),
            Row(
              children: [
                Expanded(child: Text("${listener?.count??0}",style: Const.font_400_12(context,size: SC.from_width(16)),)),
                  Expanded(
                    flex: 2,
                      child: Text("Rating",style: Const.font_400_12(context,size: SC.from_width(14)),)),
              ],
            ),
            SizedBox(height: SC.from_width(4),),

            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: Text("Followers",style: Const.font_400_12(context,size: SC.from_width(14)),)),

                Expanded(
                    flex: 2,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        CustomStarRatting(
                          ratting: (listener?.rating??0).toInt(),
                        ),
                        SizedBox(width: SC.from_width(8),),
                        Text("${listener?.countOfRating??0}",style: Const.font_500_12(context,color: Color.fromRGBO(190, 190, 190, 1)),)

                      ],)
                ),
              ],)
            
        
          ],
        ),
      ),



    ],);
  }
}




class SelfProfileView extends StatelessWidget {
  final bool listner;
  const SelfProfileView({this.listner=true,super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(

      builder: (context, p, child) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Consumer<SelfStoryProvider>(
            builder: (context, story, child) =>
                Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:(story.story.length>0)?Const.yellow:null,
                ),
                child: GestureDetector(
                  onTap: (story.story.length==0)?null:(){
                    RoutTo(context, child: (p0, p1) => SelfStoryViewPage(),);
                  },
                    child: ProfileAvtar(image: p.user?.image??'',imageType: ImageType.network,))),
          ),
          SizedBox(width: SC.from_width(18),),

          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                //
                Row(
                  children: [
                    Flexible(child: Text("${p.user?.name??''}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Const.font_700_16(context,size: SC.from_width(20)),)),
                    SizedBox(width: SC.from_width(5),),
                    if(p.user?.userVerified==true)
                      Image.asset("assets/icons/verIcon.png",width:  SC.from_width(14),),
                  ],
                ),
                SizedBox(height: SC.from_width(10),),
                Row(
                  children: [
                    Expanded(child: Text("${p.user?.count??0}",style: Const.font_400_12(context,size: SC.from_width(16)),)),
                    if(p.user?.userType==UserType.listener)
                      Expanded(
                          flex: 2,
                          child: Text("Rating",style: Const.font_400_12(context,size: SC.from_width(14)),)),
                  ],
                ),
                SizedBox(height: SC.from_width(4),),


                if(p.user?.userType==UserType.listener)...[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          child: Text("Followers",style: Const.font_400_12(context,size: SC.from_width(14)),)),

                      Expanded(
                          flex: 2,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              CustomStarRatting(

                                ratting: (p.user?.rating??0).toInt(),

                              ),
                              SizedBox(width: SC.from_width(8),),
                              Center(child: Text("3.0 (2K+)",style: Const.font_500_12(context,color: Color.fromRGBO(190, 190, 190, 1)),))

                            ],)
                      ),
                    ],)

                ]
                else...[
                  Text("Following",style: Const.font_400_12(context,size: SC.from_width(14)),),
                ],

                if(kDebugMode)
                  SelectableText(p.user?.id??'',style: Const.font_400_12(context,size: SC.from_width(14)),),


              ],
            ),
          ),



        ],),
    );
  }
}