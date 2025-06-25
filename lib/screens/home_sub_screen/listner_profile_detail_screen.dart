import 'package:attach/componant/custome_shimmer.dart';
import 'package:attach/const/app_constante.dart';
import 'package:attach/modles/home_data_responce_model.dart';
import 'package:attach/myfile/action%20Button.dart';
import 'package:attach/myfile/screen_dimension.dart';
import 'package:attach/providers/audio%20call%20provider.dart';
import 'package:attach/providers/chatProvider.dart';
import 'package:attach/providers/listner_profile_detail_provider.dart';
import 'package:attach/providers/videoCallProvider.dart';
import 'package:attach/screens/dash_board_screen/profile_screem/profile_body/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ListenerProfileDetailScreen extends StatefulWidget {
  final Map? data;
  final HomeListener? listener;
  const ListenerProfileDetailScreen({this.listener, this.data, super.key});

  @override
  State<ListenerProfileDetailScreen> createState() =>
      _ListenerProfileDetailScreenState();
}

class _ListenerProfileDetailScreenState
    extends State<ListenerProfileDetailScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ListenerProfileDetailProvider>(
      context,
      listen: false,
    ).getDetail(context, widget.listener?.id ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ListenerProfileDetailProvider>(
      builder:
          (context, p, child) => WillPopScope(
            onWillPop: () async {
              p.clear();
              return true;
            },
            child: Scaffold(
              appBar: AppBar(
                actions: [
                  //
                  if (p.detail?.setAvailability?.videoCall ?? false)
                    IconButton(
                      onPressed: () {
                        Provider.of<VideoCallProvider>(
                          context,
                          listen: false,
                        ).createThread(context, p.detail!);
                      },
                      icon: Image.asset(
                        "assets/icons/inboxpageicons/vid.png",
                        width: SC.from_width(30),
                      ),
                    ),
                  SizedBox(width: SC.from_width(10)),

                  ///
                  if (p.detail?.setAvailability?.audioCall ?? false)
                    IconButton(
                      onPressed: () {
                        Provider.of<AudioCallProvider>(
                          context,
                          listen: false,
                        ).createThread(context, p.detail!);
                      },
                      icon: Image.asset(
                        "assets/icons/inboxpageicons/aud.png",
                        width: SC.from_width(25),
                      ),
                    ),
                  SizedBox(width: SC.from_width(5)),
                  // IconButton(onPressed: (){}, icon: Icon(Icons.more_vert,size: SC.from_width(30),)) ,
                ],
              ),

              body: ListView(
                padding: EdgeInsets.symmetric(horizontal: 14),
                children: [
                  ProfileView(data: widget.data, listener: widget.listener),

                  SizedBox(height: SC.from_width(17)),

                  //Follow Section
                  CustomShimmer(
                    loading: p.loading,
                    child: Container(
                      // color: Colors.red,
                      child: Column(
                        children: [
                          SizedBox(
                            height: SC.from_width(40),
                            child: Row(
                              children: [
                                Expanded(
                                  child: MyactionButton(
                                    action: () async {
                                      await p.followUser(context);
                                    },

                                    loadingWidget: Center(
                                      child: SizedBox(
                                        height: SC.from_width(25),
                                        width: SC.from_width(25),
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 3,
                                        ),
                                      ),
                                    ),
                                    height: SC.from_width(45),

                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color:
                                          p.detail?.isFollowing == true
                                              ? null
                                              : Const.yellow,
                                      border: Border.all(
                                        color: Const.yellow,
                                        width: 2,
                                      ),
                                    ),

                                    activeDecoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color:
                                          p.detail?.isFollowing == true
                                              ? null
                                              : Const.yellow,
                                      border: Border.all(
                                        color: Const.yellow,
                                        width: 2,
                                      ),
                                    ),

                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          (p.detail?.isFollowing == true)
                                              ? "assets/icons/follow.png"
                                              : "assets/icons/addFollow.png",
                                          width: SC.from_width(22),
                                        ),
                                        SizedBox(width: SC.from_width(10)),
                                        Text(
                                          p.detail?.isFollowing == true
                                              ? 'Following'
                                              : 'Follow',
                                          style: Const.font_700_14(context),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                SizedBox(width: SC.from_width(10)),

                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      Provider.of<ChatProvider>(
                                        context,
                                        listen: false,
                                      ).createThread(
                                        context,
                                        p.detail?.id ?? '',
                                      );
                                    },
                                    child: Container(
                                      height: SC.from_width(45),

                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Color.fromRGBO(58, 61, 64, 1),
                                        border: Border.all(
                                          color: Color.fromRGBO(58, 61, 64, 1),
                                          width: 2,
                                        ),
                                      ),

                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            'assets/icons/smilechat.png',
                                            width: SC.from_width(22),
                                          ),
                                          SizedBox(width: SC.from_width(10)),
                                          Text(
                                            "Chat",
                                            style: Const.font_700_14(context),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),

                                //
                                SizedBox(width: SC.from_width(11)),

                                //
                                AspectRatio(
                                  aspectRatio: 1,
                                  child: SizedBox(
                                    height: SC.from_width(45),
                                    // width: SC.from_width(45),
                                    child: Card(
                                      clipBehavior: Clip.hardEdge,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      margin: EdgeInsets.zero,

                                      child: InkWell(
                                        onTap: () async {
                                          p.updateBell(context);
                                        },
                                        child: Center(
                                          child: Image.asset(
                                            p.detail?.isBellOn == true
                                                ? "assets/icons/active_notification.png"
                                                : "assets/icons/notification.png",
                                            width: SC.from_width(18),
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: SC.from_width(15)),

                          Align(
                            alignment: Alignment.centerLeft,
                            child: Wrap(
                              spacing: 0,
                              alignment: WrapAlignment.start,
                              children: [
                                Image.asset(
                                  "assets/icons/home_icon/solar_user-speak-bold.png",
                                  width: SC.from_width(18),
                                ),
                                SizedBox(width: SC.from_width(5)),
                                Text(
                                  "Languages : ",
                                  style: Const.font_700_14(context),
                                ),

                                for (var l in p.detail?.languages ?? [])
                                  Text(
                                    "${l.name}${p.detail?.languages?.last.id == l.id ? " " : ", "}",
                                    style: Const.font_400_14(context),
                                  ),
                              ],
                            ),
                          ),
                          SizedBox(height: SC.from_width(15)),

                          Align(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                Image.asset(
                                  "assets/icons/gender.png",
                                  width: SC.from_width(18),
                                ),
                                SizedBox(width: SC.from_width(5)),

                                //
                                Flexible(
                                  child: RichText(
                                    text: TextSpan(
                                      style: Const.font_700_14(
                                        context,
                                      ), // Default style
                                      children: [
                                        TextSpan(text: 'Gender : '),
                                        TextSpan(
                                          text:
                                              '${(p.detail?.gender ?? '').capitalizeFirst} ',
                                          style: Const.font_400_14(context),
                                        ),
                                        TextSpan(
                                          text: '${p.detail?.age ?? 0} Yr',
                                          style: Const.font_400_14(context),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: SC.from_width(11)),

                          // SizedBox(
                          //   height: SC.from_width(45),
                          //
                          //   child: Row(
                          //     children: [
                          //       Expanded(
                          //         child: SizedBox(
                          //           height: double.infinity,
                          //           width: double.infinity,
                          //           child: Card(
                          //             margin: EdgeInsets.zero,
                          //             child: Padding(
                          //               padding: EdgeInsets.symmetric(
                          //                 vertical: SC.from_width(0),
                          //               ),
                          //               child: Row(
                          //                 mainAxisAlignment:
                          //                     MainAxisAlignment.center,
                          //                 children: [
                          //                   Flexible(
                          //                     child: Text(
                          //                       p.detail?.languages?.isEmpty ==
                          //                               true
                          //                           ? ""
                          //                           : p
                          //                                   .detail
                          //                                   ?.languages?[0]
                          //                                   .name ??
                          //                               '',
                          //                       style: Const.font_700_14(
                          //                         context,
                          //                       ),
                          //                       maxLines: 1,
                          //                     ),
                          //                   ),
                          //                   SizedBox(width: SC.from_width(10)),
                          //                   Image.asset(
                          //                     "assets/icons/land.png",
                          //                     width: SC.from_width(25),
                          //                   ),
                          //                 ],
                          //               ),
                          //             ),
                          //           ),
                          //         ),
                          //       ),
                          //       SizedBox(width: SC.from_width(10)),
                          //
                          //       Expanded(
                          //         child: SizedBox(
                          //           height: double.infinity,
                          //           child: Card(
                          //             margin: EdgeInsets.zero,
                          //             child: Padding(
                          //               padding: EdgeInsets.symmetric(
                          //                 vertical: SC.from_width(0),
                          //               ),
                          //               child: Row(
                          //                 mainAxisAlignment:
                          //                     MainAxisAlignment.center,
                          //                 children: [
                          //                   Text(
                          //                     "${(p.detail?.gender ?? '').capitalizeFirst} ${p.detail?.age ?? '0'} Yr",
                          //                     style: Const.font_700_14(context),
                          //                   ),
                          //                   SizedBox(width: SC.from_width(10)),
                          //                   Image.asset(
                          //                     "assets/icons/gender.png",
                          //                     width: SC.from_width(25),
                          //                   ),
                          //                 ],
                          //               ),
                          //             ),
                          //           ),
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: SC.from_width(20)),

                  CustomShimmer(
                    loading: p.loading,
                    child: Text(
                      "${p.detail?.bio ?? ''}",
                      style: Const.font_400_14(context),
                    ),
                  ),
                  SizedBox(height: SC.from_width(20)),
                ],
              ),
            ),
          ),
    );
  }
}
