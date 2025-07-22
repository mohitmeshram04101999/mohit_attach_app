import 'dart:developer';

import 'package:attach/componant/coustom_text_field.dart';
import 'package:attach/componant/custom_check_box.dart';
import 'package:attach/componant/custome_action_button.dart';
import 'package:attach/const/app_constante.dart';
import 'package:attach/modles/question_for_listener_model.dart';
import 'package:attach/myfile/screen_dimension.dart';
import 'package:attach/noticiation/notificationService.dart';
import 'package:attach/providers/become_listener_provider.dart';
import 'package:attach/providers/my_hleper.dart';
import 'package:attach/screens/become_listener_screen/tabs/question_widget.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BecomeListenerTapOne extends StatefulWidget {
  final bool isLast;
  final QuestionForListenerModel questionForListenerModel;
  final PageController pageController;
  const BecomeListenerTapOne({this.isLast = false,required this.questionForListenerModel,required this.pageController,super.key});

  @override
  State<BecomeListenerTapOne> createState() => _BecomeListenerTapOneState();
}

class _BecomeListenerTapOneState extends State<BecomeListenerTapOne> {


  int uploadingFile = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(left: 14, right: 14, bottom: 20),
        padding: EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: Const.primeColor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(12),
            bottomRight: Radius.circular(12),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            if(kDebugMode)
              Text(uploadingFile.toString()),
            //
            // Text(
            //   "Your Experience & Preferences",
            //   style: Const.font_500_18(context, size: SC.from_width(20)),
            // ),

            SizedBox(height: SC.from_width(12)),


            for(QuestionForListener q in widget.questionForListenerModel.data??[])
              QuestionWidget(
                  question: q,
                onUploadDone: (){
                    uploadingFile--;
                    if(kDebugMode)
                      {
                        setState(() {

                        });
                      }
                },
                onAddFile: (){
                    uploadingFile++;
                    if(kDebugMode)
                      {
                        setState(() {

                        });
                      }
                    FocusScope.of(context).unfocus();
                },

              ),





            SizedBox(
              height: SC.from_width(49),
              child: CustomActionButton(
                action: () {

                  var p = Provider.of<BecomeListenerProvider>(context,listen: false);
                  
                  print(widget.pageController.page?.toInt()??0);
                  
                  if(p.isRequiredAnswerAdded(context,widget.pageController.page?.toInt()??0))
                    {
                      log("answer added");
                    }
                  else
                    {
                     return; 
                    }
                  
                  
                 if(uploadingFile>0)
                   {
                     MyHelper.snakeBar(context, title: "File Uploading", message: "Please Wait");
                    return;
                   }

               if(widget.isLast)
                 {
                   Provider.of<BecomeListenerProvider>(context,listen: false).submitAnswer(context);
                 }
               else
                 {
                   widget.pageController.nextPage(
                       duration: Duration(milliseconds: 300),
                       curve: Curves.linear);
                 }
                },
                lable:widget.isLast? 'Submit' : 'Save and Continue',
              ),
            ),

            SizedBox(height: 40),

            if(kDebugMode)
              Consumer
            <BecomeListenerProvider>(
              builder: (context, p, child) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                for(AnswerModel a in p.answer.values.toList())
                  Text('${a.id} \n${a.question} :- \n ${a.questionType} :-  ${a.mediaAnswer??a.booleanAnswer??a.sortAnswer??a.longAnswer??a.multipleChooseAnswer?.join(', ')}\n')
              ],),
            ),
          ],
        ),
      ),
    );
  }
}






