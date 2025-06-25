import 'package:attach/componant/coustom_text_field.dart';
import 'package:attach/componant/custom_check_box.dart';
import 'package:attach/componant/custome_action_button.dart';
import 'package:attach/componant/dotted_border_button.dart';
import 'package:attach/const/app_constante.dart';
import 'package:attach/myfile/screen_dimension.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class BecomeListenerTabThree extends StatelessWidget {
  const BecomeListenerTabThree({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.only(left: 14, right: 14, bottom: 20),
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: Const.primeColor,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(12),
            bottomRight: Radius.circular(12),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Are you above 18 years of age?",
              style: Const.font_400_14(context),
            ),
            Row(
              children: [
                CustomCheckBox(value: true, onChange: (d) {}),
                Text("Yes", style: Const.font_500_16(context)),
              ],
            ),

            Row(
              children: [
                CustomCheckBox(value: true, onChange: (d) {}),
                Text("No", style: Const.font_500_16(context)),
              ],
            ),
            SizedBox(height: SC.from_width(30)),

            //
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CustomCheckBox(value: true, onChange: (d) {}),
                Expanded(
                  child: Text(
                    "Do you agree to our Terms & Conditions and Privacy Policy?",
                    style: Const.font_400_12(context),
                  ),
                ),
              ],
            ),
            SizedBox(height: SC.from_width(30)),

            Text(
              "Upload Your 3 latest photos",
              style: Const.font_400_14(context),
            ),
            SizedBox(height: SC.from_width(16)),

            GridView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 19,
                mainAxisSpacing: 19,
              ),
              primary: false,
              children: [
                //
                AspectRatio(
                  aspectRatio: 1.0,
                  child: DottedBorderButton(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.file_upload_outlined,
                          size: SC.from_width(20),
                        ),
                        SizedBox(width: SC.from_width(8)),
                        Text("Upload", style: Const.font_400_12(context)),
                      ],
                    ),
                    onTap: () {},
                  ),
                ),

                //
                AspectRatio(
                  aspectRatio: 1.0,
                  child: DottedBorderButton(
                    title: Icon(Icons.add, size: SC.from_width(30)),
                    onTap: () {},
                  ),
                ),
              ],
            ),

            SizedBox(height: SC.from_width(30)),

            SizedBox(
              height: SC.from_width(84),
              child: DottedBorderButton(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.file_upload_outlined, size: SC.from_width(20)),
                    SizedBox(width: SC.from_width(8)),
                    Text("Upload Resume/CV", style: Const.font_400_12(context)),
                  ],
                ),
                onTap: () {
                  // Add functionality to upload resume/CV
                },
              ),
            ),
            SizedBox(height: SC.from_width(8)),
            Text('(optional)', style: Const.font_400_14(context)),

            SizedBox(height: SC.from_width(30)),

            RichText(
              text: TextSpan(
                text: 'Scenario: ',
                style: Const.font_400_16(
                  context,
                  color: Const.yellow,
                ), // Style for the "Scenario:" text
                children: <TextSpan>[
                  TextSpan(
                    text:
                        'If a user starts crying during a session, what will you do?',
                    style: Const.font_400_16(
                      context,
                      color: Colors.white,
                    ), // Style for the scenario description
                  ),
                ],
              ),
            ),
            SizedBox(height: SC.from_width(8)),
            CustomTextField(hintText: 'Please Describe Here', maxLine: 4),

            SizedBox(height: SC.from_width(30)),
            SizedBox(
              height: SC.from_width(84),
              child: DottedBorderButton(

                title: Padding(
                  padding: EdgeInsets.symmetric(horizontal: SC.from_width(28)),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.file_upload_outlined, size: SC.from_width(20)),
                      SizedBox(width: SC.from_width(8)),
                      Expanded(child: Text("Upload a short video/audio introduction about yourself", style: Const.font_400_12(context))),
                    ],
                  ),
                ),
                onTap: () {
                  // Add functionality to upload video/audio
                },
              ),
            ),


            SizedBox(height: SC.from_width(40)),
            SizedBox(
              height: SC.from_width(49),
              child: CustomActionButton(
                action: () {

                },
                lable: 'Submit',
              ),
            ),
            
            SizedBox(height: SC.from_width(30),)
            
          ],
        ),
      ),
    );
  }
}
