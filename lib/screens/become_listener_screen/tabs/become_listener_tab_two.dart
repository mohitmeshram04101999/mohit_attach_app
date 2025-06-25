import 'package:attach/componant/coustom_text_field.dart';
import 'package:attach/componant/custom_check_box.dart';
import 'package:attach/componant/custome_action_button.dart';
import 'package:attach/const/app_constante.dart';
import 'package:attach/myfile/screen_dimension.dart';
import 'package:flutter/material.dart';


class BecomeListenerTabTwo extends StatelessWidget {
  final PageController pageController;
  const BecomeListenerTabTwo({ required this.pageController,super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin:  const EdgeInsets.only(
          left: 14,
          right: 14,
          bottom: 20
        ),
      
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
        
            //
            Text(
              'Preferred support mode',
              style: Const.font_400_14(context),
            ),
        
        
            //
            Row(
              children: [
                CustomCheckBox(value: true, onChange: (d) {}),
                Text('Audio call', style: Const.font_500_16(context)),
              ],
            ),
        
            //
            Row(
              children: [
                CustomCheckBox(value: true, onChange: (d) {}),
                Text('Video call', style: Const.font_500_16(context)),
              ],
            ),
        
            //
            Row(
              children: [
                CustomCheckBox(value: true, onChange: (d) {}),
                Text('Chat', style: Const.font_500_16(context)),
              ],
            ),
            SizedBox(height: SC.from_width(30),),
        
            //
            CustomTextField(
              label: 'daily availability',
              labelSide: '(hours per day)',
              maxLine: 4,
              hintText: 'Write briefly...',
            ),
            SizedBox(height: SC.from_width(30),),
        
        
            //
            CustomTextField(
              label: 'Preferred days/times',
              maxLine: 4,
              hintText: 'Write briefly...',
            ),
            SizedBox(height: SC.from_width(30),),
        
            //
            CustomTextField(
              label: 'Why do you want to become a listener?',
              labelSide: '(optional)',
              maxLine: 4,
              hintText: 'Please Describe Here...',
            ),
        
            //
            SizedBox(height: SC.from_width(30),),
            CustomTextField(
              label: 'What qualities make a good listener? ',
              labelSide: '(optional)',
              maxLine: 4,
              hintText: 'Please Describe Here...',
            ),
        
            //
            SizedBox(height: SC.from_width(30),),
            CustomTextField(
              label: 'Have you helped someone in a stressful/emotional situation before? ',
              labelSide: '(optional)',
              maxLine: 4,
              hintText: 'Please Describe Here...',
            ),
        
        
        
            //
            SizedBox(height: SC.from_width(30),),
        
            //
            Text(
              'Are you comfortable with audio/video calls?',
              style: Const.font_400_14(context),
            ),
        
            //
            Column(
              children: [
                Row(
                  children: [
                    CustomCheckBox(value: true, onChange: (d) {}),
                    Text('Yes', style: Const.font_500_16(context)),
                  ],
                ),
                Row(
                  children: [
                    CustomCheckBox(value: false, onChange: (d) {}),
                    Text('No', style: Const.font_500_16(context)),
                  ],
                ),
              ],
            ),
        
            SizedBox(height: SC.from_width(30),),
        
            CustomActionButton(action: (){
              pageController.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.linear,
              );
            },lable: "Save And Continue",),
        
            SizedBox(height: SC.from_width(30),),
        
        
        
        
        
        
        
          ],
        
        
        ),
      ),
    );
  }
}
