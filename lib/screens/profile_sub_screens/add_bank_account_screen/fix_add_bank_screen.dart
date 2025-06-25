
import 'package:attach/componant/bankAccountCard.dart';
import 'package:attach/const/app_constante.dart';
import 'package:attach/myfile/screen_dimension.dart';
import 'package:attach/providers/bank_account_provider.dart';
import 'package:attach/screens/profile_sub_screens/add_bank_account_screen/bottomeSheet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddBankScreen extends StatefulWidget {
  const AddBankScreen({super.key});

  @override
  State<AddBankScreen> createState() => _AddBankScreenState();
}

class _AddBankScreenState extends State<AddBankScreen> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<BankProvider>(context,listen: false).getAllAccount(context);
  }

  @override
  Widget build(BuildContext context) {
    return  Consumer<BankProvider>(
      builder: (context, p, child) => WillPopScope(
        onWillPop: ()async{
          p.clear();
          return true;
        },
        child: Scaffold(
          appBar: AppBar(

            title: Text("Bank Accounts"),
            centerTitle: false,

            actions: [
              ElevatedButton(onPressed: (){

                showModalBottomSheet(context: context,
                  isScrollControlled: true,
                  builder: (context) => BankBottomSheet(),);


              },

                  style:  ButtonStyle(
                      elevation: WidgetStateProperty.resolveWith((states) => 0,),
                      shape: WidgetStateOutlinedBorder.resolveWith((states) => LinearBorder.none,),
                      backgroundColor: WidgetStateColor.resolveWith((states) => Colors.transparent,),
                      foregroundColor: WidgetStateColor.resolveWith((states) => Colors.white,),
                      iconColor: WidgetStateColor.resolveWith((states) => Colors.white,),
                      textStyle: WidgetStateTextStyle.resolveWith((states) => TextStyle(fontWeight: FontWeight.w700,fontSize: SC.from_width(15)),)

                  )
                  ,child: Row(children: [
                Icon(Icons.add),
                SizedBox(width: SC.from_width(5),),
                Text("Add Bank")
              ],))
            ],
          ),



          body: p.loading?Center(
            child: CircularProgressIndicator(),
          ):(p.account.isEmpty)? Center(child:
          Padding(

            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

              Image.asset("assets/onboard/bankImage.png"),

                Text("No Account Found",style: Const.inter_700_21(context),),
                SizedBox(height: SC.from_width(12),),

                Text("No account added yet. Once you add an account, it will appear here automatically.",
                  style: Const.inter_400_11(context,color: Color.fromRGBO(175, 175, 175, 1)),
                textAlign: TextAlign.center,)

            ],),
          ),):
          RefreshIndicator(
            color: Colors.white,
            onRefresh: ()async{
              p.getAllAccount(context);
            },
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 14,vertical: 20),
              itemCount: p.account.length,
              separatorBuilder: (context, index) => SizedBox(height: SC.from_width(15),),
              itemBuilder: (context, i) => BankAccountCard(account: p.account[i]) ,
            ),
          ),
        ),
      ),
    );
  }
}
