

import 'package:attach/componant/BackButton.dart';
import 'package:attach/componant/custome_action_button.dart';
import 'package:attach/const/app_constante.dart';
import 'package:attach/myfile/myast%20dart%20file.dart';
import 'package:attach/myfile/screen_dimension.dart';
import 'package:attach/providers/auth_provider.dart';
import 'package:attach/screens/on_bord_screen/login/complit_profile.dart';
import 'package:attach/screens/on_bord_screen/login/resend_otp_widget.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';


class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {

  var key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      //
      appBar: AppBar(
        leading: MyBackButton(),
      ),


      body: Consumer<AuthProvider>(
        builder: (context, p, child) => Padding(padding: EdgeInsets.symmetric(horizontal: 14),child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: SC.from_width(20),),

              //
              Text("Verification Code",style: Const.font_900_34(context),),
              SizedBox(height: SC.from_width(8),),


              //
              Text('We have send the code verification to  +91 ${p.phoneNumberController.text.trim()}',style: Const.font_500_16(context),),
              SizedBox(height: SC.from_width(36),),

              Center(
                child: Pinput(
                  controller: p.otpController,
                  validator: (d){
                    if(d==null||d.isEmpty)
                      {
                        return 'Enter Otp';
                      }
                    if(d.length<4)
                      {
                        return 'Enter 4 Digit Otp';
                      }
                  },
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  length: 4,

                  defaultPinTheme: PinTheme(

                    textStyle: TextStyle(
                      fontSize: SC.from_width(24),
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Poppins'
                    ),
                    decoration: BoxDecoration(
                      color: Const.primeColor,

                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.white)
                    ),
                    height: SC.from_width(SC.from_width(60)),
                    width: SC.from_width(SC.from_width(60)),

                  ),
                ),
              ),
              SizedBox(height: SC.from_width(20),),

              //Counter
              ResendOtpWidget(onTap: (){p.resendOtp(context);},),
              SizedBox(height: SC.from_width(92),),
              CustomActionButton(
                action: () async {
                  await p.verifyOtp(context);
              },lable: 'Verify',)

          ],),
        ),),
      ),



    );
  }
}



