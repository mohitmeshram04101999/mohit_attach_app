import 'package:attach/componant/BackButton.dart';
import 'package:attach/componant/coustom_text_field.dart';
import 'package:attach/componant/custom_check_box.dart';
import 'package:attach/componant/custom_text_formatters.dart';
import 'package:attach/componant/custome_action_button.dart';
import 'package:attach/const/app_constante.dart';
import 'package:attach/myfile/myast%20dart%20file.dart';
import 'package:attach/myfile/screen_dimension.dart';
import 'package:attach/providers/my_hleper.dart';
import 'package:attach/providers/profileProvider.dart';
import 'package:attach/screens/on_bord_screen/login/language_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({super.key});

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {


  final key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: MyBackButton()),

      body: Consumer<ProfileProvider>(

        builder: (context, p, child) =>  Form(
          key: key,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 14, vertical: 16),
            children: [
              Text("Complete Your\nProfile", style: Const.font_900_34(context)),

              SizedBox(height: SC.from_width(21)),

              //
              CustomTextField(
                controller: p.nameController,
                  label: 'Full Name',
                  hintText: 'Enter Full Name',
                validator: (d){
                  if(d==null||d.isEmpty)
                    {
                      return 'Enter Full Name';
                    }
                  else if(d.length<3)
                    {
                      return 'Name Contain At Least 3 Character';
                    }

                },
                formatters: [CapitalizeEachWordFormatter()],
              ),
              SizedBox(height: SC.from_width(20)),

              //
              CustomTextField(
                controller: p.mailController,
                  label: 'Your Email',
                  hintText: 'Enter Your Email',
                validator: (d) {
                  if (d == null || d.isEmpty) {
                    return 'Enter your email';
                  }

                  // General email regex
                  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

                  if (!emailRegex.hasMatch(d)) {
                    return 'Enter a valid email address';
                  }

                  return null; // Valid
                },
              ),
              SizedBox(height: SC.from_width(20)),


              CustomTextField(
                controller: p.ageController,
                label: 'Age',
                hintText: 'Enter Your Age',
                keyTyp: TextInputType.number,
                formatters: [
                  FilteringTextInputFormatter.digitsOnly
                ],
                validator: (d){
                  if(d==null||d.isEmpty)
                  {
                    return 'Enter Your Age';
                  }
                },
              ),
              SizedBox(height: SC.from_width(20)),

              //Gender Selection
              Text("Gender", style: TextStyle()),
              SizedBox(height: SC.from_width(10)),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.white),
                ),
                child: Column(
                  children: [
                    //male
                    ListTile(
                      contentPadding: EdgeInsets.only(
                        left: 14,
                      ),
                      title: Text('Male'),
                      trailing: CustomCheckBox(
                        borderColor: Colors.transparent,
                        value: p.gender == 'MALE',
                        onChange: (d) {
                          p.setGender('MALE');

                        },
                      ),

                      onTap: () {
                        p.setGender("MALE");

                      },
                    ),
                    Divider(endIndent: 8, indent: 8, height: 0),

                    //female
                    ListTile(
                      contentPadding: EdgeInsets.only(
                        left: 14,
                      ),
                      title: Text('Female'),
                      trailing: CustomCheckBox(
                        borderColor: Colors.transparent,
                        value: p.gender == 'FEMALE',
                        onChange: (d) {
                          p.setGender("FEMALE");
                        },
                      ),
                      onTap: () {
                        p.setGender("FEMALE");
                      },
                    ),
                    Divider(endIndent: 8, indent: 8, height: 0),

                    //other
                    ListTile(
                      contentPadding: EdgeInsets.only(
                        left: 14,
                      ),
                      title: Text('Other'),
                      trailing: CustomCheckBox(
                        borderColor: Colors.transparent,
                        value: p.gender == 'OTHER',
                        onChange: (d) {
                          p.setGender("OTHER");
                        },
                      ),
                      onTap: () {
                        p.setGender('OTHER');

                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: SC.from_width(40)),

              CustomActionButton(
                action: ()async{


                  if(key.currentState!.validate())
                    {
                      if(p.gender==null)
                        {
                          MyHelper.snakeBar(context, title: "Gender", message: "Select Gender");
                          return;
                        }
                      RoutTo(context, child: (p0, p1) =>  LanguageScreen()) ;
                    }
                  // RoutTo(context, child: (p0, p1) => LanguageScreen());
                },
                lable: 'Update',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
