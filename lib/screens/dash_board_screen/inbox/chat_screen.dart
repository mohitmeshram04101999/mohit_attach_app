import 'package:attach/api/local_db.dart';
import 'package:attach/componant/chat_bubble.dart';

import 'package:attach/componant/online_user_Image_widget.dart';

import 'package:attach/const/app_constante.dart';
import 'package:attach/dialog/listener_ratting_dailog.dart';
import 'package:attach/modles/chat_contect_model.dart';
import 'package:attach/modles/otp_responce.dart';
import 'package:attach/modles/usertype.dart';
import 'package:attach/myfile/animated%20dilog.dart';

import 'package:attach/myfile/screen_dimension.dart';
import 'package:attach/other/date_time_manager.dart';
import 'package:attach/providers/audio%20call%20provider.dart';

import 'package:attach/providers/chatProvider.dart';
import 'package:attach/providers/chat_screen_message_field.dart';
import 'package:attach/providers/videoCallProvider.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  final ChatContact? contact;
  const ChatScreen({this.contact, Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(
      builder: (context, p, child) {
        return WillPopScope(
          onWillPop: () async {
            p.cleaProvider();
            p.stopChat();
            return true;
          },
          child: Scaffold(
            appBar: AppBar(
              leadingWidth: SC.from_width(85),
              titleSpacing: 0,

              leading: Container(
                margin: EdgeInsets.only(left: 5),
                child: InkWell(
                  borderRadius: BorderRadius.circular(100),
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 6),
                    child: Row(
                      children: [
                        Icon(Icons.arrow_back),
                        SizedBox(width: SC.from_width(5)),
                        Hero(
                          tag:
                              'chat_page${widget.contact?.user?.id}${widget.contact?.user?.image ?? ''}',
                          child: SizedBox(
                            height: SC.from_width(40),
                            width: SC.from_width(40),
                            child: OnlineUserImageWidget(
                              online: false,
                              image:
                                  p.user?.image ??
                                  widget.contact?.user?.image ??
                                  '',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              title: InkWell(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    children: [
                      SizedBox(width: SC.from_width(10)),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    p.user?.name ??
                                        widget.contact?.user?.name ??
                                        '',
                                    style: Const.font_500_16(context),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                SizedBox(width: SC.from_width(5)),
                                if (p.user?.userVerified ?? false)
                                  Image.asset(
                                    "assets/icons/verIcon.png",
                                    width: SC.from_width(18),
                                  ),
                              ],
                            ),
                            Text(
                              (p.user?.online ?? false)
                                  ? 'Online'
                                  : '${DateTimeManager().formatTime12Hour(p.user?.lastSeen?.add(Duration(minutes: 330)))}',
                              style: Const.font_400_12(
                                context,
                                size: SC.from_width(10),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              actions: [


                if ((DB.curruntUser?.userType == UserType.user || kDebugMode))
                  Consumer<VideoCallProvider>(
                    builder:
                        (context, videoCall, child) => IconButton(
                          onPressed: () {
                            var u = User.fromJson(p.user!.toJson());

                            Logger().i(u.toJson());

                            videoCall.makeVideoCall(
                              context,
                              threadId: p.threadId ?? '',
                              user: u,
                            );
                          },
                          icon: Image.asset(
                            "assets/icons/inboxpageicons/vid.png",
                            width: SC.from_width(30),
                          ),
                        ),
                  ),

                SizedBox(width: SC.from_width(10)),

                if ((DB.curruntUser?.userType == UserType.user || kDebugMode))
                  Consumer<AudioCallProvider>(
                    builder:
                        (context, audionCall, child) => IconButton(
                          onPressed: () {
                            audionCall.makeAudioCall(
                              context,
                              user: User.fromJson(p.user!.toJson()),
                              threadId: p.threadId ?? '',
                            );
                          },
                          color: Const.yellow,
                          icon: Image.asset(
                            "assets/icons/inboxpageicons/aud.png",
                            width: SC.from_width(25),
                          ),
                        ),
                  ),
                SizedBox(width: SC.from_width(5)),
              ],
            ),

            body: Stack(
              children: [
                Column(
                  children: [
                    if (kDebugMode)
                      Column(
                        children: [
                          Text("${p.message.length}"),
                          Text("${p.userIsTyping}"),
                          Text("${p.threadId}"),
                          Text('${p.user?.toJson()}'),
                          // Text("${p.user?.toJson()}"),
                        ],
                      ),
                    Expanded(
                      child:
                          (p.loading)
                              ? Center(child: CircularProgressIndicator())
                              : ListView(
                                reverse: p.message.isNotEmpty,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 20,
                                ),
                                children: [
                                  if (p.userIsTyping) ChatBubble(typing: true),

                                  if (p.message.isNotEmpty)
                                    for (var m in p.message)
                                      ChatBubble(key: ValueKey(m.id), message: m),
                                  if (p.message.isEmpty) _SafeConversationCard(),
                                ],
                              ),
                    ),

                    //
                    Hero(tag: "messageTag", child: ChatScreenMessageField()),
                  ],
                ),

                //

                if(DB.curruntUser?.userType==UserType.user&&p.sessionId!=""&&p.sessionId!=null)
                  Positioned(
                  top: 10,
                  right: 14,
                  child: Ink(
                    decoration: BoxDecoration(
                      color: Const.primeColor,
                      boxShadow: [
                        BoxShadow(
                          // color: Const.yellow,
                          color: Colors.white,
                          blurRadius: 1
                        )
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                    ),
                    child: InkWell(
                      borderRadius:BorderRadius.all( Radius.circular(100)) ,
                      onTap: (){

                        p.endSession(context);

                    }, child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                      child: Row(
                        children: [
                          Icon(Icons.stop_rounded,color: Colors.white,),
                          Text("Stop Session",style: Const.font_400_12(context),),
                        ],
                      ),
                    ),),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _SafeConversationCard extends StatelessWidget {
  const _SafeConversationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.all(0),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Title Row
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.shield, color: Colors.green, size: 24),
                SizedBox(width: 8),
                Text(
                  '100% Safe & Private Conversation',
                  style: TextStyle(
                    fontFamily: 'ProductSans',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Info Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                Expanded(
                  child: _InfoItem(
                    icon: Icons.warning_amber_rounded,
                    iconColor: Colors.red,
                    text: 'Do not share\nany sensitive\ninformation',
                  ),
                ),
                Expanded(
                  child: _InfoItem(
                    icon: Icons.forum,
                    iconColor: Colors.blue,
                    text: 'Conversation are\nnot shared with\nanyone',
                  ),
                ),
                Expanded(
                  child: _InfoItem(
                    icon: Icons.lock,
                    iconColor: Colors.orange,
                    text: 'Conversation are\nencrypted &\nsecure',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String text;

  const _InfoItem({
    required this.icon,
    required this.iconColor,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: iconColor, size: 40),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.all(3),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: Const.font_400_12(context),
          ),
        ),
      ],
    );
  }
}
