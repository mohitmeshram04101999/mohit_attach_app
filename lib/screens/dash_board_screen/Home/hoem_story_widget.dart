import 'package:attach/const/app_constante.dart';
import 'package:attach/myfile/screen_dimension.dart';
import 'package:flutter/material.dart';


class HomeStoryWidget extends StatelessWidget {
  final Map? data;
  const HomeStoryWidget({this.data,super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(5),
          height: SC.from_width(71),
          width: SC.from_width(71),
        
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              width: 2.5,
              color: Const.yellow,
            ),
          ),
        
        
          child: Container(
            clipBehavior: Clip.hardEdge,
        
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: Image.asset("${data?['Image']??''}",fit: BoxFit.cover,),
          ),
        
        
        
        ),
        SizedBox(height: SC.from_width(5),),
        Text("${data?['name']??''}",style: Const.font_500_14(context),)
      ],
    );
  }
}
