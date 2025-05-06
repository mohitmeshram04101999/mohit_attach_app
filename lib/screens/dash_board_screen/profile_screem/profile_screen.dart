import 'package:attach/componant/profile_list_tile.dart';
import 'package:attach/const/app_constante.dart';
import 'package:attach/myfile/myast%20dart%20file.dart';
import 'package:attach/myfile/screen_dimension.dart';
import 'package:attach/screens/dash_board_screen/profile_screem/profile_body/listner_card.dart';
import 'package:attach/screens/dash_board_screen/profile_screem/profile_body/profile_view.dart';
import 'package:attach/screens/profile_sub_screens/about_us.dart';
import 'package:attach/screens/profile_sub_screens/add_bank_account_screen/add_bank_account_screen.dart';
import 'package:attach/screens/profile_sub_screens/add_bank_account_screen/fix_add_bank_screen.dart';
import 'package:attach/screens/profile_sub_screens/contact_us_screen.dart';
import 'package:attach/screens/profile_sub_screens/edit_profile.dart';
import 'package:attach/screens/profile_sub_screens/privecy_policy.dart';
import 'package:attach/screens/profile_sub_screens/refer_and_earn.dart';
import 'package:attach/screens/profile_sub_screens/terms_and_condition_screen.dart';
import 'package:flutter/material.dart';



class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  bool listener = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(),
      ),

      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 14,vertical: 20),

        children: [




          //profile section
          ProfileView(listner: listener,),
          SizedBox(height: SC.from_width(33),),

          Divider(color: Const.primeColor,thickness: 3,height: SC.from_width(0),),
          SizedBox(height: SC.from_width(33),),
          
          Text("Account Settings",style: Const.font_400_12(context,size: SC.from_width(13),color: Color.fromRGBO(157, 157, 157, 1)),),
          SizedBox(height: SC.from_width(10),),


          //Edit Profile
          ProfileListTile(
              icon: 'assets/icons/profile_section_icons/image 9.png',
              title: "Edit Profile",
              subTitle: "Update your personal details.",
            onTap: ()=>RoutTo(context, child: (p0, p1) => EditProfile(),),
          ),


          //Refer and earn
          ProfileListTile(
              icon: 'assets/icons/profile_section_icons/image 10.png',
              title: "Refer & Earns",
              subTitle: "Share your referal code and earn money.",
            onTap: ()=>RoutTo(context, child: (p0, p1) => ReferAndEarnScreen(),),

          ),


          //Bank Account
          ProfileListTile(
              icon: 'assets/icons/profile_section_icons/image 11.png',
              title: "Bank Accounts",
              subTitle: "Add your bank account to withdraw money.",
            onTap: ()=>RoutTo(context, child:(p0, p1) =>  AddBankScreen()),

          ),

          //contact us
          ProfileListTile(
              icon: 'assets/icons/profile_section_icons/image 12.png',
              title: "Contact Us",
              subTitle: "Get support or assistance.",
            onTap: ()=>RoutTo(context, child: (p0, p1) => ContactUsScreen(),),
          ),

          //logout
          ProfileListTile(
              icon: 'assets/icons/profile_section_icons/image 16.png',
              title: "Logout",
              subTitle: "Sign out this account.",
          ),

        Text("Company",style: Const.font_400_12(context,size: SC.from_width(13),color: Color.fromRGBO(157, 157, 157, 1)),),
          SizedBox(height: SC.from_width(10),),

          //about use
          ProfileListTile(
              icon: 'assets/icons/profile_section_icons/image 13.png',
              title: "About Us",
              subTitle: "See company about and details.",
            onTap: ()=>RoutTo(context, child: (p0, p1) => AboutUsScreen(),),
          ),

          //Privecy Policy
          ProfileListTile(
              icon: 'assets/icons/profile_section_icons/image 14.png',
              title: "Privacy Policy",
              subTitle: "See company privacy policy. ",
          onTap: ()=>RoutTo(context, child: (p0, p1) => PrivecyPolicyScreen(),),),

          //Terms And Condition
          ProfileListTile(
              icon: 'assets/icons/profile_section_icons/image 15.png',
              title: "Terms & Conditions",
              subTitle: "App usage rules and guidlines.",
            onTap: ()=>RoutTo(context, child: (p0, p1) => TermsAndConditionScreen(),),
          ),
          SizedBox(height: SC.from_width(20),),

          //Lister Tile,
          ListerCard(
            onTap: (){
              print("asdf");
              listener =!listener;
              setState(() {

              });
            },
          ),
          SizedBox(height: SC.from_width(30),),
          
          Align(alignment: Alignment.center,child:
          Text("Made in Bharat",
            style: Const.roboto_400_12(context,size: SC.from_width(10),color: Color.fromRGBO(109, 57, 146, 1)),)),
          SizedBox(height: SC.from_width(9),),

          Align(alignment: Alignment.center,child:
            Text("v1.3.54 - B34",
            style: Const.roboto_400_12(context,color: Color.fromRGBO(121, 106, 131, 1)),)),
          
          



        ],
      ),

    );
  }
}
