import 'package:attach/const/app_constante.dart';
import 'package:attach/myfile/screen_dimension.dart';
import 'package:flutter/material.dart';


class ProfileListTile extends StatelessWidget {
  final String icon;
  final String title;
  final String subTitle;
  final void Function()? onTap;
  const ProfileListTile({this.onTap,required this.icon,required this.title,required this.subTitle,super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: SC.from_width(10)),
      color: Const.primeColor,
      elevation: 0,
      clipBehavior: Clip.hardEdge,


      child:InkWell(
        onTap: onTap,
        child: Ink(
          height: SC.from_width(62),
          padding: EdgeInsets.symmetric(horizontal: 17),
          child: Row(
            children: [
              SizedBox(height: SC.from_width(33),
                child: Image.asset(icon),),
              SizedBox(width: SC.from_width(13),),
              Expanded(child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(title,style: Const.font_500_14(context,size: SC.from_width(15))),
                  Text(subTitle,style: Const.roboto_300_12(context,size: SC.from_width(13)))
                ],
              ))
            ],
          ),
        ),
      ),


      // child: ListTile(
      //   // contentPadding: EdgeInsets.symmetric(horizontal: ),
      //   leading:SizedBox(height: SC.from_width(33),
      // child: Image.asset(icon),),
      //   title: Text(title),
      //   subtitle: Text(subTitle),
      //   onTap: onTap,
      //
      //   titleTextStyle: Const.font_500_14(context,size: SC.from_width(15)),
      //
      //   subtitleTextStyle: Const.roboto_300_12(context,size: SC.from_width(13)),
      //
      // ),
    );
  }
}
