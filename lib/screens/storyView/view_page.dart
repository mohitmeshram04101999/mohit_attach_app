import 'package:attach/componant/circule_button.dart';
import 'package:attach/componant/online_user_Image_widget.dart';
import 'package:attach/componant/storyProgress.dart';
import 'package:attach/const/app_constante.dart';
import 'package:attach/modles/home_data_responce_model.dart';
import 'package:attach/modles/otp_responce.dart';
import 'package:attach/myfile/screen_dimension.dart';
import 'package:attach/other/date_time_manager.dart';
import 'package:attach/providers/audio%20call%20provider.dart';
import 'package:attach/providers/chatProvider.dart';
import 'package:attach/providers/story_provider.dart';
import 'package:attach/providers/videoCallProvider.dart';
import 'package:attach/screens/home_sub_screen/story_view_bottom_sheet.dart';
import 'package:attach/screens/storyView/ShowStoryWidget.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class StoryViewPage extends StatefulWidget {
  final Map? data;
  final String? storyId;
  final bool self;
  const StoryViewPage({
    this.storyId,
    this.self = false,
    required this.data,
    super.key,
  });

  @override
  State<StoryViewPage> createState() => _StoryViewPageState();
}

class _StoryViewPageState extends State<StoryViewPage> {
  late final pad;

  @override
  void initState() {
    // TODO: implement initState`1
    super.initState();

    var p = Provider.of<StoryProvider>(context, listen: false);
    var indext = p.story.indexWhere(
      (element) => element.listener?.id == widget.storyId,
    );
    p.setUser(context, curruntUserIndex: indext);
  }

  bool _isVideoLoad = false;
  Duration? _duration;


  @override
  Widget build(BuildContext context) {
    return Consumer<StoryProvider>(
      builder:
          (context, p, child) => WillPopScope(
            onWillPop: () async {
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
                    Expanded(
                      child: PageView(
                        controller: p.userPageController,
                        onPageChanged: (d) {
                          p.updateCurruntUser(context, d);
                          p.update();
                        },
                        children: List.generate(
                          p.story.length,
                          (i) => Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 10,
                                ),
                                child: Row(
                                  children: [
                                    for (Story d in p.story[i].stories ?? [])
                                      Expanded(
                                        child:
                                            (d.id == p.getCurruntStory()?.id)
                                                ? (d.mediaType == "VIDEO")
                                                    ? (_isVideoLoad)
                                                        ? StoryProgressBar(
                                                          duration:
                                                              _duration!,
                                                        )
                                                        : Container(
                                              margin:
                                              const EdgeInsets.symmetric(
                                                horizontal: 2,
                                              ),
                                              height: SC.from_width(2),
                                              decoration: BoxDecoration(
                                                // color: (d.id==p.getCurruntStory()?.id)?Colors.white:Colors.grey,
                                                color:
                                                (d.seen ?? false)
                                                    ? Colors.white
                                                    : Colors.grey,
                                                borderRadius:
                                                BorderRadius.circular(
                                                  2,
                                                ),
                                              ),
                                            )
                                                    : StoryProgressBar(
                                                      duration: p.timerDuration,
                                                    )
                                                : Container(
                                                  margin:
                                                      const EdgeInsets.symmetric(
                                                        horizontal: 2,
                                                      ),
                                                  height: SC.from_width(2),
                                                  decoration: BoxDecoration(
                                                    // color: (d.id==p.getCurruntStory()?.id)?Colors.white:Colors.grey,
                                                    color:
                                                        (d.seen ?? false)
                                                            ? Colors.white
                                                            : Colors.grey,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          2,
                                                        ),
                                                  ),
                                                ),
                                      ),
                                  ],
                                ),
                              ),

                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: SC.from_width(14),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 2,
                                        ),
                                      ),
                                      height: SC.from_width(36),
                                      width: SC.from_width(36),
                                      child: OnlineUserImageWidget(
                                        image: p.story[i].listener?.image ?? '',
                                        online: false,
                                        asset: false,
                                      ),
                                    ),
                                    SizedBox(width: SC.from_width(10)),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                p.story[i].listener?.name ?? '',
                                                style: Const.font_700_16(
                                                  context,
                                                ),
                                              ),
                                              SizedBox(width: SC.from_width(5)),
                                              Image.asset(
                                                "assets/icons/verIcon.png",
                                                width: SC.from_width(13),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            DateTimeManager().formatTime12Hour(
                                              p
                                                  .getCurruntStory()
                                                  ?.createdAt
                                                  ?.add(Duration(minutes: 330)),
                                            ),
                                            style: Const.font_900_20(
                                              context,
                                              size: SC.from_width(10),
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    // Icon(Icons.more_vert)
                                  ],
                                ),
                              ),

                              Expanded(
                                child: PageView(
                                  controller: p.storyPageController,

                                  physics: NeverScrollableScrollPhysics(),
                                  onPageChanged: (d) {
                                    _isVideoLoad = false;
                                    _duration = null;
                                    print(d);
                                    p.updateCurruntStoryIndex(context, d);
                                    p.update();
                                  },
                                  children: [
                                    for (Story st in p.story[i].stories ?? [])
                                      ShowStoryWidget(
                                        story: st,
                                        isVideo: st.mediaType == 'VIDEO',
                                        onVideoStart: (d){
                                          _isVideoLoad = true;
                                          _duration = d;
                                          setState(() {
                                          });
                                        },
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    Container(
                      height: SC.from_width(80),

                      color: Const.scaffoldColor,
                      padding: EdgeInsets.symmetric(
                        vertical: SC.from_width(20),
                        horizontal: 14,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (widget.self)
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    showModalBottomSheet(
                                      backgroundColor: Colors.transparent,
                                      context: context,
                                      builder:
                                          (context) => StoryViewBottomSheet(),
                                    );
                                  },
                                  icon: Image.asset(
                                    "assets/icons/eyeButtone.png",
                                    width: SC.from_width(29),
                                  ),
                                ),
                                Text("23", style: Const.font_400_16(context)),
                              ],
                            ),

                          if (!widget.self)
                            Expanded(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(width: SC.from_width(100)),

                                  CirclButton(
                                    active:
                                        p
                                            .story[p.curruntUserIndex]
                                            .listener
                                            ?.setAvailability
                                            ?.chat ??
                                        false,
                                    onTap: () async {
                                      await Provider.of<ChatProvider>(
                                        context,
                                        listen: false,
                                      ).createThread(
                                        context,
                                        p
                                                .story[p.curruntUserIndex]
                                                .listener
                                                ?.id ??
                                            '',
                                      );
                                    },
                                    icon: Stack(
                                      children: [
                                        Positioned(
                                          bottom: SC.from_width(-.5),
                                          right: SC.from_width(-.5),
                                          child: Center(
                                            child: Image.asset(
                                              'assets/icons/onlinwidgetIcons/lets-icons_chat.png',
                                              width: SC.from_width(22),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  CirclButton(
                                    active:
                                        p
                                            .story[p.curruntUserIndex]
                                            .listener
                                            ?.setAvailability
                                            ?.audioCall ??
                                        false,
                                    onTap: () async {
                                      await Provider.of<AudioCallProvider>(
                                        context,
                                        listen: false,
                                      ).createThread(
                                        context,
                                        User.fromJson(
                                          p.story[p.curruntUserIndex].listener
                                                  ?.toJson() ??
                                              {},
                                        ),
                                      );
                                    },
                                    icon: Center(
                                      child: Image.asset(
                                        'assets/icons/onlinwidgetIcons/mi_call (1).png',
                                        width: SC.from_width(22),
                                      ),
                                    ),
                                  ),

                                  CirclButton(
                                    active:
                                        p
                                            .story[p.curruntUserIndex]
                                            .listener
                                            ?.setAvailability
                                            ?.videoCall ??
                                        false,
                                    onTap: () async {
                                      await Provider.of<VideoCallProvider>(
                                        context,
                                        listen: false,
                                      ).createThread(
                                        context,
                                        User.fromJson(
                                          p.story[p.curruntUserIndex].listener
                                                  ?.toJson() ??
                                              {},
                                        ),
                                      );
                                    },
                                    // active: listener?.setAvailability?.videoCall??false,
                                    icon: Center(
                                      child: Image.asset(
                                        'assets/icons/onlinwidgetIcons/tabler_video (1).png',
                                        width: SC.from_width(22),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),

                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerFloat,
              ),
            ),
          ),
    );
  }
}
