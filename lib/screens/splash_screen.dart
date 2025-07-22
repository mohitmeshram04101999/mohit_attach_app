import 'package:attach/noticiation/notificationService.dart';
import 'package:attach/providers/profileProvider.dart';
import 'package:attach/providers/videoCallProvider.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
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
     await getPermmission();
    Provider.of<ProfileProvider>(context,listen: false).checkUserLogIn(context,widget.action);


     final provider = Provider.of<VideoCallProvider>(context, listen: false);
     await provider.getPermmission();
  }


  getPermmission()async{

    var p1 = await  Permission.microphone.request();
    var b1 =  await Permission.bluetoothConnect.request();
    var b2   =  await Permission.bluetoothScan.request();

    print("this is permission statuse of \n b1 $b1 \n b2 $b2 \n p1 $p1");

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
