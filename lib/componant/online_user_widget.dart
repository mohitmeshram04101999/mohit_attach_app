import 'package:attach/componant/circule_button.dart';
import 'package:attach/componant/custom_star_ratting.dart';

import 'package:attach/const/app_constante.dart';
import 'package:attach/dialog/contect_request_dialog.dart';
import 'package:attach/modles/home_data_responce_model.dart';
import 'package:attach/modles/otp_responce.dart';
import 'package:attach/modles/usertype.dart';
import 'package:attach/myfile/animated%20dilog.dart';
import 'package:attach/myfile/myast%20dart%20file.dart';
import 'package:attach/myfile/screen_dimension.dart';
import 'package:attach/providers/audio%20call%20provider.dart';
import 'package:attach/providers/chatProvider.dart';
import 'package:attach/providers/home_provider_1.dart';
import 'package:attach/providers/videoCallProvider.dart';
import 'package:attach/screens/dash_board_screen/inbox/chat_screen.dart';
import 'package:attach/screens/home_sub_screen/listner_profile_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';




class OnlineUserWidget extends StatelessWidget {
  final Map? data;
  final HomeListener? listener;
  final void Function()? onFollow;
  const OnlineUserWidget({required this.onFollow,this.listener,this.data,super.key});

  @override
  Widget build(BuildContext context) {


    //
    return Padding(
      padding: EdgeInsets.symmetric(vertical: SC.from_width(10)),
      child: Container(



        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius:BorderRadius.circular(12),
          border: Border.all(color: Const.yellow)
        ),


        child: InkWell(
          splashColor: Const.primeColor,
          borderRadius:BorderRadius.circular(12),

          child: Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [



                //Profile
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [




                    //profile image
                    SizedBox(
                      height: SC.from_width(56),
                      width: SC.from_width(56),
                      child: Stack(
                        children: [

                          Hero(
                            tag:listener?.id??'',
                            child: GestureDetector(
                              onTap: (){
                                RoutTo(context, child: (p0, p1) => ListenerProfileDetailScreen(data: data,id: listener?.id??'',),);
                              },
                              child: Container(
                                height: double.infinity,
                                width: double.infinity,
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                  color: Const.primeColor,
                                  shape: BoxShape.circle,
                                ),
                                child: Image.network("${listener?.image}",fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) => Image.asset(
                                    (listener?.gender==UserGander.female)?
                                      'assets/avtars/femaleFix.jpg':
                                    'assets/avtars/maleFix.jpg',fit: BoxFit.cover,),
                                ),
                              ),
                            ),
                          ),



                          if(listener?.online==true)
                            Positioned(
                              bottom: 0,right: 0,
                              child: Container(
                                height: SC.from_width(16),
                                width: SC.from_width(16),
                                decoration: BoxDecoration(
                                    color: (listener?.isBusy==true)?Colors.orange: Colors.green,
                                    shape: BoxShape.circle,
                                    border:Border.all(
                                        color: Colors.white,width: 2)
                                ),
                              ),
                            ),



                        ],

                      ),
                    ),
                    SizedBox(width: SC.from_width(10),),


                    //
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [

                        // name Row
                        Row(
                          children: [



                            Expanded(child: Row(
                              children: [
                                Flexible(child: Text(listener?.name??'',overflow: TextOverflow.ellipsis ,style: Const.font_900_20(context),maxLines: 1,)),
                                SizedBox(width: SC.from_width(0),),
                                if(listener?.userVerified??false)
                                  Image.asset("assets/icons/verIcon.png",width: SC.from_width(24),),
                              ],
                            )),
                            SizedBox(width: SC.from_width(10),),

                            GestureDetector(
                              onTap:onFollow,
                              child: (listener?.isFollowing==true)?
                              Text("Following",style: Const.font_500_16(context),):
                              Text("Follow",style: Const.font_500_16(context,color: Colors.blue),),
                            )
                          ],
                        ),
                          SizedBox(height: SC.from_width(2),),


                          // age row
                          Row(
                            children: [


                              Text("${(listener?.gender??'').capitalizeFirst} : ${listener?.age??'0'} Yrs",style: Const.font_500_14(context),),
                              Spacer(),
                              CustomStarRatting(
                                ratting: (listener?.rating??0).toInt(),
                              ),
                            ],
                          ),
                          SizedBox(height: SC.from_width(2),),



                          //
                          Row(
                            children: [


                              Text("Experience : ${listener?.experience??'0'}",style: Const.font_400_12(context),),

                              Spacer(),
                              Text("${listener?.countOfRating??'0'}",style: Const.font_500_16(context,size: SC.from_width(12),color: Color.fromRGBO(190, 190, 190, 1)),),
                            ],
                          ),



                      ],),
                    )

                  ],
                ),
                SizedBox(height: SC.from_width(10),),


                //Disc
                Text("${listener?.bio??''}",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Const.font_400_12(context,size: SC.from_width(14),color: Color.fromRGBO(190, 190, 190, 1)),
                ),
                SizedBox(height: SC.from_width(10),),


                Row(
                  children: [
                    Expanded(child: SizedBox()),

                    Expanded(
                      child: (listener?.isBusy==true&&listener?.online==true)?Align(
                        alignment: Alignment.centerRight,
                        child: CirclButton(
                          onTap: ()async{
                            OpenDailogWithAnimation(context, dailog: (animation, secondryAnimation) => 
                            ContactRequestDialog(user: User.fromJson(listener?.toJson()??{})));
                          },
                          // icon: Center(child: Image.asset('assets/icons/onlinwidgetIcons/mi_call (1).png',width: SC.from_width(22), ),),
                          icon: Center(child:Icon(Icons.notifications_outlined),),
                        ),
                      ):Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          CirclButton(
                            onTap: () async{
                               await Provider.of<ChatProvider>(context,listen: false).createThread(context,listener?.id??'');
                            },
                            icon: Stack(
                              children: [
                                Positioned(
                                  bottom: SC.from_width(-.5),
                                    right: SC.from_width(-.5),
                                    child: Center(child: Image.asset('assets/icons/onlinwidgetIcons/lets-icons_chat.png',width: SC.from_width(22), ))),
                              ],
                            ),
                          ),


                          CirclButton(
                            onTap: ()async{
                              await Provider.of<AudioCallProvider>(context,listen: false).createThread(context,User.fromJson(listener?.toJson()??{}));

                            },
                            icon: Center(child: Image.asset('assets/icons/onlinwidgetIcons/mi_call (1).png',width: SC.from_width(22), ),),
                          ),

                          CirclButton(
                            onTap: ()async{
                               await Provider.of<VideoCallProvider>(context,listen: false).createThread(context,User.fromJson(listener?.toJson()??{}));
                            },
                            active: listener?.setAvailability?.videoCall??false,
                            icon: Center(child: Image.asset('assets/icons/onlinwidgetIcons/tabler_video (1).png',width: SC.from_width(22), ),),
                          ),







                        ],
                      ),
                    ),
                  ],
                )


              ],
            ),
          ),
        ),

        //



      ),
    );



  }
}
