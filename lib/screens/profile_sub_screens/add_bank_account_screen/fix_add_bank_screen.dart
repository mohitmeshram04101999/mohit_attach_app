import 'package:attach/componant/coustom_text_field.dart';
import 'package:attach/componant/custome_action_button.dart';
import 'package:attach/componant/selectioButton.dart';
import 'package:attach/const/app_constante.dart';
import 'package:attach/myfile/screen_dimension.dart';
import 'package:attach/screens/profile_sub_screens/add_bank_account_screen/bottomeSheet.dart';
import 'package:flutter/material.dart';

class AddBankScreen extends StatelessWidget {
  const AddBankScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        
        actions: [
          ElevatedButton(onPressed: (){
            showModalBottomSheet(context: context,
              isScrollControlled: true,
              builder: (context) => BankBottomSheet(),);
          }, child: Row(children: [
            Icon(Icons.add),
            SizedBox(width: SC.from_width(5),),
            Text("Add Bank")
          ],))
        ],
      ),



      body: Center(child: Padding(

        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: SC.from_width(40),),
          Image.asset("assets/onboard/bankImage.png"),

            Text("No Account Found",style: Const.inter_700_21(context),),
            SizedBox(height: SC.from_width(12),),

            Text("No account added yet. Once you add an account, it will appear here automatically.",
              style: Const.inter_400_11(context,color: Color.fromRGBO(175, 175, 175, 1)),
            textAlign: TextAlign.center,)

        ],),
      ),),
    );
  }
}
