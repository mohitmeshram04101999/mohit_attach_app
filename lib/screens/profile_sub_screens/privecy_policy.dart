import 'package:attach/api/bankpai/other_api.dart';
import 'package:attach/const/app_constante.dart';
import 'package:attach/modles/compiny_responce_model.dart';
import 'package:attach/myfile/screen_dimension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';


class PrivecyPolicyScreen extends StatelessWidget {
  const PrivecyPolicyScreen({super.key});

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       centerTitle: false,
  //       title: Text("Privecy Policy"),
  //     ),
  //
  //     body:  ListView(
  //       children: [
  //
  //
  //         //
  //         ListTile(
  //           contentPadding: EdgeInsets.symmetric(horizontal: 21),
  //           title: Text("🔒 Privacy Policy\n",),
  //
  //           titleTextStyle: Const.font_900_20(context),
  //           subtitleTextStyle:Const.font_700_14(context,size:SC.from_width(12),color: Color.fromRGBO(190, 190, 190, 1))?.copyWith(
  //             height: SC.from_width(1.5)
  //           ) ,
  //           subtitle: Text("Last Updated: [Date]${'\n'*2}"
  //
  //               "This Privacy Policy explains how we collect, use, and protect your personal information when you use our platform to scan bulbs, earn rewards, and participate in prize programs."),
  //         ),
  //
  //
  //
  //         //
  //         ListTile(
  //           contentPadding: EdgeInsets.symmetric(horizontal: 21),
  //           title: Text("📱 1. User Roles\n",),
  //
  //           titleTextStyle: Const.font_900_20(context),
  //           subtitleTextStyle:Const.font_700_14(context,size:SC.from_width(12),color: Color.fromRGBO(190, 190, 190, 1))?.copyWith(
  //               height: SC.from_width(1.5)
  //           ) ,
  //           subtitle: Text("Our platform has two types of users:\n"
  //               " - User: Individuals who scan bulbs for rewards.\n"
  //               " - Shop Owner: Business owners who register and scan bulbs on behalf of customers."
  //           ),
  //         ),
  //
  //
  //
  //         ListTile(
  //           contentPadding: EdgeInsets.symmetric(horizontal: 21),
  //           title: Text("🔍 2. Data We Collect\n",),
  //
  //           titleTextStyle: Const.font_900_20(context),
  //           subtitleTextStyle:Const.font_700_14(context,size:SC.from_width(12),color: Color.fromRGBO(190, 190, 190, 1))?.copyWith(
  //               height: SC.from_width(1.5)
  //           ) ,
  //           subtitle: Text(
  //               "We may collect the following data:\n"
  //               "- Name, phone number, email (for registration)\n"
  //               "- Location (for prize distribution and analytics)\n"
  //               "- Bulb scan history (to track rewards and validate claims)\n"
  //               "- Device info (for app performance & security)\n"
  //           ),
  //         ),
  //
  //         ListTile(
  //           contentPadding: EdgeInsets.symmetric(horizontal: 21),
  //           title: Text("💡 3. Users and listner\n",),
  //
  //           titleTextStyle: Const.font_900_20(context),
  //           subtitleTextStyle:Const.font_700_14(context,size:SC.from_width(12),color: Color.fromRGBO(190, 190, 190, 1))?.copyWith(
  //               height: SC.from_width(1.5)
  //           ) ,
  //           subtitle: Text(
  //               "- Users and Shop Owners can scan bulbs using the app\n"
  //               "- Each scan may generate coins or rewards based on system rules\n"
  //               "- Admin has the right to assign prizes to Users and Shop Owners\n"
  //                   "- Shop Owners receive coins for every valid scan done through their account\n"
  //           ),
  //         ),
  //
  //
  //
  //       ],
  //     ),
  //   );
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text("Privecy Policy"),
      ),
      body: FutureBuilder<CompanyResponce?>(
        future: OtherApi().getCompany(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("❌ Error: ${snapshot.error}"));
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text("No data available."));
          }

          // If data is fetched successfully
          return ListView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 14),
            children: [


              HtmlWidget(
                snapshot.data?.data?.privacyPolicy??'',
                textStyle: Const.font_700_14(context,size: SC.from_width(12)),
              ),



              // ListTile(
              //   contentPadding: EdgeInsets.symmetric(horizontal: 21),
              //   title: Text("🔦 About Us\n"),
              //   titleTextStyle: Const.font_900_20(context),
              //   subtitleTextStyle: Const.font_700_14(
              //     context,
              //     size: SC.from_width(12),
              //     color: Color.fromRGBO(190, 190, 190, 1),
              //   )?.copyWith(height: SC.from_width(1.5)),
              //   subtitle: Text(
              //     "Syncbel ek innovative platform hai jo smart bulb tracking aur reward system ke zariye lighting industry mein ek nayi roshni laa raha hai. Humne is app ko isliye design kiya hai taaki users aur shop owners dono bulbs ke QR ya barcodes scan karke coins kama sakein, rewards jeet sakein, aur defective products ko asaani se replace kar sakein.",
              //   ),
              // ),
              //
              // ListTile(
              //   contentPadding: EdgeInsets.symmetric(horizontal: 21),
              //   title: Text("🎯 Our Mission\n"),
              //   titleTextStyle: Const.font_900_20(context),
              //   subtitleTextStyle: Const.font_700_14(
              //     context,
              //     size: SC.from_width(12),
              //     color: Color.fromRGBO(190, 190, 190, 1),
              //   )?.copyWith(height: SC.from_width(1.5)),
              //   subtitle: Text(
              //     "Hamara mission hai ki:\n"
              //         " - Users: Apne ghar ke bulbs scan karke rewards aur prize jeet sakte hain.\n"
              //         " - Shop Owners: Har bulb scan par coins kamaate hain, jise future mein reward points mein convert kiya ja sakta hai.\n",
              //   ),
              // ),
              //
              // ListTile(
              //   contentPadding: EdgeInsets.symmetric(horizontal: 21),
              //   title: Text("👥 Who Can Use This App?\n"),
              //   titleTextStyle: Const.font_900_20(context),
              //   subtitleTextStyle: Const.font_700_14(
              //     context,
              //     size: SC.from_width(12),
              //     color: Color.fromRGBO(190, 190, 190, 1),
              //   )?.copyWith(height: SC.from_width(1.5)),
              //   subtitle: Text(
              //     "- Every user or shop owner can scan QR codes or barcodes on bulbs through our app.Users: Apne ghar ke bulbs scan karke rewards aur prize jeet sakte hain.\n"
              //         "- Shop Owners: Har bulb scan par coins kamaate hain, jise future mein reward points mein convert kiya ja sakta hai.\n",
              //   ),
              // ),
              //
              // ListTile(
              //   contentPadding: EdgeInsets.symmetric(horizontal: 21),
              //   title: Text("🎁 Rewards & Replacements\n"),
              //   titleTextStyle: Const.font_900_20(context),
              //   subtitleTextStyle: Const.font_700_14(
              //     context,
              //     size: SC.from_width(12),
              //     color: Color.fromRGBO(190, 190, 190, 1),
              //   )?.copyWith(height: SC.from_width(1.5)),
              //   subtitle: Text(
              //     "- Har scan par aapko milte hain reward coins.\n"
              //         "- Kabhi kabhi Admin aapko assign karta hai special prizes.\n"
              //         "- Agar koi bulb defective nikle, toh uska replacement process fast aur simple hai.\n",
              //   ),
              // ),

            ],
          );
        },
      ),
    );
  }
}
