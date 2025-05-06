
import 'package:attach/const/app_constante.dart';
import 'package:attach/myfile/screen_dimension.dart';
import 'package:flutter/material.dart';

class MyBackButton extends StatelessWidget {
  final IconData? icon;
  final void Function()? onTap;
  const MyBackButton({this.onTap,this.icon,super.key});

  @override
  Widget build(BuildContext context) {
    
    
    
    return Center(
      child: Container(
        margin: EdgeInsets.only(left: SC.from_width(10)),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Const.primeColor,
        ),
        child: IconButton(onPressed:onTap?? (){
          Navigator.pop(context);
        },icon: Icon(icon??Icons.arrow_back,color: Colors.white,)),
      ),
    );
  }
}
