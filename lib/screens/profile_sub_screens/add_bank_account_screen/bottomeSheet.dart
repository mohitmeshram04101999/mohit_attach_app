import 'package:attach/componant/coustom_text_field.dart';
import 'package:attach/componant/custom_text_formatters.dart';
import 'package:attach/componant/custome_action_button.dart';
import 'package:attach/componant/selectioButton.dart';
import 'package:attach/const/app_constante.dart';
import 'package:attach/myfile/action%20Button.dart';
import 'package:attach/myfile/screen_dimension.dart';
import 'package:attach/providers/bank_account_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class BankBottomSheet extends StatefulWidget {
  const BankBottomSheet({super.key});

  @override
  State<BankBottomSheet> createState() => _BankBottomSheetState();
}

class _BankBottomSheetState extends State<BankBottomSheet> {



  @override
  Widget build(BuildContext context) {
    return Consumer<BankProvider>(
      builder: (context, p, child) => BottomSheet(
        backgroundColor: Const.primeColor,
        onClosing: (){

        },
        builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            right: 14,
              left: 14,
              bottom:
          MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: SC.from_width(12),),

                Container(decoration: BoxDecoration(color: Colors.white,
                borderRadius: BorderRadius.circular(15,),
                ) ,
                height: SC.from_width(3),width: SC.from_width(57),),


                SizedBox(height: SC.from_width(24),),

              Row(children: [
                SelectionButton(
                    onTap: ()=>p.setAccountType('BANK'),
                  selected: p.accountType == 'BANK',
                    label: "Add Bank"
                ),
                SizedBox(width: SC.from_width(12),),
                SelectionButton(
                  onTap: ()=>p.setAccountType("UPI"),
                    selected: p.accountType == 'UPI',
                    label: "Add UPI")
              ],),



              if(p.accountType=='UPI')...[
                SizedBox(height: SC.from_width(20),),
                CustomTextField(
                  controller: p.upiId,
                  label: 'Your UPI ID',
                  hintText: 'Enter Your UPI ID',
                ),
                SizedBox(height: SC.from_width(35),),
              ]
              else...[

                //
                SizedBox(height: SC.from_width(20),),
                CustomTextField(
                  controller: p.holderName,
                  label: 'Bank Account Holder Name',
                  hintText: 'Enter full name',
                  formatters: [CapitalizeEachWordFormatter()],

                ),
                SizedBox(height: SC.from_width(12),),


                CustomTextField(
                  controller: p.bankAccountNumber,
                  label: 'Account  Number',
                  hintText: 'Enter your account number',
                  keyTyp: TextInputType.number,
                  formatters: [FilteringTextInputFormatter.digitsOnly],

                ),
                SizedBox(height: SC.from_width(12),),
                CustomTextField(
                  controller: p.bankName,
                  label: 'Bank Name',
                  hintText: 'Enter Your Bank Name',


                ),

                SizedBox(height: SC.from_width(12),),
                CustomTextField(
                  controller: p.ifscCode,
                  label: 'IFSC Code',
                  hintText: 'Enter your IFSC code',
                  formatters: [
                    UpperCaseTextFormatter(),
                  ],

                ),
                SizedBox(height: SC.from_width(36),),
              ],

              SizedBox(
                height: SC.from_width(48),
                  child: CustomActionButton(action: ()async{
                     await p.addAccount(context);
                  },lable: 'Submit',)),
              SizedBox(height: 20,)

            ],
          ),
        );

      },),
    );
  }
}
