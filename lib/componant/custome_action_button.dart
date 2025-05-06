
import 'package:attach/const/app_constante.dart';
import 'package:attach/myfile/action%20Button.dart';
import 'package:attach/myfile/screen_dimension.dart';
import 'package:flutter/material.dart';


class CustomActionButton extends StatelessWidget {
  final Function action;
  final String? lable;
  const CustomActionButton({this.lable,required this.action,super.key});

  @override
  Widget build(BuildContext context) {
    return MyactionButton(

      foregroundColor: Colors.black,

      borderRadius: BorderRadius.circular(8),
      
      color: Const.yellow,

      height: SC.from_width(56),
      
      lableStyle: TextStyle(
        fontFamily: 'ProductSans',
        fontWeight: FontWeight.w500,
        fontSize: SC.from_width(20),
        color: Colors.black
      ),
      width: double.infinity,
        action: action,
        duretion: Duration(milliseconds: 300),
      lable: lable,
    );
  }
}
