import 'package:attach/const/app_constante.dart';
import 'package:attach/modles/all_language_responce_model.dart';
import 'package:attach/myfile/screen_dimension.dart';
import 'package:flutter/material.dart';



class LanguageGridTile extends StatelessWidget {
  final void Function()? onTap;
  final bool active;
  final Language language;
  const LanguageGridTile({
    required this.language,
    this.active = false,
    this.onTap,

    super.key

  });

  @override
  Widget build(BuildContext context) {
    return  Container(

      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          // color: active?Const.primeColor:null,
          border: Border.all(
              color: active?Const.yellow: Colors.white
          )
      ),

      child: InkWell(
          onTap:onTap,
          borderRadius:BorderRadius.circular(8),
          child: Center(child: Text(language.name??'',style: Const.font_500_16(context,size: SC.from_width(18),
            color: active?Const.yellow:null,
          ),))),
    );
  }
}
