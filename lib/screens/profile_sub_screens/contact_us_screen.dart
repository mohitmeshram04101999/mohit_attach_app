import 'package:attach/componant/coustom_text_field.dart';
import 'package:attach/componant/custome_action_button.dart';
import 'package:attach/const/app_constante.dart';
import 'package:attach/myfile/screen_dimension.dart';
import 'package:flutter/material.dart';


class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        centerTitle: false,
        title: Text("Contact Us"),
      ),
      
      
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 23,vertical: 20),
        children: [
          
          Text("Get in Touch",style: Const.font_900_20(context,size: SC.from_width(27)),),
          Text("24/7 we will answer your questions and problems",style: Const.font_400_16(context,size: SC.from_width(14),color: Colors.grey),),
          SizedBox(height: SC.from_width(25),),

          //name
          CustomTextField(
            label:'Name' ,
            hintText: 'Enter name',
          ),
          SizedBox(height: SC.from_width(15),),

          //email
          CustomTextField(
            label:'Email id' ,
            hintText: 'Enter email',
          ),
          SizedBox(height: SC.from_width(15),),



          //phone Number
          CustomTextField(
            label:'Phone number' ,
            hintText: 'Enter phone number',
          ),
          SizedBox(height: SC.from_width(15),),


          //message
          CustomTextField(
            maxLine: 5,
            label:'Message' ,
            hintText: 'Describe your issue ',
          ),
          SizedBox(height: SC.from_width(60),),
          
          SizedBox(
            height: SC.from_width(49),
              child: CustomActionButton(action: (){},lable: 'Submit',)),





        ],
      ),
      
    );
  }
}
