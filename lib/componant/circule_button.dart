
import 'package:attach/const/app_constante.dart';
import 'package:attach/myfile/screen_dimension.dart';
import 'package:flutter/material.dart';

class CirclButton extends StatelessWidget {
  final Widget? icon;
  final void Function()? onTap;
  const CirclButton({this.onTap,this.icon,super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: SC.from_width(40),
        width: SC.from_width(40),
        padding: EdgeInsets.all(2),

        decoration: BoxDecoration(
          color: Const.yellow.withOpacity(.3),
          shape: BoxShape.circle
        ),
        child: Container(
          padding: EdgeInsets.all(2),
          decoration: BoxDecoration(
              color: Const.yellow.withOpacity(.5),
              shape: BoxShape.circle
          ),
          child: Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Const.yellow,
                shape: BoxShape.circle
            ),
            child: IconTheme(data:
                IconThemeData(
                  size: SC.from_width(20)
                )
                , child: icon??SizedBox()),
          ),
        ),
      ),
    );
  }
}
