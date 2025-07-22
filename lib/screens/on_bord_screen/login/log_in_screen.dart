import 'package:attach/componant/auth_fiield.dart';
import 'package:attach/componant/coustom_text_field.dart';
import 'package:attach/componant/custome_action_button.dart';
import 'package:attach/const/app_constante.dart';
import 'package:attach/myfile/myast%20dart%20file.dart';
import 'package:attach/myfile/screen_dimension.dart';
import 'package:attach/providers/auth_provider.dart';
import 'package:attach/providers/my_hleper.dart';
import 'package:attach/screens/on_bord_screen/login/otpScreen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';


class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {

  var validationKey = GlobalKey<FormState>();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<AuthProvider>(context,listen: false).clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Consumer<AuthProvider>(
            builder: (context, p, child) => Form(
              key: validationKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  SizedBox(height: SC.from_width(84),),

                  //
                  Text("Welcome back",style: Const.font_900_34(context),),

                  //
                  Text("Sign In To Continue",style:Const.font_500_16(context),),
                  SizedBox(height: SC.from_width(66),),

                  AuthField(
                    controller: p.phoneNumberController,
                    leading: SizedBox(
                      width: SC.from_width(30),
                      child: AspectRatio(
                        aspectRatio: 1,
                          child: Center(child: Text("+91",style: Const.poppins_500_14(context),))),
                    ),
                    label: 'Phone number',
                    hintText: 'Enter phone',
                    keyTyp: TextInputType.number,
                    formatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(10)
                    ],

                    validator: (d){
                      if(d==null||d.isEmpty)
                        {
                          return "Enter Mobile Number";
                        }
                      if(d.length<10)
                        {
                          return 'Enter 10 Digit Mobile Number';
                        }
                    },

                  ),
                  SizedBox(
                    height: SC.from_width(36),
                  ),

                  CustomActionButton(
                    action: ()async{

                      // MyHelper.snakeBar(context);

                      //
                      if(validationKey.currentState!.validate())
                        {
                          if(kDebugMode)
                            {
                              await p.logIn(context);
                            }
                          else
                            {
                              try {
                                await p.logIn(context);
                              } catch (e) {
                                MyHelper.snakeBar(context,title: 'Error',message: 'Some thing went wrong');
                              }
                            }
                          // RoutTo(context, child: (p0, p1) => OtpScreen(),);
                        }
                    },lable: 'Send OTP',)

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
