import 'package:attach/componant/BackButton.dart';
import 'package:attach/componant/coustom_text_field.dart';
import 'package:attach/componant/profile_aVTAR.dart';
import 'package:attach/const/app_constante.dart';
import 'package:attach/myfile/screen_dimension.dart';
import 'package:flutter/material.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        leading: MyBackButton(),
        title: Text('Edit Profile'),
      ),

      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 14,vertical: 20),
        children: [


        Center(child: ProfileAvtar()),
        SizedBox(height: SC.from_width(10),),

        Center(child: Text("Change profile picture",style: Const.font_700_16(context,color: Const.yellow),)),
        SizedBox(height: SC.from_width(10),),


          //
          CustomTextField(
            label: 'Full Name',
          ),
          SizedBox(height: SC.from_width(20),),

          //
          CustomTextField(
            label: 'Gender',
          ),
          SizedBox(height: SC.from_width(20),),


          //
          CustomTextField(
            label: 'Language',
          ),
          SizedBox(height: SC.from_width(20),),

          //
          CustomTextField(
            maxLine: 8,
            label: 'Enter your bio',

          ),
          SizedBox(height: SC.from_width(20),),


      ],),

    );
  }
}
