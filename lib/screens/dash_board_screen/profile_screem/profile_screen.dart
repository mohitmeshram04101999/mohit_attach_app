import 'package:attach/componant/profile_list_tile.dart';
import 'package:attach/const/app_constante.dart';
import 'package:attach/modles/usertype.dart';
import 'package:attach/myfile/animated%20dilog.dart';
import 'package:attach/myfile/myast%20dart%20file.dart';
import 'package:attach/myfile/routanimationConfigration.dart';
import 'package:attach/myfile/screen_dimension.dart';
import 'package:attach/providers/profileProvider.dart';
import 'package:attach/screens/become_listener_screen/become_listern_main.dart';
import 'package:attach/screens/dash_board_screen/profile_screem/profile_body/become_listner_dailog.dart';
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
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



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




      body: RefreshIndicator(
      color: Colors.white,
        backgroundColor: Const.yellow,
        onRefresh: ()async{
          await Provider.of<ProfileProvider>(context,listen: false).getUser(context);
        },
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 14,vertical: 20),

          children: [

            SizedBox(height: SC.from_width(50),),



            //profile section
            SelfProfileView(listner: listener,),


            SizedBox(height: SC.from_width(25),),

            Divider(color: Const.primeColor,thickness: 3,height: SC.from_width(0),),
            SizedBox(height: SC.from_width(16),),

            Text("Account Settings",style: Const.font_400_12(context,size: SC.from_width(13),color: Color.fromRGBO(157, 157, 157, 1)),),
            SizedBox(height: SC.from_width(10),),


            //Edit Profile
            ProfileListTile(
                icon: 'assets/icons/profile_section_icons/image 9.png',
                title: "Edit Profile",
                subTitle: "Update your personal details.",
              onTap: ()async{

                await  RoutTo(context, child: (p0, p1) => EditProfile(),);

                ProfileProvider p = Provider.of<ProfileProvider>(context,listen: false);
                p.clearEdit(context);
              },
            ),


            //Refer and earn
            ProfileListTile(
                icon: 'assets/icons/profile_section_icons/image 10.png',
                title: "Refer & Earns",
                subTitle: "Share your referal code and earn money.",

              onTap: (){
                  RoutTo(context, child: (p0, p1) => ReferAndEarnScreen(),);
             },


            ),


            //Bank Account
           Consumer<ProfileProvider>(builder: (context, p, child) {
             if(p.user?.userType==UserType.listener||kDebugMode)
               {
                 return  ProfileListTile(
                   icon: 'assets/icons/profile_section_icons/image 11.png',
                   title: "Bank Accounts",
                   subTitle: "Add your bank account to withdraw money.",
                   onTap: ()=>RoutTo(context, child:(p0, p1) =>  AddBankScreen()),

                 );
               }
             return SizedBox();
           },),

            //contact us
            ProfileListTile(
                icon: 'assets/icons/profile_section_icons/image 12.png',
                title: "Contact Us",
                subTitle: "Get support or assistance.",
              onTap: ()=>RoutTo(context, child: (p0, p1) => ContactUsScreen(),),
            ),

            //logout
            ProfileListTile(
              onTap: () async{
                print("asdf");
                await Provider.of<ProfileProvider>(context,listen: false).logOut(context);
              },
                icon: 'assets/icons/profile_section_icons/image 16.png',
                title: "Logout",
                subTitle: "Sign out this account.",
            ),
          SizedBox(height: SC.from_width(8),),

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
            Consumer<ProfileProvider>(builder: (context, p, child) {



              // return Text(p.user!.toJson().toString());

              if(p.user?.userType==UserType.user)
                {

                  if(p.user?.status=='PENDING')
                    {
                      return ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                        minTileHeight: SC.from_width(48),
                        title: Text("Profile Is In Review For Listener"),
                        subtitle: Text("Waiting for approval." ),
                        leading: Icon(Icons.info_rounded,),
                        tileColor: Const.yellow.withOpacity(1),
                      );
                    }

                  if(p.user?.status=='REJECTED')
                    {
                      return ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                        minTileHeight: SC.from_width(48),
                        title: Text("Profile Is Rejected For Listener"),
                        subtitle: Text("Please try again." ),
                        leading: Icon(Icons.info_rounded,),
                        onTap: (){
                          RoutTo(context, child:(p0, p1) => BecomeListenerMain(),);
                        },
                        tileColor: Colors.red,
                      );
                    }

                  if(p.user?.status=='APPROVED')
                    {
                      return ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                        minTileHeight: SC.from_width(48),
                        title: Text("Profile Is Approved For Listener"),
                        subtitle: Text("You are now a listener." ),
                        leading: Icon(Icons.info_rounded,),
                        tileColor: Colors.green,
                      );
                    }


                  return ListerCard(
                    onTap: () async{


                     var p = await OpenDailogWithAnimation(
                          barriarColor: Colors.white.withOpacity(.5),
                          curve: Interval(0, .4,curve: Curves.easeOut),
                          reversCurve: Interval(0, .4,curve: Curves.easeOut),
                          duration: Duration(milliseconds: 800),
                          context, dailog: (a,b)=>BecomeListenerDailog(animation: a,));

                     if(p==true)
                       {
                         RoutTo(context, child:(p0, p1) => BecomeListenerMain(),);
                       }
                    },
                  );
                }
              else
                {
                  return SizedBox();


                }
            }
                ,),
            SizedBox(height: SC.from_width(30),),

            Align(alignment: Alignment.center,child:
            Text("Made in Bharat",
              style: Const.roboto_400_12(context,size: SC.from_width(11),color: Color.fromRGBO(109, 57, 146, 1)),)),
            SizedBox(height: SC.from_width(9),),

            Align(alignment: Alignment.center,child:
              Text("v1.3.54 - B34",
              style: Const.roboto_400_12(context,color: Color.fromRGBO(121, 106, 131, 1),size: SC.from_width(14)),)),





          ],
        ),
      ),

    );
  }
}
