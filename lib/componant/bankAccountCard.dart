import 'package:attach/const/app_constante.dart';
import 'package:attach/modles/get_All_Bank.dart';
import 'package:attach/myfile/screen_dimension.dart';
import 'package:flutter/material.dart';


class BankAccountCard extends StatelessWidget {
  final TransectionAccount account;
  const BankAccountCard({required this.account,super.key});

  @override
  Widget build(BuildContext context) {

     if(account.type=="BANK")
       {
         return Container(
           padding: EdgeInsets.symmetric(horizontal: 15,vertical: 13),
           decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(7),
               border: Border.all(
                   color: Colors.white,
                   width: 1
               )
           ),
           child: Row(
             children: [
               Image.asset("assets/icons/wallet/bank_logo.png",width: SC.from_width(50),),
               SizedBox(width: SC.from_width(13),),

               Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Text("${account.bankName}",style: Const.font_500_18(context),),
                   Text("IFSC Code : ${account.ifscCode}",style:  Const.font_500_18(context,size: SC.from_width(10))),

                   Text("A/C no. : ${account.accountNumber}",style:  Const.font_500_18(context,size: SC.from_width(10)),),
                 ],
               )
             ],
           ),
         );

       }
     else
       {
         return Container(
           padding: EdgeInsets.symmetric(horizontal: 15,vertical: 20),
           decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(7),
               border: Border.all(
                   color: Colors.white,
                   width: 1
               )
           ),
           child: Row(
             children: [
               Image.asset("assets/icons/wallet/upi_logo.png",width: SC.from_width(50),),
               SizedBox(width: SC.from_width(13),),
               Text("${account.upiId}",style: Const.font_500_18(context),),
             ],
           ),
         );

       }
  }
}
