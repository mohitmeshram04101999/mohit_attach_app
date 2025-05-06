import 'package:attach/componant/coustom_text_field.dart';
import 'package:attach/componant/custome_action_button.dart';
import 'package:attach/componant/selectioButton.dart';
import 'package:attach/const/app_constante.dart';
import 'package:attach/myfile/action%20Button.dart';
import 'package:attach/myfile/screen_dimension.dart';
import 'package:flutter/material.dart';

class BankBottomSheet extends StatefulWidget {
  const BankBottomSheet({super.key});

  @override
  State<BankBottomSheet> createState() => _BankBottomSheetState();
}

class _BankBottomSheetState extends State<BankBottomSheet> {


  String op = 'bank';


  @override
  Widget build(BuildContext context) {
    return BottomSheet(
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
                  onTap: (){op='bank';setState(() {

                  });},
                selected: op == 'bank',
                  label: "Add Bank"
              ),
              SizedBox(width: SC.from_width(12),),
              SelectionButton(
                onTap: (){op='upi';setState(() {

                });},
                  selected: op == 'upi',
                  label: "Add UPI")
            ],),
            


            if(op=='upi')...[
              SizedBox(height: SC.from_width(20),),
              CustomTextField(
                label: 'Your UPI ID',
                hintText: 'Enter Your UPI ID',
              ),
              SizedBox(height: SC.from_width(35),),
            ]
            else...[
              SizedBox(height: SC.from_width(20),),
              CustomTextField(
                label: 'Bank Account holder name',
                hintText: 'Enter full name',

              ),
              SizedBox(height: SC.from_width(12),),


              CustomTextField(
                label: 'Account  number',
                hintText: 'Enter your account number',

              ),

              SizedBox(height: SC.from_width(12),),
              CustomTextField(
                label: 'IFSC code',
                hintText: 'Enter your IFSC code',

              ),
              SizedBox(height: SC.from_width(36),),
            ],
            
            SizedBox(
              height: SC.from_width(48),
                child: CustomActionButton(action: (){},lable: 'Submit',)),
            SizedBox(height: 20,)

          ],
        ),
      );

    },);
  }
}
