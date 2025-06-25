import 'package:attach/api/bankpai/other_api.dart';
import 'package:attach/const/app_constante.dart';
import 'package:attach/modles/compiny_responce_model.dart';
import 'package:attach/myfile/screen_dimension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';


class TermsAndConditionScreen extends StatelessWidget {
  const TermsAndConditionScreen({super.key});

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //
  //     appBar: AppBar(
  //       centerTitle: false,
  //       title: Text("Terms & Condition"),
  //     ),
  //
  //
  //     body: ListView(
  //       children: [
  //
  //
  //         //
  //         ListTile(
  //           contentPadding: EdgeInsets.symmetric(horizontal: 21),
  //           title: Text("📜 Terms and Conditions\n",),
  //
  //           titleTextStyle: Const.font_900_20(context),
  //           subtitleTextStyle:Const.font_700_14(context,size:SC.from_width(12),color: Color.fromRGBO(190, 190, 190, 1))?.copyWith(
  //               height: SC.from_width(1.5)
  //           ) ,
  //           subtitle: Text("Last Updated: [Date]${'\n'*2}"
  //
  //               "By using our app, you agree to the following Terms and Conditions. Please read them carefully before using the platform"),
  //         ),
  //
  //
  //
  //         //
  //         ListTile(
  //           contentPadding: EdgeInsets.symmetric(horizontal: 21),
  //           title: Text("1. User Types\n",),
  //
  //           titleTextStyle: Const.font_900_20(context),
  //           subtitleTextStyle:Const.font_700_14(context,size:SC.from_width(12),color: Color.fromRGBO(190, 190, 190, 1))?.copyWith(
  //               height: SC.from_width(1.5)
  //           ) ,
  //           subtitle: Text("There are two types of users on our platform:\n"
  //               " - User: Scans bulbs for personal use and reward eligibility.\n"
  //               " - Shop Owner: Retailers or service providers who scan bulbs on behalf of customers and earn coins per scan."
  //           ),
  //         ),
  //
  //
  //
  //         ListTile(
  //           contentPadding: EdgeInsets.symmetric(horizontal: 21),
  //           title: Text("2. Chat, audio call and video \n",),
  //
  //           titleTextStyle: Const.font_900_20(context),
  //           subtitleTextStyle:Const.font_700_14(context,size:SC.from_width(12),color: Color.fromRGBO(190, 190, 190, 1))?.copyWith(
  //               height: SC.from_width(1.5)
  //           ) ,
  //           subtitle: Text(
  //
  //                   "- Every user or shop owner can scan QR codes or barcodes on bulbs through our app.\n"
  //                   "- Scans must be genuine and from original products.\n"
  //                   "- Repeated or fake scans may result in account suspension.\n"
  //           ),
  //         ),
  //
  //         ListTile(
  //           contentPadding: EdgeInsets.symmetric(horizontal: 21),
  //           title: Text("3. Coins and Rewards\n",),
  //
  //           titleTextStyle: Const.font_900_20(context),
  //           subtitleTextStyle:Const.font_700_14(context,size:SC.from_width(12),color: Color.fromRGBO(190, 190, 190, 1))?.copyWith(
  //               height: SC.from_width(1.5)
  //           ) ,
  //           subtitle: Text(
  //
  //                   "- Shop Owners will earn coins for each successful scan.\n"
  //                   "- Coins can be used for future rewards or offers (as per admin announcements).\n"
  //                   "- Users and Shop Owners are eligible for prizes only when assigned by Admin.\n"
  //           ),
  //         ),
  //
  //
  //
  //       ],
  //     ),
  //
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text("Terms And Condition"),
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

                snapshot.data?.data?.termsCondition??'',
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
