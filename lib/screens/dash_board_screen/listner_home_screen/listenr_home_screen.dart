
import 'dart:developer';

import 'package:attach/api/authAPi.dart';
import 'package:attach/bd/bg_main.dart';
import 'package:attach/const/app_constante.dart';

import 'package:attach/myfile/myast%20dart%20file.dart';
import 'package:attach/myfile/screen_dimension.dart';
import 'package:attach/providers/call_kit_mennager.dart';

import 'package:attach/providers/home_provider_1.dart';
import 'package:attach/providers/profileProvider.dart';
import 'package:attach/providers/story_provider.dart';
import 'package:attach/screens/dash_board_screen/listner_home_screen/go_online_dilog.dart';
import 'package:attach/screens/dash_board_screen/listner_home_screen/kyc_screen.dart';

import 'package:attach/screens/home_sub_screen/notification_screen/notification_screen.dart';
import 'package:attach/screens/storyView/add_test_story_screen.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';

class ListnerHomeScreen extends StatefulWidget {
  const ListnerHomeScreen({super.key});

  @override
  State<ListnerHomeScreen> createState() => _ListnerHomeScreenState();
}

class _ListnerHomeScreenState extends State<ListnerHomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("this is init state and its calling get profile method");
    Provider.of<ProfileProvider>(context, listen: false).getProfile(context);
  }

  double progress = 0;
  bool isShow = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Scaffold(


            //appBar
            appBar: AppBar(
              centerTitle: false,
              title: Image.asset('assets/icons/home_icon/logo4-removebg-preview 1.png',width: SC.from_width(103),),

              actions: [
                // IconButton(onPressed: (){
                //   RoutTo(context, child:(p0, p1) =>  ListerFilterScreen());
                // }, icon:Image.asset('assets/icons/home_icon/uil_search.png',width: SC.from_width(21),) ),

                Consumer<HomeProvider>(
                  builder: (context, p, child) => AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      child: Stack(
                        children: [
                          Center(child: IconButton(onPressed: (){
                            RoutTo(context, child:(p0, p1) =>  NotificationScreen());
                          }, icon:Image.asset('assets/icons/home_icon/bell 1.png',width: SC.from_width(21),) )),
                          if(p.data?.notificationCount!=null&&p.data?.notificationCount!=0)
                            Positioned(
                                right: SC.from_width(12),
                                top: SC.from_width(12),
                                child: Container(
                                    alignment: Alignment.center,
                                    height: SC.from_width(15),
                                    width: SC.from_width(15),

                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.red
                                    ),
                                    child: Text("${(p.data?.notificationCount??0)<=99?p.data?.notificationCount:'+99'}",style: Const.font_900_20(context,size: SC.from_width(7)),)))
                        ],
                      ),
                    ),
                  ),
                ),
              ],

            ),


            //
            body: Consumer<ProfileProvider>(
              builder:
                  (context, p, child) => ListView(
                    physics: ClampingScrollPhysics(),
                    padding: EdgeInsets.symmetric(vertical: 20),
                    children: [




                      Consumer<HomeProvider>(builder: (context, home, child) {
                        if(home.data?.homeBanner==null){
                          return Container();
                        }
                        else if(home.data?.homeBanner?.length==0)
                          {
                            return Container();
                          }
                        return CarouselSlider(
                          items: [
                            for (int i = 0; i < (home.data?.homeBanner?.length??0); i++)
                              Container(
                                clipBehavior: Clip.hardEdge,
                                margin: EdgeInsets.symmetric(horizontal: 14),
                                decoration: BoxDecoration(
                                  // color: Colors.red,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Image.network(
                                  home.data?.homeBanner?[i]??'',
                                  height: SC.from_width(140),
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              )
                          ],
                          options: CarouselOptions(
                            height: SC.from_width(101),
                            viewportFraction: 1,
                          ),
                        );
                      }

                      ),


                      //
                      SizedBox(height: SC.from_width(18)),

                      if (p.user?.userVerified != true)
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 14),
                          color:
                          p.user?.kycStatus=='PENDING'?
                            Const.yellow.withOpacity(.5):
                          Color.fromRGBO(148, 38, 38, 0.5),
                          height: SC.from_width(66),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/icons/home_icon/warning.png",
                                width: SC.from_width(39),
                              ),
                              SizedBox(width: SC.from_width(5)),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "you are unverified${(kDebugMode)?'':''}",
                                      style: Const.font_700_16(context),
                                    ),
                                    Text(
                                      p.user?.kycStatus=='PENDING'?
                                          'Your KYC is under review':
                                      p.user?.kycStatus=='REJECTED'?
                                          'Your KYC is rejected':
                                      "Verify your profile to earn more",
                                      style: Const.font_400_12(
                                        context,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(
                                height: SC.from_width(35),
                                
                                
                                child: OutlinedButton(
                                  onPressed: () {
                                    if(p.user?.kycStatus=='PENDING')return;
                                    else
                                      {
                                        RoutTo(
                                          context,
                                          child: (p0, p1) => KycScreen(),
                                        );
                                      }


                                  },
                                  child: Text(
                                    (p.user?.kycStatus=='PENDING')?
                                        'Pending':
                                    "Get Verify",
                                    style: Const.font_700_16(
                                      context,
                                      size: SC.from_width(12),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                      SizedBox(height: SC.from_width(20)),

                      if(kDebugMode)
                        Text('${p.user?.online}'),

                      SizedBox(
                        height: SC.from_width(60),
                        child: Stack(
                          children: [
                            Padding(
                              padding:  EdgeInsets.only(right: SC.from_width(70)),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 14),
                                  child: Text(
                                    // (p.user?.name ?? '').split(" ").first,
                                    (p.user?.name ?? ''),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: Const.font_900_20(
                                      context,
                                      size: SC.from_width(28),
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            Positioned(
                              right: 14,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: SC.from_width(35),
                                    child: InkWell(
                                      onTap: () {
                                        p.goOnlineOrOffline(context);
                                      },
                                      child: AbsorbPointer(
                                        absorbing: true,
                                        child: Switch(
                                          padding: EdgeInsets.zero,

                                          activeTrackColor: Const.yellow,

                                          value: p.user?.online ?? false,
                                          onChanged: (d) {
                                            p.goOnlineOrOffline(context);
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    (p.user?.online == true)
                                        ? "Online"
                                        : "Offline",
                                    style: Const.font_400_12(
                                      context,
                                      color: Const.yellow,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: SC.from_width(20)),

                      //
                      SizedBox(
                        height: SC.from_width(80),
                        child: Card(
                          margin: EdgeInsets.symmetric(horizontal: 14),

                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: SC.from_width(28),
                                right: SC.from_width(19),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "₹ ${(p.user?.monthlyEstimatedEarning ?? 0).toInt()}",
                                          style: Const.font_900_20(
                                            context,
                                            size: SC.from_width(28),
                                          ),
                                        ),

                                        Text(
                                          "Estimated earning this month",
                                          style: Const.font_400_12(
                                            context,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Image.asset(
                                    "assets/icons/home_icon/cash bundel icon.png",
                                    width: SC.from_width(65),
                                  ),
                                ],
                              ),
                            ),

                            // child: ListTile(
                            //   contentPadding: EdgeInsets.only(
                            //     left: SC.from_width(28),
                            //     right: SC.from_width(19)
                            //   ),
                            //   minTileHeight: SC.from_width(90),
                            //
                            //   title: Text("₹ 5000"),
                            //
                            //   titleTextStyle: ,
                            //
                            //   subtitleTextStyle:,
                            //
                            //
                            //   subtitle: Text("Estimated earning this month"),
                            //
                            //
                            //   trailing: Container(
                            //     color: Colors.red,
                            //       child: Image.asset("assets/icons/home_icon/cash bundel icon.png",width: SC.from_width(65),)),
                            //
                            // ),
                          ),
                        ),
                      ),
                      SizedBox(height: SC.from_width(18)),

                      //
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 14),
                        height: SC.from_width(76),
                        child: Row(
                          children: [
                            Expanded(
                              child: Card(
                                margin: EdgeInsets.zero,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: SC.from_width(23),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "₹ ${(p.user?.todayEarning ?? 0).toInt()}",
                                        style: Const.font_900_28(
                                          context,
                                        )?.copyWith(height: 1),
                                        maxLines: 1,
                                      ),
                                      Text(
                                        "Today Earning",
                                        style: Const.font_400_12(
                                          context,
                                          size: SC.from_width(13),
                                          color: Color.fromRGBO(
                                            190,
                                            190,
                                            190,
                                            1,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: SC.from_width(14)),

                            Expanded(
                              child: Card(
                                margin: EdgeInsets.zero,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: SC.from_width(23),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          text:
                                              "${p.user?.listeningToday ?? 0}",
                                          style: Const.font_900_28(
                                            context,
                                          )?.copyWith(height: 1),
                                          children: [
                                            TextSpan(
                                              text: '',
                                              style: Const.font_900_28(
                                                context,
                                                size: SC.from_width(20),
                                                color: Color.fromRGBO(
                                                  190,
                                                  190,
                                                  190,
                                                  1,
                                                ),
                                              )?.copyWith(height: 1),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        "Listening Today",
                                        style: Const.font_400_12(
                                          context,
                                          size: SC.from_width(13),
                                          color: Color.fromRGBO(
                                            190,
                                            190,
                                            190,
                                            1,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: SC.from_width(58)),

                      // Center(
                      //   child: Text(
                      //     "Chat Call",
                      //     style: Const.font_500_16(context)?.copyWith(
                      //       decoration: TextDecoration.underline,
                      //       decorationColor: Const.yellow,
                      //       color: Const.yellow,
                      //     ),
                      //   ),
                      // ),
                      // SizedBox(height: SC.from_width(26)),

                      Center(
                        child: SizedBox(
                          height: SC.from_width(40),
                          width: SC.from_width(140),
                          child: OutlinedButton(
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) => GoOnlineDilog(),
                              );
                            },
                            style: ButtonStyle(
                              backgroundColor: WidgetStateColor.resolveWith(
                                (states) => Const.primeColor,
                              ),
                              padding: WidgetStateProperty.resolveWith(
                                (states) => EdgeInsets.symmetric(
                                  horizontal: SC.from_width(10),
                                  vertical: SC.from_width(10),
                                ),
                              ),
                            ),
                            child: Text("Availability"),
                          ),
                        ),
                      ),

                      SizedBox(height: SC.from_width(30)),
                    ],
                  ),
            ),


          ),



          if(isShow)
            InkWell(
              onTap: () {
                isShow = !isShow;
                setState(() {});
              },
              child: Container(

              ),
            ),

          //main floating button
          Consumer<StoryProvider>(
            builder:
                (context, p, child) => AnimatedPositioned(
                  curve: Interval(isShow ? 0:.3,isShow ? .6 : .9, curve: Curves.linear),


                  right: SC.from_width(14),
                  bottom: SC.from_width(isShow ? 135 :14),
                  // bottom: SC.from_width(isShow ? 195 :14),
                  duration: Duration(milliseconds: 500),
                  child: Consumer<HomeProvider>(
                    builder:
                        (context, p, child) => FloatingActionButton(
                          heroTag: 'floatingButton3',
                          backgroundColor: Colors.white,
                          // backgroundColor: Const.primeColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Image.asset(
                            "assets/newIcons/img_3.png",
                            width: SC.from_width(25),
                          ),

                          onPressed: (){
                            p.uploadStory(context,FileType.video);
                            isShow = !isShow;
                            setState(() {});
                          },
                        ),
                  ),
                ),
          ),

          Consumer<StoryProvider>(
            builder:
                (context, p, child) => AnimatedPositioned(
                  curve: Interval(.3, .6, curve: Curves.linear),
              right: SC.from_width(14),
                  bottom: SC.from_width(isShow ? 75 :14),
              // bottom: SC.from_width(isShow ? 135 :14),
              duration: Duration(milliseconds: 500),
              child: Consumer<HomeProvider>(
                builder:
                    (context, p, child) => FloatingActionButton(
                      heroTag: 'floatingButton2',
                  backgroundColor: Colors.white,
                  // backgroundColor: Const.primeColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Image.asset(
                    "assets/newIcons/img_4.png",
                    width: SC.from_width(30),
                  ),
                      onPressed: (){
                    p.uploadStory(context,FileType.image);
                    isShow = !isShow;
                    setState(() {});
                  },
                ),
              ),
            ),
          ),

          // Consumer<StoryProvider>(
          //   builder:
          //       (context, p, child) => AnimatedPositioned(
          //     curve: Interval(isShow? .6:0,isShow? .9:.3, curve: Curves.linear),
          //     right: SC.from_width(14),
          //     bottom: SC.from_width(isShow ? 75 :14),
          //     duration: Duration(milliseconds: 500),
          //     child: Consumer<HomeProvider>(
          //       builder:
          //           (context, p, child) => FloatingActionButton(
          //
          //             heroTag: 'floatingButton1',
          //
          //         backgroundColor: Colors.white,
          //         // backgroundColor: Const.primeColor,
          //         shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(14),
          //         ),
          //         child: Image.asset(
          //           "assets/newIcons/img_5.png",
          //           width: SC.from_width(30),
          //         ),
          //
          //         onPressed: (){
          //           isShow = !isShow;
          //           setState(() {});
          //           RoutTo(context, child: (p0, p1) => AddTestStoryScreen(),);
          //         },
          //       ),
          //     ),
          //   ),
          // ),

          Consumer<StoryProvider>(
            builder:
                (context, p, child) => AnimatedPositioned(
              right: SC.from_width(14),
              bottom: SC.from_width(14),
              duration: Duration(milliseconds: 100),
              child: Consumer<HomeProvider>(
                builder:
                    (context, p, child) => FloatingActionButton(
                      heroTag: 'floatingButton',
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Image.asset(
                    "assets/icons/floading_add.png",
                    width: SC.from_width(30),
                  ),



                  onPressed: () async {

                        log(DateTime.now().toIso8601String());

                        isShow = !isShow;
                    setState(() {});

                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
