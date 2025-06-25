import 'package:attach/noticiation/notificationService.dart';
import 'package:attach/providers/profileProvider.dart';
import 'package:attach/providers/videoCallProvider.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class SplashScreen extends StatefulWidget {
  final ReceivedAction? action;
  const SplashScreen({this.action,super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    start();


  }

  start() async
  {

     await NotificationService().getNotificationPermission();
    Provider.of<ProfileProvider>(context,listen: false).checkUserLogIn(context,widget.action);


     final provider = Provider.of<VideoCallProvider>(context, listen: false);
     await provider.getPermmission();
  }

  @override
  Widget build(BuildContext context) {

    //
    return Scaffold(

        body: Center(child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Image.asset("assets/icons/attachLancharIcon.png"),
        ))
    );

    //

  }
}
