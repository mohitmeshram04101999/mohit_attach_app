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
      child: ListTile(
        leading:SizedBox(height: SC.from_width(33),
      child: Image.asset(icon),),
        title: Text(title),
        subtitle: Text(subTitle),
        onTap: onTap,
      
        titleTextStyle: Const.font_500_14(context),
      
        subtitleTextStyle: Const.roboto_300_12(context),
      
      ),
    );
  }
}
