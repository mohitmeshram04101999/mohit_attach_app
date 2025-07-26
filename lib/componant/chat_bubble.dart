import 'package:attach/api/local_db.dart';
import 'package:attach/componant/message_media_widget.dart';
import 'package:attach/const/app_constante.dart';
import 'package:attach/modles/load_chat_model.dart';
import 'package:attach/myfile/screen_dimension.dart';
import 'package:attach/other/date_time_manager.dart';
import 'package:attach/providers/chatProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class ChatBubble extends StatefulWidget {
  final bool typing;
  final Message? message;
  final bool selected;
  const ChatBubble({
    this.selected = false,
    this.typing = false,
    this.message,
    super.key,
  });

  @override
  State<ChatBubble> createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> with TickerProviderStateMixin {
  late final SlidableController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = SlidableController(this);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.typing) {
      return Align(
        alignment: Alignment.centerLeft,
        child: Container(
          margin: EdgeInsets.only(top: SC.from_width(12)),
          // color:Colors.red,
          width: SC.from_width(70),
          height: SC.from_width(33),
          child: Image.asset(
            "assets/icons/typing_gig.gif",
            fit: BoxFit.fitWidth,
            color: Const.yellow,
          ),
        ),
      );
    }

    bool self = widget.message?.sender == DB.curruntUser?.id;

    Widget seenW;

    switch (widget.message?.status) {
      case 'SEEN':
        seenW =
            seenW = Image.asset(
              "assets/icons/checks/double-tick.png",
              color: Const.yellow,
              width: SC.from_width(15),
            );
        break;
      case 'DELIVERED':
        seenW = Image.asset(
          "assets/icons/checks/double-tick.png",
          color: Const.grey_190_190_190,
          width: SC.from_width(15),
        );
        break;

      default:
        seenW = Image.asset(
          "assets/icons/checks/check.png",
          color: Const.grey_190_190_190,
          width: SC.from_width(15),
        );
    }

    if (widget.message?.messageType == 'CALLHISTORY') {
      return Align(
        alignment: self ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: self ? Const.primeColor : Colors.white,
          ),
          margin: EdgeInsets.only(
            top: 8,
            left: self ? SC.from_width(70) : 0,
            right: self ? 0 : SC.from_width(70),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [

              //image
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius:  BorderRadius.circular(8),
                  color: self ? Const.yellow : Const.primeColor,
                ),
                child: Image.asset(
                  widget.message?.callHistory?.callType == 'VIDEO'?
                   "assets/icons/inboxpageicons/vid.png":
                   "assets/icons/inboxpageicons/aud.png",
                  width: SC.from_width(20),
                  height: SC.from_width(20),
                  color: Colors.white
                ),
              ),
              SizedBox(width: SC.from_width(10)),

              //text
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.message?.callHistory?.callType == 'VIDEO'
                        ? 'Video Call'
                        : 'Audio Call',
                    style: Const.font_400_14(
                      context,
                      color:
                          self ? Colors.white : const Color.fromRGBO(58, 61, 64, 1),
                    ),
                  ),

                  Text(
                    widget.message?.callHistory?.status == 'COMPLETE'
                        ? 'Answered'
                        : 'Not Answered',
                    style: Const.font_400_14(
                      context,
                      size: SC.from_width(10),
                      color:
                      self ? Colors.white : const Color.fromRGBO(58, 61, 64, 1),
                    ),
                  ),
                ],
              ),

              SizedBox(width: SC.from_width(10)),

              //time
              Padding(
                padding: const EdgeInsets.only(bottom: 2),
                child: Text(
                  DateTimeManager().formatTime12Hour(
                    widget.message?.createdAt?.add(
                      const Duration(minutes: 330),
                    ),
                  ) ??
                      '',
                  style: Const.font_500_16(
                    context,
                    color: Colors.grey,
                    size: SC.from_width(8),
                  )?.copyWith(fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (widget.message?.messageType == 'DOC_MESSAGE')
      {
        return MessageMediaWidget(message: widget.message!,seen: seenW,key: ValueKey('${widget.message?.id??''}_${widget.message?.media}'),);
      }

    return Align(
      alignment: self ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(
          top: 8,
          left: self ? SC.from_width(70) : 0,
          right: self ? 0 : SC.from_width(70),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: self ? Const.primeColor : Colors.white,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Flexible(
              child: Text(
                "${widget.message?.message ?? ''}",
                softWrap: true,
                style: Const.font_400_14(
                  context,
                  color:
                      self ? Colors.white : const Color.fromRGBO(58, 61, 64, 1),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Padding(
              padding: const EdgeInsets.only(bottom: 2),
              child: Text(
                DateTimeManager().formatTime12Hour(
                      widget.message?.createdAt?.add(
                        const Duration(minutes: 330),
                      ),
                    ) ??
                    '',
                style: Const.font_500_16(
                  context,
                  color: Colors.grey,
                  size: SC.from_width(8),
                )?.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(width: SC.from_width(5)),

            if (self)
              Padding(
                padding: const EdgeInsets.only(bottom: 1),
                child: seenW,
                // child: Text("${message?.status}"),
              ),
          ],
        ),
      ),
    );
  }
}
