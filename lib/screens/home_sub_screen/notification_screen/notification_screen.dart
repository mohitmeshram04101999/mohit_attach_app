import 'package:attach/const/app_constante.dart';
import 'package:attach/myfile/screen_dimension.dart';
import 'package:attach/providers/notification_provider.dart';
import 'package:attach/screens/home_sub_screen/notification_screen/notification_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {


  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<NotificationProvider>(context,listen: false).refreshNotification(context);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(

        appBar: AppBar(
          centerTitle: false,
          title: Text("Notification"),
        ),



        body: Consumer<NotificationProvider>(
          builder: (context, p, child){
            if(p.isLoading)
              {
                return Center(child: CircularProgressIndicator(),);
              }


            if(p.notifications.isEmpty)
              {
                return Center(child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [


                      //
                      Image.asset("assets/icons/inboxpageicons/empty_Notification.png",width: SC.from_width(120),),

                      SizedBox(height: SC.from_width(12),),


                      //
                      Text("There are Currently No Notifications to Display.",
                      textAlign:  TextAlign.center,
                      style: Const.font_400_14(context,size: SC.from_width(24)),
                      ),
                      SizedBox(height: SC.from_width(20),),

                      //
                      Text("If there were any new updates or important messages for you, they would appear here. Keep exploring and engaging with the app to stay connected and receive timely notifications.",
                        textAlign:  TextAlign.center,
                        style: Const.font_400_16(context,),
                      ),
                    ],
                  ),
                ));
              }


            return RefreshIndicator(
              color: Colors.white,
              backgroundColor: Const.yellow,
              onRefresh: () async => await p.getNotification(context),
              child: ListView.separated(
                padding: EdgeInsets.symmetric(vertical: 20,horizontal: 14),
                itemCount: p.notifications.length,
                separatorBuilder: (context, index) => const SizedBox(height: 1,),
                itemBuilder: (context, index) =>  NotificationTile(
                  showTopRadius: index == 0 || (p.notifications[index-1].seen??false),
                  // showTopRadius: index == 0 || !(p.notifications[index-1].seen??false),
                    showBottomRadius: index == p.notifications.length-1 || (p.notifications[index+1].seen??false),
                    notification: p.notifications[index],
                ),
              ),
            );
          },
        ),


      ),
      onWillPop: () async {
        Provider.of<NotificationProvider>(context,listen: false).clearNotifications();
        return true;
      },
    );
  }
}



