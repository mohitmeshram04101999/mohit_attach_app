import 'package:attach/const/app_constante.dart';
import 'package:attach/myfile/screen_dimension.dart';
import 'package:attach/screens/dash_board_screen/Home/home_screen.dart';
import 'package:attach/screens/dash_board_screen/inbox/inbox_screen.dart';
import 'package:attach/screens/dash_board_screen/profile_screem/profile_screen.dart';
import 'package:attach/screens/dash_board_screen/walletScreen/wallet.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';



class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {


 final PageController _pageController = PageController();



 int cIndex =0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: PageView(
        onPageChanged: (d){

        },
        controller: _pageController,
        children: [
          HomeScreen(),
          WalletScreen(),
          InboxScreen(),
          ProfileScreen(),

        ],
      ),

      bottomNavigationBar: Card(
        clipBehavior: Clip.hardEdge,
        margin: EdgeInsets.only(
          left: SC.from_width(14),
          right: SC.from_width(14),
          bottom: SC.from_width(20),
        ),
        
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
        ),
        
        elevation: 0,

        color: Colors.transparent,

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
            text: 'inbox',),
        
        
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
