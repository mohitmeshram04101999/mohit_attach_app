import 'package:attach/const/app_constante.dart';
import 'package:attach/myfile/screen_dimension.dart';
import 'package:flutter/material.dart';


class CustomCheckBox extends StatelessWidget {
  final bool value;
  final Color? borderColor;
  final void Function(bool value)? onChange;
  const CustomCheckBox({
    required this.value,
    required this.onChange,
    this.borderColor,
  super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: (){
          if(onChange!=null)
            {
              onChange!(!value);
            }
        },
        icon: Container(
          padding: EdgeInsets.all(0),
          height: SC.from_width(18),
          width: SC.from_width(18),
          decoration: BoxDecoration(
            color:  value?Colors.white:null,
            borderRadius: BorderRadius.circular(3),
            border: Border.all(
              color: borderColor??Colors.white,
            )
          ),
            child: FittedBox(child: (value)?Icon(Icons.check,
            color: Colors.grey,):SizedBox()
            )));
  }
}




class CustomRadio<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final Color? borderColor;
  final String? title;
  final void Function(T value)? onChange;
  const CustomRadio({
    this.title,
    required this.value,
    required this.onChange,
    this.borderColor,
    required this.groupValue,
    super.key});

  @override
  Widget build(BuildContext context) {


    bool isSelected = value==groupValue;

    return InkWell(
      borderRadius: BorderRadius.circular(3),
      onTap: (){
        if(onChange!=null)
          {
            onChange!(value);
          }
      },
      child: Padding(
        padding: const EdgeInsets.all(3),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
        
            Container(
              height: SC.from_width(18),
              width: SC.from_width(18),
              padding: EdgeInsets.all(0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: borderColor??Colors.white,
                  width: 2
                )
              ),
              child: Container(
                margin: EdgeInsets.all(3),
                decoration:isSelected? BoxDecoration(shape: BoxShape.circle,color: Colors.white): BoxDecoration(
                ),
              ),
            ),
        
            if(title!=null)
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text(title!, style: Const.font_400_14(context),),
              ),
          ],
        ),
      ),
    );
  }
}





