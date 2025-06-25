import 'package:attach/const/app_constante.dart';
import 'package:attach/modles/usertype.dart';
import 'package:attach/myfile/myast%20dart%20file.dart';
import 'package:attach/myfile/screen_dimension.dart';
import 'package:attach/providers/profileProvider.dart';
import 'package:attach/screens/dash_board_screen/walletScreen/wallet_option_bottom_sheet.dart';
import 'package:attach/screens/profile_sub_screens/add_bank_account_screen/fix_add_bank_screen.dart';
import 'package:attach/screens/wallet_sub_screen/add_mony.dart';
import 'package:attach/screens/wallet_sub_screen/transection_history_screen.dart';
import 'package:attach/screens/wallet_sub_screen/withdraw_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class WalletOptionRow extends StatefulWidget {
  const WalletOptionRow({super.key});

  @override
  State<WalletOptionRow> createState() => _WalletOptionRowState();
}

class _WalletOptionRowState extends State<WalletOptionRow> {





  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SC.from_width(72),
      child: Row(children: [

        //
        Expanded(child: Ink(

          decoration: BoxDecoration(
            color: Const.primeColor,
            borderRadius: BorderRadius.circular(8)
          ),
          child: InkWell(
            onTap: (){
              RoutTo(context, child:(p0, p1) =>  TransectionHistoryScreen());
            },
            borderRadius: BorderRadius.circular(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/icons/wallet/history.png',width: SC.from_width(20),),
                SizedBox(height: SC.from_width(5),),
                Text("History",style: Const.font_500_12(context),)
              ],
            ),
          ),
        )),



        Consumer<ProfileProvider>(builder: (context, p, child) => SizedBox(width: SC.from_width((p.user?.userType==UserType.user?0:11)),),),



        //
        Consumer<ProfileProvider>(builder: (context, p, child) {


          if(p.user?.userType==UserType.user)
            {
              return SizedBox(width: SC.from_width(11),);
            }

          return Expanded(child: Ink(

            decoration: BoxDecoration(
                color: Const.primeColor,
                borderRadius: BorderRadius.circular(8)
            ),
            child: InkWell(
              onTap: (){
                RoutTo(context, child: (p0, p1) => WithdrawScreen(),);
              },
              borderRadius: BorderRadius.circular(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/icons/wallet/wallet.png',width: SC.from_width(22),),
                  SizedBox(height: SC.from_width(5),),
                  Text("withdraw",style: Const.font_500_12(context),)
                ],
              ),
            ),
          ));
        },),


        Consumer<ProfileProvider>(builder: (context, p, child) => SizedBox(width: SC.from_width((p.user?.userType==UserType.user?0:11)),),),
  

        //
        Expanded(child: Ink (

          decoration: BoxDecoration(
              color: Const.primeColor,
              borderRadius: BorderRadius.circular(8)
          ),
          child: InkWell(
            onTap: (){

              RoutTo(context, child: (p0, p1) => AddMoneyScreen(),);
            },
            borderRadius: BorderRadius.circular(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/icons/wallet/add.png',width: SC.from_width(20),),
                SizedBox(height: SC.from_width(5),),
                Text("Add Money",style: Const.font_500_12(context),)
              ],
            ),
          ),
        )),

      ],),
    );
  }
}
