import 'package:attach/const/app_constante.dart';
import 'package:attach/myfile/screen_dimension.dart';
import 'package:flutter/material.dart';


class TermsAndConditionScreen extends StatelessWidget {
  const TermsAndConditionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        centerTitle: false,
        title: Text("Terms & Condition"),
      ),
      
      
      body: ListView(
        children: [


          //
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 21),
            title: Text("📜 Terms and Conditions\n",),

            titleTextStyle: Const.font_900_20(context),
            subtitleTextStyle:Const.font_700_14(context,size:SC.from_width(12),color: Color.fromRGBO(190, 190, 190, 1))?.copyWith(
                height: SC.from_width(1.5)
            ) ,
            subtitle: Text("Last Updated: [Date]${'\n'*2}"

                "By using our app, you agree to the following Terms and Conditions. Please read them carefully before using the platform"),
          ),



          //
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 21),
            title: Text("1. User Types\n",),

            titleTextStyle: Const.font_900_20(context),
            subtitleTextStyle:Const.font_700_14(context,size:SC.from_width(12),color: Color.fromRGBO(190, 190, 190, 1))?.copyWith(
                height: SC.from_width(1.5)
            ) ,
            subtitle: Text("There are two types of users on our platform:\n"
                " - User: Scans bulbs for personal use and reward eligibility.\n"
                " - Shop Owner: Retailers or service providers who scan bulbs on behalf of customers and earn coins per scan."
            ),
          ),



          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 21),
            title: Text("2. Chat, audio call and video \n",),

            titleTextStyle: Const.font_900_20(context),
            subtitleTextStyle:Const.font_700_14(context,size:SC.from_width(12),color: Color.fromRGBO(190, 190, 190, 1))?.copyWith(
                height: SC.from_width(1.5)
            ) ,
            subtitle: Text(

                    "- Every user or shop owner can scan QR codes or barcodes on bulbs through our app.\n"
                    "- Scans must be genuine and from original products.\n"
                    "- Repeated or fake scans may result in account suspension.\n"
            ),
          ),

          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 21),
            title: Text("3. Coins and Rewards\n",),

            titleTextStyle: Const.font_900_20(context),
            subtitleTextStyle:Const.font_700_14(context,size:SC.from_width(12),color: Color.fromRGBO(190, 190, 190, 1))?.copyWith(
                height: SC.from_width(1.5)
            ) ,
            subtitle: Text(

                    "- Shop Owners will earn coins for each successful scan.\n"
                    "- Coins can be used for future rewards or offers (as per admin announcements).\n"
                    "- Users and Shop Owners are eligible for prizes only when assigned by Admin.\n"
            ),
          ),



        ],
      ),
      
    );
  }
}
