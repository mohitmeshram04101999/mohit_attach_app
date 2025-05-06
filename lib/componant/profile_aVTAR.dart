import 'package:attach/const/app_constante.dart';
import 'package:attach/myfile/screen_dimension.dart';
import 'package:flutter/material.dart';


class ProfileAvtar extends StatelessWidget {
  const ProfileAvtar({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: SC.from_width(92),
      width: SC.from_width(92),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Const.yellow,

      ),
      child: Container(
        margin: EdgeInsets.all(3),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,

        ),
        child: Container(
          margin: EdgeInsets.all(3),
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
              shape: BoxShape.circle
          ),
          child: Image.asset("assets/static/sempleProfile.jpg",fit: BoxFit.cover,),
        ),
      ),
    );
  }
}
