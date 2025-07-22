// import 'package:attach/api/transection_api.dart';
// import 'package:attach/componant/BackButton.dart';
// import 'package:attach/componant/custom_text_formatters.dart';
// import 'package:attach/componant/custome_action_button.dart';
// import 'package:attach/const/app_constante.dart';
// import 'package:attach/myfile/screen_dimension.dart';
// import 'package:attach/providers/my_hleper.dart';
// import 'package:attach/providers/transection_history_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:provider/provider.dart';
//
//
// class AddMoneyScreen extends StatelessWidget {
//   final bool upi;
//   AddMoneyScreen({this.upi = false,super.key});
//
//   final TextEditingController d = TextEditingController();
//   final FocusNode _focusNode = FocusNode();
//
//   @override
//   Widget build(BuildContext context) {
//
//
//
//     return WillPopScope(
//       onWillPop: ()async{
//         Provider.of<TransectionHistoryProvider>(context,listen: false).amountController.clear();
//
//         return true;
//       },
//       child: Scaffold(
//
//         appBar: AppBar(
//
//           leading: MyBackButton(),
//
//           title: Text('Add Money'),
//
//           actions: [
//
//
//             IconButton(onPressed: (){},icon: Icon(Icons.info_outline),),
//
//
//
//
//           ],
//         ),
//
//
//         body: Consumer<TransectionHistoryProvider>(
//           builder: (context, p, child) =>  Center(
//             child: Padding(
//               padding: EdgeInsets.symmetric(horizontal: 14),
//               child: Column(
//
//                 children: [
//                   SizedBox(height: SC.from_width(30),),
//
//                   //
//                   CircleAvatar(
//                     backgroundColor: Colors.white,
//                     radius: SC.from_width(32),
//                     child: Text("MB",style: TextStyle(
//                         fontFamily: 'ProductSans',
//                         color: Colors.grey.shade600,
//                         fontWeight: FontWeight.w700,
//                         fontSize: SC.from_width(20)
//                     ),),
//                   ),
//                   SizedBox(height: SC.from_width(20),),
//
//                   //Account detail
//
//                   Text("Mahesh Birla",style: Const.font_900_20(context),),
//                   SizedBox(height: SC.from_width(8),),
//
//                   Text("Recharge your wallet",style: Const.font_500_14(context,color: Color.fromRGBO(190, 190, 190, 1)),),
//                   SizedBox(height: SC.from_width(40),),
//
//                   TextField(
//                     autofocus: false,
//
//
//                     onChanged: (d){
//                       print("on Chnasge");
//                     },
//                     onTap: () {
//
//                     },
//                     controller: d,
//                     textAlign: TextAlign.center,
//                     cursorColor: Colors.white,
//                     keyboardType: TextInputType.number,
//                     inputFormatters: [
//                       MoneyInputFormatter()
//                     ],
//                     style: Const.font_900_20(context,size: SC.from_width(30)),
//                     decoration: InputDecoration(
//                         hintText: '₹ 0',
//                         hintStyle:Const.font_900_20(context,size: SC.from_width(30)) ,
//                         border: InputBorder.none,
//                         focusedBorder: InputBorder.none,
//                         enabledBorder: InputBorder.none,
//                         focusedErrorBorder: InputBorder.none,
//
//                     ),
//                   ),
//
//
//                   Spacer(),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text("From ",style: Const.font_500_16(context,color: Color.fromRGBO(190, 190, 190, 1)),),
//                       SizedBox(width: SC.from_width(10),),
//                       Text("Razorpay",style: Const.font_500_16(context),),
//                       Icon(Icons.keyboard_arrow_down_rounded),
//                     ],
//                   ),
//                   SizedBox(height: SC.from_width(14),),
//                   SizedBox(
//                     height: SC.from_width(48),
//                       child: CustomActionButton(action: ()async{
//
//                         if(d.text.trim().isEmpty||int.parse(d.text.substring(1))==0)
//                           {
//                             MyHelper.snakeBar(context, title: "Can Not Add", message: "Enter Amount");
//                           }
//                         else
//                           {
//                             await p.addMoneyInWallet(context, int.parse(d.text.substring(1)),
//                             onDone: (){
//                               Navigator.pop(context);
//                             });
//                           }
//
//                       },lable: 'Add Money',)),
//                   SizedBox(height: SC.from_width(20),)
//
//                 ],
//               ),
//             ),
//           ),
//         ),
//
//       ),
//     );
//   }
// }



import 'package:attach/api/transection_api.dart';
import 'package:attach/componant/BackButton.dart';
import 'package:attach/componant/ammount_filed.dart';
import 'package:attach/componant/custom_text_formatters.dart';
import 'package:attach/componant/custome_action_button.dart';
import 'package:attach/const/app_constante.dart';
import 'package:attach/myfile/screen_dimension.dart';
import 'package:attach/providers/my_hleper.dart';
import 'package:attach/providers/profileProvider.dart';
import 'package:attach/providers/transection_history_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class AddMoneyScreen extends StatefulWidget {
  final bool upi;
  AddMoneyScreen({this.upi = false, super.key});

  @override
  State<AddMoneyScreen> createState() => _AddMoneyScreenState();
}

class _AddMoneyScreenState extends State<AddMoneyScreen> {
  final TextEditingController _amountController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // Request focus after the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _amountController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Provider.of<TransectionHistoryProvider>(context, listen: false)
            .amountController
            .clear();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: MyBackButton(),
          title: Text('Add Money'),
          actions: [
            // IconButton(
            //   onPressed: () {},
            //   icon: Icon(Icons.info_outline),
            // ),
          ],
        ),
        body: Consumer<TransectionHistoryProvider>(
          builder: (context, p, child) => Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 14),
              child: Column(
                children: [
                  SizedBox(height: SC.from_width(30)),
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: SC.from_width(32),
                    child: Consumer<ProfileProvider>(
                      builder: (context, p, child) =>   Text(
                        (p.user!.name??'').toString().split(" ").map((e)=>e[0]).join("").toUpperCase(),
                        style: TextStyle(
                            fontFamily: 'ProductSans',
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w700,
                            fontSize: SC.from_width(20)),
                      ),
                    ),
                  ),
                  SizedBox(height: SC.from_width(20)),
                  Consumer<ProfileProvider>(builder: (context, p, child) => Text(p.user?.name ?? "", style: Const.font_900_20(context)),),
                  SizedBox(height: SC.from_width(8)),
                  Text(
                    "Recharge your wallet",
                    style: Const.font_500_14(context,
                        color: Color.fromRGBO(190, 190, 190, 1)),
                  ),
                  SizedBox(height: SC.from_width(40)),
                  GestureDetector(
                    onTap: () {
                      _focusNode.requestFocus();
                    },
                    child: AmountFiled(controller: _amountController,),
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "From ",
                        style: Const.font_500_16(context,
                            color: Color.fromRGBO(190, 190, 190, 1)),
                      ),
                      SizedBox(width: SC.from_width(10)),
                      Text("Razorpay", style: Const.font_500_16(context)),
                      Icon(Icons.keyboard_arrow_down_rounded),
                    ],
                  ),
                  SizedBox(height: SC.from_width(14)),
                  SizedBox(
                    height: SC.from_width(48),
                    child: CustomActionButton(
                      action: () async {
                        if (_amountController.text.trim().isEmpty ||
                            int.parse(_amountController.text.substring(1)) == 0) {
                          MyHelper.snakeBar(context,
                              title: "Can Not Add",
                              message: "Enter Amount");
                        } else {
                          await p.addMoneyInWallet(
                            context,
                            int.parse(_amountController.text.substring(1)),
                            onDone: () {
                              Navigator.pop(context);
                            },
                          );
                        }
                      },
                      lable: 'Add Money',
                    ),
                  ),
                  SizedBox(height: SC.from_width(20))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}