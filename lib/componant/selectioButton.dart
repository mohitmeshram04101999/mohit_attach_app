import 'package:attach/const/app_constante.dart';
import 'package:attach/myfile/screen_dimension.dart';
import 'package:flutter/material.dart';

class SelectionButton extends StatelessWidget {
  final String label;
  final void Function()? onTap;
  final bool selected;
  const SelectionButton({this.onTap,this.selected = false,required this.label,super.key});

  @override
  Widget build(BuildContext context) {
    return Ink(
      padding: EdgeInsets.symmetric(horizontal: SC.from_width(36),vertical: SC.from_width(8)),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        color: selected?Const.yellow:Colors.black,
        borderRadius: BorderRadius.circular(100)
      ),
      child: InkWell(
        onTap: onTap,
        child: Text(label,
        style: Const.font_400_16(context),),
      ),
    );
  }
}
