import 'package:attach/const/app_constante.dart';
import 'package:attach/myfile/screen_dimension.dart';
import 'package:flutter/material.dart';

class TransectionHistoryTile extends StatelessWidget {
  final Map? map;
  const TransectionHistoryTile({this.map,super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minTileHeight: SC.from_width(68),
      leading: Container(
        height: SC.from_width(56),
        width: SC.from_width(56),
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: Image.network("${map?['image']??''}",fit: BoxFit.cover,),
      ),
      
      title: Text('${map?['name']??''}'),
      subtitle: Text('${map?['date']??''}'),
      trailing: Text('${map?['amount']??''}'),

      titleTextStyle: Const.font_700_30(context,size: SC.from_width(14)),

      subtitleTextStyle: Const.font_400_12(context,color: Color.fromRGBO(190, 190, 190, 1)),

      leadingAndTrailingTextStyle: Const.font_700_14(context),
    );
  }
}
