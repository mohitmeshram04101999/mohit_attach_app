import 'dart:developer';

import 'package:attach/componant/BackButton.dart';
import 'package:attach/componant/ammount_filed.dart';
import 'package:attach/componant/custome_action_button.dart';
import 'package:attach/const/app_constante.dart';
import 'package:attach/myfile/screen_dimension.dart';
import 'package:attach/providers/bank_account_provider.dart';
import 'package:attach/providers/my_hleper.dart';
import 'package:attach/providers/profileProvider.dart';
import 'package:attach/providers/transection_history_provider.dart';
import 'package:attach/screens/dash_board_screen/walletScreen/wallet_option_bottom_sheet.dart';
import 'package:attach/screens/profile_sub_screens/add_bank_account_screen/bottomeSheet.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class WithdrawScreen extends StatefulWidget {
  final bool upi;
  WithdrawScreen({this.upi = false, super.key});

  @override
  State<WithdrawScreen> createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends State<WithdrawScreen> {
  final TextEditingController d = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    log("Hey this is init state");
    Provider.of<BankProvider>(context,listen: false).getAllAccount(context);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        Provider.of<BankProvider>(context,listen: false).clear();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: MyBackButton(),

          title: Text('Withdraw'),

          actions: [
            // IconButton(onPressed: () {}, icon: Icon(Icons.info_outline))
          ],
        ),

        body: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 14),
            child: Column(
              children: [
                SizedBox(height: SC.from_width(30)),

                //
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: SC.from_width(32),
                  child: Consumer<ProfileProvider>(builder: (context, p, child) => Text(
                    // "MB",
                    (p.user!.name??'').toString().split(" ").map((e)=>e[0]).join("").toUpperCase(),
                    style: TextStyle(fontFamily: 'ProductSans',color: Colors.grey.shade600,fontWeight: FontWeight.w700,fontSize: SC.from_width(20)),),),
                ),
                SizedBox(height: SC.from_width(20)),

                //Account detail
                Consumer<ProfileProvider>(
                  builder:
                      (context, p, child) => Text(
                        p.user?.name ?? "",
                        style: Const.font_900_20(context),
                      ),
                ),
                SizedBox(height: SC.from_width(14)),



                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(child: Consumer<ProfileProvider>(
                      builder:
                          (context, p, child) => Consumer<BankProvider>(

                        builder: (context, b, child) {


                          // return Text("${b.selectedAccount?.type=='UPI'}");

                          if(b.loading)
                          {
                            return Text("loading...");
                          }
                          else if(b.account.isEmpty)
                            {
                              return Text('Add Account',style: Const.font_500_14(context,color: Color.fromRGBO(190, 190, 190, 1)),);
                            }
                          else if(b.selectedAccount==null)
                            {
                              return Text('Select Account',style: Const.font_500_14(context,color: Color.fromRGBO(190, 190, 190, 1)),);
                            }
                          else if(b.selectedAccount?.type=='UPI')
                          {
                            return Text(
                              "UPI ID: ${b.selectedAccount?.upiId ?? 'N/A'}",
                              // (b.selectedAccount?.type=='UPI').toString(),
                              style: Const.font_500_14(
                                context,
                                color: Color.fromRGBO(190, 190, 190, 1),
                              ),
                            );
                          }
                          else
                            {
                              return Column(
                                children: [
                                  Text(
                                    "Banking Name: ${b.selectedAccount?.bankName ?? 'N/A'}",
                                    style: Const.font_500_14(
                                      context,
                                      color: Color.fromRGBO(190, 190, 190, 1),
                                    ),
                                  ),
                                  SizedBox(height: SC.from_width(2.5)),
                                  Text(
                                    "Account No. ${b.selectedAccount?.accountNumber ?? 'N/A'}",
                                    style: Const.font_500_14(
                                      context,
                                      color: Color.fromRGBO(190, 190, 190, 1),
                                    ),
                                  ),
                                ],
                              );
                            }


                        },
                      ),
                    )),



                    IconButton(onPressed: (){
                      showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (context) => WalletOptionBottomSheet());

                    }, icon:Icon(Icons.keyboard_arrow_down_sharp))
                  ],
                ),

                SizedBox(height: SC.from_width(20)),

                AmountFiled(controller: d),
                Spacer(),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Text("From ",style: Const.font_500_16(context,size: SC.from_width(18),color: Color.fromRGBO(190, 190, 190, 1)),),
                //     Text("Pocket",style: Const.font_500_16(context,size: SC.from_width(18)),),
                //     Icon(Icons.keyboard_arrow_down_rounded),
                //   ],
                // ),
                SizedBox(height: SC.from_width(14)),
                SizedBox(
                  height: SC.from_width(48),
                  child: CustomActionButton(
                    action: () async{
                      if(d.text.trim().isEmpty||int.parse(d.text.substring(1))==0) {

                        MyHelper.snakeBar(context, title: "Can Not Add",
                            message: "Enter Amount");
                      }

                      var bankProvider = Provider.of<BankProvider>(context,listen: false);
                      if(bankProvider.selectedAccount!=null)
                        {
                           await Provider.of<TransectionHistoryProvider>(context,listen: false).withdrawMoney(context,
                              int.parse(d.text.substring(1)),bankProvider.selectedAccount!.id!);
                        }
                      else{
                        MyHelper.snakeBar(context, title: "Can Not Add",
                            message: "Select Account");
                      }
                    },
                    lable: 'Withdrawal Request',
                  ),
                ),
                SizedBox(height: SC.from_width(20)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
