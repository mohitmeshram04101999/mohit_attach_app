import 'package:attach/const/app_constante.dart';
import 'package:attach/myfile/screen_dimension.dart';
import 'package:flutter/material.dart';


class PrivecyPolicyScreen extends StatelessWidget {
  const PrivecyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text("Privecy Policy"),
      ),

      body:  ListView(
        children: [


          //
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 21),
            title: Text("🔒 Privacy Policy\n",),

            titleTextStyle: Const.font_900_20(context),
            subtitleTextStyle:Const.font_700_14(context,size:SC.from_width(12),color: Color.fromRGBO(190, 190, 190, 1))?.copyWith(
              height: SC.from_width(1.5)
            ) ,
            subtitle: Text("Last Updated: [Date]${'\n'*2}"

                "This Privacy Policy explains how we collect, use, and protect your personal information when you use our platform to scan bulbs, earn rewards, and participate in prize programs."),
          ),



          //
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 21),
            title: Text("📱 1. User Roles\n",),

            titleTextStyle: Const.font_900_20(context),
            subtitleTextStyle:Const.font_700_14(context,size:SC.from_width(12),color: Color.fromRGBO(190, 190, 190, 1))?.copyWith(
                height: SC.from_width(1.5)
            ) ,
            subtitle: Text("Our platform has two types of users:\n"
                " - User: Individuals who scan bulbs for rewards.\n"
                " - Shop Owner: Business owners who register and scan bulbs on behalf of customers."
            ),
          ),



          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 21),
            title: Text("🔍 2. Data We Collect\n",),

            titleTextStyle: Const.font_900_20(context),
            subtitleTextStyle:Const.font_700_14(context,size:SC.from_width(12),color: Color.fromRGBO(190, 190, 190, 1))?.copyWith(
                height: SC.from_width(1.5)
            ) ,
            subtitle: Text(
                "We may collect the following data:\n"
                "- Name, phone number, email (for registration)\n"
                "- Location (for prize distribution and analytics)\n"
                "- Bulb scan history (to track rewards and validate claims)\n"
                "- Device info (for app performance & security)\n"
            ),
          ),

          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 21),
            title: Text("💡 3. Users and listner\n",),

            titleTextStyle: Const.font_900_20(context),
            subtitleTextStyle:Const.font_700_14(context,size:SC.from_width(12),color: Color.fromRGBO(190, 190, 190, 1))?.copyWith(
                height: SC.from_width(1.5)
            ) ,
            subtitle: Text(
                "- Users and Shop Owners can scan bulbs using the app\n"
                "- Each scan may generate coins or rewards based on system rules\n"
                "- Admin has the right to assign prizes to Users and Shop Owners\n"
                    "- Shop Owners receive coins for every valid scan done through their account\n"
            ),
          ),


          
        ],
      ),
    );
  }
}
