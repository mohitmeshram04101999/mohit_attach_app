import 'package:attach/componant/BackButton.dart';
import 'package:attach/componant/custome_action_button.dart';
import 'package:attach/const/app_constante.dart';
import 'package:attach/myfile/screen_dimension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class AddMoneyScreen extends StatelessWidget {
  final bool upi;
  AddMoneyScreen({this.upi = false,super.key});

  final TextEditingController d = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(

        leading: MyBackButton(),

        title: Text('Add Money'),

        actions: [


          IconButton(onPressed: (){},icon: Icon(Icons.info_outline),),




        ],
      ),


      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14),
          child: Column(

            children: [
              SizedBox(height: SC.from_width(30),),

              //
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: SC.from_width(32),
                child: Text("MB",style: TextStyle(
                    fontFamily: 'ProductSans',
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w700,
                    fontSize: SC.from_width(20)
                ),),
              ),
              SizedBox(height: SC.from_width(20),),

              //Account detail

              Text("Mahesh Birla",style: Const.font_900_20(context),),
              SizedBox(height: SC.from_width(14),),

              Text("Recharge your wallet",style: Const.font_500_16(context,color: Color.fromRGBO(190, 190, 190, 1)),),
              SizedBox(height: SC.from_width(40),),

              TextField(
                textAlign: TextAlign.center,
                cursorColor: Colors.white,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                style: Const.font_900_20(context,size: SC.from_width(50)),
                decoration: InputDecoration(
                    hintText: '₹ 0',
                    hintStyle:Const.font_900_20(context,size: SC.from_width(50)) ,
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none

                ),
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("From ",style: Const.font_500_16(context,size: SC.from_width(18),color: Color.fromRGBO(190, 190, 190, 1)),),
                  Text("Razorpay",style: Const.font_500_16(context,size: SC.from_width(18)),),
                  Icon(Icons.keyboard_arrow_down_rounded),
                ],
              ),
              SizedBox(height: SC.from_width(14),),
              CustomActionButton(action: (){},lable: 'Add Money',),
              SizedBox(height: SC.from_width(20),)

            ],
          ),
        ),
      ),

    );
  }
}