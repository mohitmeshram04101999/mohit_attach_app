import 'package:attach/const/app_constante.dart';
import 'package:attach/myfile/screen_dimension.dart';
import 'package:flutter/material.dart';



class CustomStarRatting extends StatelessWidget {
  final int ratting;
  const CustomStarRatting({required this.ratting,super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children:List.generate(5, (index) {

        return Container(
          margin: EdgeInsets.symmetric(horizontal: 1),
          height: SC.from_width(14),
          width: SC.from_width(14),
          
          child: Image.asset("assets/icons/star.png",
            fit: BoxFit.cover,
            color: ratting<=index?Color.fromRGBO(154, 153, 152, 1):Const.yellow,
          ),
          
        );
      },),
    );
  }
}
