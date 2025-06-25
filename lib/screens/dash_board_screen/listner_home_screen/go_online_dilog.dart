import 'package:attach/componant/custom_check_box.dart';
import 'package:attach/const/app_constante.dart';
import 'package:attach/myfile/screen_dimension.dart';
import 'package:attach/providers/profileProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class GoOnlineDilog extends StatefulWidget {
  const GoOnlineDilog({super.key});

  @override
  State<GoOnlineDilog> createState() => _GoOnlineDilogState();
}

class _GoOnlineDilogState extends State<GoOnlineDilog> {

   bool video = false;

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    video =  Provider.of<ProfileProvider>(context,listen: false).user?.setAvailability?.videoCall??false;
  }


  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      backgroundColor: Const.primeColor,
      onClosing: (){

      }, builder: (context) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [

        SizedBox(height: SC.from_width(20),),
        Center(child: Container(height: SC.from_width(3),width: SC.from_width(57),
        decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10)),)),
        SizedBox(height: SC.from_width(19),),
        Padding(
          padding:  EdgeInsets.symmetric(horizontal: SC.from_width(25)),
          child: Text("Set Availablity",style: Const.font_900_20(context,size: SC.from_width(19)),),
        ),

        //
        ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: SC.from_width(25)),
            leading: CustomCheckBox(value: true, onChange: (d)
            {

            }),
            title: Text("Chat",style: Const.font_500_16(context),),

        ),

        //
        ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: SC.from_width(25)),
            leading: CustomCheckBox(value: true, onChange: (d)
            {

            }),
            title: Text("Audio call",style: Const.font_500_16(context),),
        ),

        //
         ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: SC.from_width(25)),
          leading: CustomCheckBox(value: video, onChange: (d)
          {
            video = d;
            setState(() {

            });
          }),
          title: Text("Video call",style: Const.font_500_16(context),),
          onTap: (){
            video = !video;
            setState(() {

            }
            );
          }
         ),
        
        Padding(
          padding:  EdgeInsets.symmetric(horizontal: SC.from_width(25)),
          child: Text("Availability on chat, audio call is compulsory",style: Const.font_400_14(context),),
        ), 
        
        Container(
          margin: EdgeInsets.symmetric(horizontal: 14,vertical: SC.from_width(16)),
          width: double.infinity,
          height: SC.from_width(49),
            child: OutlinedButton(onPressed: (){
              Provider.of<ProfileProvider>(context,listen: false).setAudioVideoAv(context, video: video);
              Navigator.pop(context);
            }, child: Text("Save Availability",style:Const.font_700_16(context),)))

      ],
    ),);
  }
}
