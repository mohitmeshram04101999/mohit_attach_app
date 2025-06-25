import 'dart:convert';

import 'package:attach/api/listners_Api.dart';
import 'package:attach/componant/custom_check_box.dart';
import 'package:attach/componant/custome_action_button.dart';
import 'package:attach/const/app_constante.dart';
import 'package:attach/modles/otp_responce.dart';
import 'package:attach/myfile/action%20Button.dart';
import 'package:attach/myfile/screen_dimension.dart';
import 'package:attach/providers/my_hleper.dart';
import 'package:attach/providers/profileProvider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class ContactRequestDialog extends StatefulWidget {
  final User user;
  const ContactRequestDialog({required this.user,super.key});

  @override
  State<ContactRequestDialog> createState() => _ContactRequestDialogState();
}

class _ContactRequestDialogState extends State<ContactRequestDialog> {



  _sendRequest() async
  {

  }



  String selectedText  = "Please Chat With Me";

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: SC.from_width(40)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: SC.from_width(20),vertical: SC.from_width(20)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [

              Center(
                  child: Text("Listener is busy",style: Const.font_500_16(context,color: Const.yellow),)),
              SizedBox(height: SC.from_width(10),),

              //
              Center(
                  child: Text("Send Message instant?",style: Const.font_500_16(context),)),
              SizedBox(height: SC.from_width(20),),

              //

              Container(
                width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Const.grey_190_190_190),
                    color: Const.scaffoldColor,
                    borderRadius: BorderRadius.only(

                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10)
                    ),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: SC.from_width(20),vertical: SC.from_width(15)),
                  child: Text("Hi ${widget.user.name},\n\nI Want to Talk to You\n$selectedText",style: Const.font_400_14(context),)),
              SizedBox(height: SC.from_width(20),),

              Row(
                mainAxisSize: MainAxisSize.min,
                children: [

                  //
                  CustomRadio<String>(
                      title: "Chat",
                      value: "Please Chat With Me",groupValue: selectedText, onChange: (d){
                    selectedText = d;
                    setState(() {});
                  }),
                  SizedBox(width: SC.from_width(15),),


                  //
                  CustomRadio<String>(
                      title: "Call",
                      value: "Please Call Me",groupValue: selectedText, onChange: (d){
                    selectedText = d;
                    setState(() {});
                  }),
                  SizedBox(width: SC.from_width(15),),

                  //
                  CustomRadio<String>(
                      title: "Video Call",
                      value: "Please Video Call Me",groupValue: selectedText, onChange: (d){
                    selectedText = d;
                    setState(() {});
                  }),
                  SizedBox(width: SC.from_width(10),),

                ],
              ),


              SizedBox(height: SC.from_width(30),),

              Center(
                child: SizedBox(
                  height: SC.from_width(40),
                  width: SC.from_width(180),
                  child: CustomActionButton(
                    action: () async{
                      if(kDebugMode)
                        {
                          await ListenerApi.sendContactRequest(context,widget.user.id??'',
                              'Hi ${widget.user.name},\n\nI Want to Talk to You\n$selectedText', onSuccess: (response) {
                                MyHelper.snakeBar(context,title: 'Success',message: '${jsonDecode(response.body)['message']}',type: SnakeBarType.success);
                                Navigator.pop(context);

                                  });
                        }
                      else
                        {
                          try
                          {
                            await ListenerApi.sendContactRequest(context,widget.user.id??'',
                                'Hi ${widget.user.name},\n\nI Want to Talk to You\n$selectedText', onSuccess: (response) {
                                  MyHelper.snakeBar(context,title: 'Success',message: 'Request Sent',type: SnakeBarType.success);
                                  Navigator.pop(context);
                                });
                          }
                          catch(e)
                          {
                            MyHelper.snakeBar(context,title: 'Error',message: '$e',type: SnakeBarType.error);
                          }
                        }

                    },lable: 'Send Message',),
                ),
              ),

            ],

          ),
        ),
      ),
    );
  }
}
