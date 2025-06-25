import 'package:attach/const/app_constante.dart';
import 'package:attach/modles/get_All_Bank.dart';
import 'package:attach/myfile/action%20Button.dart';
import 'package:attach/myfile/myast%20dart%20file.dart';
import 'package:attach/myfile/screen_dimension.dart';
import 'package:attach/providers/bank_account_provider.dart';
import 'package:attach/screens/profile_sub_screens/add_bank_account_screen/fix_add_bank_screen.dart';
import 'package:attach/screens/wallet_sub_screen/add_mony.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WalletOptionBottomSheet extends StatefulWidget {
  const WalletOptionBottomSheet({super.key});

  @override
  State<WalletOptionBottomSheet> createState() => _WalletOptionBottomSheetState();
}

class _WalletOptionBottomSheetState extends State<WalletOptionBottomSheet> {

  String bank='SBI';

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: BottomSheet(
        enableDrag: true,
        backgroundColor: Const.primeColor,
        onClosing: (){},
        builder:(context) =>
            Consumer<BankProvider>(
          builder: (context, p, child) {
            if(p.account.isEmpty)
              {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MyactionButton(
                    lable: 'Add Bank',
                      action: (){
                    RoutTo(context, child: (p0, p1) => AddBankScreen(),);
                  }),
                );
              }

            return  Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: SC.from_width(60),),
                  Text("Choose Bank ",style: Const.font_900_20(context),),
                  SizedBox(height: SC.from_width(20),),

                  for(TransectionAccount a in p.account )
                    Row(
                      children: [
                        //
                        CircleAvatar(
                          radius: SC.from_width(20),
                          backgroundColor: Colors.white,
                          child: FittedBox(
                            child: Text((a.bankName??a.upiId??"").split(' ').map((e)=>(e.isNotEmpty)?e[0].toUpperCase():'').join(),
                              style: Const.font_500_14(context,color: Colors.grey),),
                          ),
                        ),
                        SizedBox(width: SC.from_width(10),),


                        Expanded(
                          child: RadioListTile(
                            contentPadding: EdgeInsets.symmetric(horizontal: 0),
                            value: a.id,
                            controlAffinity:ListTileControlAffinity.trailing ,
                            onChanged: (d){
                              p.setBank(a);
                            },
                            groupValue:p.selectedAccount?.id,

                            title: Text(a.bankName??a.upiId??'N/A',style: Const.font_500_14(context),),

                          ),
                        ),
                      ],
                    ),

                  //
                  SizedBox(height: SC.from_width(20),),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
