import 'package:attach/const/app_constante.dart';
import 'package:attach/myfile/screen_dimension.dart';
import 'package:flutter/material.dart';


class ElevatedButtonCustom extends StatelessWidget {
  final double? borderSize;
  final String? label;
  final Color? foregroundColor;
  final void Function()? onTap;
  const ElevatedButtonCustom({this.borderSize,this.foregroundColor,required this.onTap,this.label,super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      clipBehavior: Clip.hardEdge,
      borderRadius: BorderRadius.circular(40),
      child: Card(
        color: Colors.transparent,
        elevation: 0,
          child: Padding(
            padding:  EdgeInsets.all(4),
            child: Ink(
              decoration:BoxDecoration(
                color: Const.yellow,
                border: Border.all(
                  width: borderSize??0,
                  color: Const.primeColor.withOpacity(.3)
                ),
                borderRadius: BorderRadius.circular(10)
              ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                    onTap: onTap,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                        child: Text(label??'',style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontFamily: 'ProductSans',
                          fontSize: SC.from_width(14),
                          color: foregroundColor??Colors.white
                        ),)))),
          )),
    );
  }
}
