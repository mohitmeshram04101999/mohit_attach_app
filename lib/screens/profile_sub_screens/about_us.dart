  import 'package:attach/api/bankpai/other_api.dart';
import 'package:attach/const/app_constante.dart';
import 'package:attach/modles/compiny_responce_model.dart';
  import 'package:attach/myfile/screen_dimension.dart';
  import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';


  class AboutUsScreen extends StatelessWidget {
    const AboutUsScreen({super.key});

    // @override
    // Widget build(BuildContext context) {
    //   return Scaffold(
    //     appBar: AppBar(
    //       centerTitle: false,
    //       title: Text("About Us"),
    //     ),
    //
    //     body:  ListView(
    //       children: [
    //
    //
    //
    //         //
    //         ListTile(
    //           contentPadding: EdgeInsets.symmetric(horizontal: 21),
    //           title: Text("🔦 About Us\n",),
    //
    //           titleTextStyle: Const.font_900_20(context),
    //           subtitleTextStyle:Const.font_700_14(context,size:SC.from_width(12),color: Color.fromRGBO(190, 190, 190, 1))?.copyWith(
    //               height: SC.from_width(1.5)
    //           ) ,
    //           subtitle: Text(
    //
    //               "Syncbel ek innovative platform hai jo smart bulb tracking aur reward system ke zariye lighting industry mein ek nayi roshni laa raha hai. Humne is app ko isliye design kiya hai taaki users aur shop owners dono bulbs ke QR ya barcodes scan karke coins kama sakein, rewards jeet sakein, aur defective products ko asaani se replace kar sakein."),
    //         ),
    //
    //
    //
    //         //
    //         ListTile(
    //           contentPadding: EdgeInsets.symmetric(horizontal: 21),
    //           title: Text("🎯 Our Mission\n",),
    //
    //           titleTextStyle: Const.font_900_20(context),
    //           subtitleTextStyle:Const.font_700_14(context,size:SC.from_width(12),color: Color.fromRGBO(190, 190, 190, 1))?.copyWith(
    //               height: SC.from_width(1.5)
    //           ) ,
    //           subtitle: Text("Hamara mission hai ki:\n"
    //               " - Users: Apne ghar ke bulbs scan karke rewards aur prize jeet sakte hain.\n"
    //               " - Shop Owners: Har bulb scan par coins kamaate hain, jise future mein reward points mein convert kiya ja sakta hai.\n"
    //
    //           ),
    //         ),
    //
    //
    //
    //         ListTile(
    //           contentPadding: EdgeInsets.symmetric(horizontal: 21),
    //           title: Text("👥 Who Can Use This App?\n",),
    //
    //           titleTextStyle: Const.font_900_20(context),
    //           subtitleTextStyle:Const.font_700_14(context,size:SC.from_width(12),color: Color.fromRGBO(190, 190, 190, 1))?.copyWith(
    //               height: SC.from_width(1.5)
    //           ) ,
    //           subtitle: Text(
    //
    //               "- Every user or shop owner can scan QR codes or barcodes on bulbs through our app.Users: Apne ghar ke bulbs scan karke rewards aur prize jeet sakte hain.\n"
    //                   "- Shop Owners: Har bulb scan par coins kamaate hain, jise future mein reward points mein convert kiya ja sakta hai.\n"
    //           ),
    //         ),
    //
    //         ListTile(
    //           contentPadding: EdgeInsets.symmetric(horizontal: 21),
    //           title: Text("🎁 Rewards & Replacements\n",),
    //
    //           titleTextStyle: Const.font_900_20(context),
    //           subtitleTextStyle:Const.font_700_14(context,size:SC.from_width(12),color: Color.fromRGBO(190, 190, 190, 1))?.copyWith(
    //               height: SC.from_width(1.5)
    //           ) ,
    //           subtitle: Text(
    //
    //               "- Har scan par aapko milte hain reward coins.\n"
    //                   "- Kabhi kabhi Admin aapko assign karta hai special prizes.\n"
    //                   "- Agar koi bulb defective nikle, toh uska replacement process fast aur simple hai.\n"
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
          title: Text("About Us"),
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

                    snapshot.data?.data?.aboutUs??'',
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
