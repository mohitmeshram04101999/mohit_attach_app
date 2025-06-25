import 'package:attach/const/app_constante.dart';
import 'package:attach/modles/notification%20model.dart';
import 'package:attach/myfile/screen_dimension.dart';
import 'package:attach/other/date_time_manager.dart';
import 'package:flutter/material.dart';




class NotificationTile extends StatelessWidget {
  final bool showTopRadius;
  final bool showBottomRadius;
  final NotificationModel notification;

  // final Widget = DateTime.now();
  const NotificationTile({
    super.key,
     required this.notification,
    this.showTopRadius = true,
    this.showBottomRadius = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
      padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(showTopRadius ? 10 : 0),
            topRight: Radius.circular(showTopRadius ? 10 : 0),
            bottomLeft: Radius.circular(showBottomRadius ? 10 : 0),
            bottomRight: Radius.circular(showBottomRadius ? 10 : 0),
          ),



          color: (notification.seen??false)?null:Const.primeColor,
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 4,bottom: 4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // SizedBox(width: 10),


              Container(
                  width:SC.from_width(45),
                  height: SC.from_width(45),
                  decoration: BoxDecoration(
                    shape:  BoxShape.circle,
                    color: Const.scaffoldColor,
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                  ),

                child: Icon(Icons.notifications_outlined,color: Colors.white,size: SC.from_width(25),),

              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text(
                      notification.title??'',
                      style: Const.font_700_16(context,size: SC.from_width(18)),
                    ),
                    Text(
                      notification.message??'',
                      style: Const.font_400_14(context),
                    ),
                  ],
                ),
              ),



              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4,vertical: 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      DateTimeManager().timeAgo(notification.createdAt ?? DateTime.now()),
                      style: Const.font_400_12(context),
                    ),
                    Align(
                      child: Text(
                        DateTimeManager().formatTime12Hour(notification.createdAt ?? DateTime.now(), showDate: true, showYear: true, time: false),
                        style: Const.font_400_12(context, color: Const.yellow),
                      ),
                    ),
                  ],
                ),
              ),




              SizedBox(height: 1),
            ],
          ),
        ),
        );
    }
}