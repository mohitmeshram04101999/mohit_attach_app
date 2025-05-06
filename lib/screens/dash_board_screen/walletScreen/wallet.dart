import 'package:attach/api/fake_db.dart';
import 'package:attach/componant/transection_histroy_tile.dart';
import 'package:attach/const/app_constante.dart';
import 'package:attach/myfile/screen_dimension.dart';
import 'package:attach/screens/dash_board_screen/walletScreen/wallet_opttion_row.dart';
import 'package:flutter/material.dart';



class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {


  @override
  Widget build(BuildContext context) {
    return SafeArea(child:
    Padding(
      padding: EdgeInsets.symmetric(horizontal: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: SC.from_width(20),),

          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            height: SC.from_width(181),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Const.primeColor,
              borderRadius: BorderRadius.circular(12)
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Wallet Balance",style: Const.font_700_30(context),),
                Text("\$500",style: Const.font_900_20(context,size: SC.from_width(50)),)
              ],
            ),
          ),
          SizedBox(height: SC.from_width(12),),

          // wallet Option
          WalletOptionRow(),
          SizedBox(height: SC.from_width(30),),


          Text("Recent Transactions",style: Const.font_900_20(context),),


          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.symmetric(vertical: 20),
              itemCount: FakeDb.transiction().length,
                separatorBuilder: (context, index) => Divider(
                  height: 5,
                  thickness: .5,
                  color: Colors.grey,
                ),
              itemBuilder: (context, index) => TransectionHistoryTile(map: FakeDb.transiction()[index],),
            ),
          )


        ],

      ),
    ));
  }
}
