import 'package:attach/const/app_constante.dart';
import 'package:attach/myfile/myast%20dart%20file.dart';
import 'package:attach/myfile/screen_dimension.dart';
import 'package:attach/screens/wallet_sub_screen/add_mony.dart';
import 'package:flutter/material.dart';

class WalletOptionBottomSheet extends StatefulWidget {
  const WalletOptionBottomSheet({super.key});

  @override
  State<WalletOptionBottomSheet> createState() => _WalletOptionBottomSheetState();
}

class _WalletOptionBottomSheetState extends State<WalletOptionBottomSheet> {

  String bank='SBI';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: SC.from_width(60),),
          Text("Choose Bank ",style: Const.font_900_20(context),),
          SizedBox(height: SC.from_width(20),),

          Row(
            children: [

              //
              CircleAvatar(
                radius: SC.from_width(20),
                backgroundColor: Colors.white,
                child: Text("SBI",
                  style: Const.font_500_14(context,color: Colors.grey),),
              ),
              SizedBox(width: SC.from_width(10),),


              Expanded(
                child: RadioListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 0),
                  value: 'SBI',
                  controlAffinity:ListTileControlAffinity.trailing ,
                  onChanged: (d){
                    RoutTo(context, child: (p0, p1) => AddMoneyScreen(),);
                    bank = d??'';

                    setState(() {

                    });

                  },
                  groupValue:bank ,

                  title: Text("SBI (State Bank of India) ",style: Const.font_500_14(context),),

                ),
              ),
            ],
          ),


          Row(
            children: [
              CircleAvatar(
                radius: SC.from_width(20),
                backgroundColor: Colors.white,
                child: Text("PNB",
                  style: Const.font_500_14(context,color: Colors.grey),),
              ),
              SizedBox(width: SC.from_width(10),),

              Expanded(
                child: RadioListTile(
                  value: 'PNB',
                  contentPadding: EdgeInsets.symmetric(horizontal: 0),
                  controlAffinity:ListTileControlAffinity.trailing ,
                  onChanged: (d){
                    bank = d??'';
                    RoutTo(context, child: (p0, p1) => AddMoneyScreen(),);
                    setState(() {

                    });
                  },
                  groupValue:bank ,
                  title: Text("PNB (Punjab National Bank) ",style: Const.font_500_14(context)),
                ),
              ),
            ],
          ),


          Row(
            children: [
              CircleAvatar(
                radius: SC.from_width(20),
                backgroundColor: Colors.white,
                child: Text("BOB",
                  style: Const.font_500_14(context,color: Colors.grey),),
              ),
              SizedBox(width: SC.from_width(10),),


              Expanded(
                child: RadioListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 0),
                  controlAffinity:ListTileControlAffinity.trailing ,
                  value: 'BOB',
                  onChanged: (d){
                    bank = d??'';
                    RoutTo(context, child: (p0, p1) => AddMoneyScreen(),);
                    setState(() {

                    });
                  },
                  groupValue:bank ,
                  title: Text("BOB (Bank of Baroda) ",style: Const.font_500_14(context)),
                ),
              ),
            ],
          ),

          //
          SizedBox(height: SC.from_width(20),),
        ],
      ),

    );
  }
}
