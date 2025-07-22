import 'package:attach/api/local_db.dart';
import 'package:attach/bd/bg_main.dart';
import 'package:attach/callScreens/AudioCallScreen.dart';

import 'package:attach/const/app_constante.dart';
import 'package:attach/modles/custom_calls_info.dart';
import 'package:attach/modles/usertype.dart';
import 'package:attach/myfile/myast%20dart%20file.dart';
import 'package:attach/myfile/screen_dimension.dart';
import 'package:attach/noticiation/notificationService.dart';
import 'package:attach/providers/appLifesycalProvider.dart';

import 'package:attach/providers/home_provider.dart';

import 'package:attach/providers/profileProvider.dart';
import 'package:attach/screens/dash_board_screen/Home/home_screen.dart';
import 'package:attach/screens/dash_board_screen/inbox/inbox_screen.dart';
import 'package:attach/screens/dash_board_screen/inbox/tabs/videoCallScreen.dart';
import 'package:attach/screens/dash_board_screen/listner_home_screen/listenr_home_screen.dart';
import 'package:attach/screens/dash_board_screen/profile_screem/profile_screen.dart';
import 'package:attach/screens/dash_board_screen/walletScreen/wallet.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';


bool appOpen = false;






class DashBoardScreen extends StatefulWidget {
  final ReceivedAction? action;
  const DashBoardScreen({this.action,super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {


 final PageController _pageController = PageController();



 int cIndex =0;

 bool listener  = true;

 checkIfHaseAction() async
 {

   print("I am a function that check if i have action");

   if(appOpen)
     {
       return;
     }
   else
     {
       var call = await DB().getCallEvent();
       if(call!=null&&navigatorKey.currentContext!=null)
         {
           if(call.eventName==CustomCallEventName.videoCallPicked)
             {
               RoutTo(navigatorKey.currentContext!, child: (p0, p1) => VideoCallScreen(user: call.user!, callId: call.callId!, channelId: call.threadId??''),);
             }
           else if(call.eventName==CustomCallEventName.audioCallPicked)
             {
               RoutTo(navigatorKey.currentContext!, child: (p0, p1) => AudioCallScreen(user: call.user!, callId: call.callId!, threadId: call.threadId??''),);
             }

           appOpen = true;
         }
     }
}






initMyApp() async{



   // -----------------------------------This is new code---------------------------------------

  var  profile  =  Provider.of<ProfileProvider>(navigatorKey.currentContext!,listen: false);

  // if(profile.user?.userType==UserType.listener)
  //   {
  //     await initBgService();
  //     await addBGListener();
  //   }

  // -----------------------------------This is new code---------------------------------------

  // -----------------------------------This is old code---------------------------------------


  //     await initBgService();
  //     await addBGListener();

  // -----------------------------------This is old code---------------------------------------


  // await addBGListener();

  if(appOpen==false&&profile.user?.userType==UserType.listener)
    {
      await initBgService();
    }


  var appLifeCycle = Provider.of<AppLifeCycleProvider>(navigatorKey.currentContext!,listen: false);

   await appLifeCycle.init();

  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    checkIfHaseAction();
  });


}





 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<Socket_Provider>(context,listen: false).connectSocket();
    // Provider.of<ChatListProvider>(context,listen: false).getContact();
    initMyApp();
 }



  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // appBar: AppBar(title: Text("${widget.action}"),),

      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        onPageChanged: (d){

        },
        controller: _pageController,
        children: [



          Consumer<ProfileProvider>(builder: (context, p, child) {
            if(p.user?.userType==UserType.listener)
              {
                return ListnerHomeScreen();
              }
            else
              {
                return HomeScreen();
              }
          }),

          // HomeScreen(),
          // if(false)...[
          //   // HomeScreen(),
          //   ListnerHomeScreen()
          // ]
          // else...[
          //   HomeScreen(),
          // ],
          WalletScreen(),
          InboxScreen(),
          ProfileScreen(),

        ],
      ),

      bottomNavigationBar: Card(
        clipBehavior: Clip.hardEdge,
        margin: EdgeInsets.only(
          top: 5,
          left: SC.from_width(10),
          right: SC.from_width(10),
          bottom: SC.from_width(10),
        ),
        
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
        ),
        
        elevation: 0,

        child: GNav(

          onTabChange: (d){
            print(d);
            _pageController.jumpToPage(d);
            cIndex  = d.toInt();
          },

          selectedIndex: cIndex,

            textStyle: Const.font_500_14(context),

          padding: EdgeInsets.symmetric(horizontal: SC.from_width(12),vertical: SC.from_width(9)),
          tabMargin: EdgeInsets.symmetric(vertical: SC.from_width(15),horizontal: SC.from_width(12)),

          tabBackgroundColor: Const.yellow,


          backgroundColor: Const.primeColor,
            
        
            tabs: [
        
          GButton(

            leading: Container(
              margin: EdgeInsets.only(right: SC.from_width(3)),
              height: SC.from_width(20),
              width: SC.from_width(20),
                child: Image.asset('assets/icons/home_icon/home.png',color: Colors.white,)),


            icon: Icons.home,
          text: 'Home',),
        
        
          GButton(

            leading: Container(
                margin: EdgeInsets.only(right: SC.from_width(3)),
                height: SC.from_width(20),
                width: SC.from_width(20),
                child: Image.asset('assets/icons/home_icon/wallet.png',color: Colors.white,)),

            icon: Icons.wallet,
            text: 'Wallet',),
        
          GButton(
            leading: Container(
                margin: EdgeInsets.only(right: SC.from_width(3)),
                height: SC.from_width(20),
                width: SC.from_width(20),
                child: Image.asset('assets/icons/home_icon/inbox.png',color: Colors.white,)),
            icon: Icons.inbox,
            text: 'Inbox',),
        
        
          GButton(
            leading: Container(
                margin: EdgeInsets.only(right: SC.from_width(3)),
                height: SC.from_width(20),
                width: SC.from_width(20),
                child: Image.asset('assets/icons/home_icon/profi;e.png',color: Colors.white,)),
            icon: Icons.person_outline_rounded,
            text: 'Profile',),
        
        ]),
      ),

    );
  }
}







