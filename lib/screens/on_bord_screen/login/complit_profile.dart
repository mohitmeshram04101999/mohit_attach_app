import 'package:attach/componant/BackButton.dart';
import 'package:attach/componant/coustom_text_field.dart';
import 'package:attach/componant/custome_action_button.dart';
import 'package:attach/const/app_constante.dart';
import 'package:attach/myfile/myast%20dart%20file.dart';
import 'package:attach/myfile/screen_dimension.dart';
import 'package:attach/screens/on_bord_screen/login/language_screen.dart';
import 'package:flutter/material.dart';



class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({super.key});

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {

  String gender ='';

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        leading: MyBackButton(),
      ),


      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 14,vertical: 16),
        children: [

          Text("Complete Your\nProfile",style: Const.font_900_34(context),),

          SizedBox(height: SC.from_width(21),),


          //
          CustomTextField(
            label: 'Full Name',
            hintText: 'Enter Full Name',
          ),
          SizedBox(height: SC.from_width(20),),


          //
          CustomTextField(
            label: 'Your Email',
            hintText: 'Enter Your Email',
          ),
          SizedBox(height: SC.from_width(20),),


          //Gender Selection
          Text("Gender",style: TextStyle(),),
          SizedBox(height: SC.from_width(10),),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Colors.white,
              )
            ),
            child: Column(children: [

              //
              CheckboxListTile(

                title: Text('Male'),value: gender=='male',onChanged: (d){
                  gender = 'male';
                  setState(() {

                  });
              },),
              Divider(endIndent: 8,indent: 8,height: 0,),

              //
              CheckboxListTile(title: Text('Female'),value: gender=='female',onChanged: (d){
                gender = 'female';
                setState(() {

                });
              },),
              Divider(endIndent: 8,indent: 8,height: 0,),

              //
              CheckboxListTile(title: Text('Other'),value: gender=='other',onChanged: (d){
                gender = 'other';
                setState(() {

                });
              },),
            ],),
          ),
          SizedBox(height: SC.from_width(40),),


          CustomActionButton(action: (){
            RoutTo(context, child: (p0, p1) => LanguageScreen(),);
          },lable: 'Update',)


        ],
      ),

    );
  }
}
