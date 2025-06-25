import 'package:attach/const/app_constante.dart';
import 'package:attach/modles/all_transection_model.dart';
import 'package:attach/myfile/screen_dimension.dart';
import 'package:attach/other/date_time_manager.dart';
import 'package:flutter/material.dart';

class TransectionHistoryTile extends StatelessWidget {
  final Map? map;
  final TransectionInfo? info;
  const TransectionHistoryTile({this.info,this.map,super.key});

  @override
  Widget build(BuildContext context) {



    switch (info?.TypeCheck) {

      case "OTHER":
        return  ListTile(
          minTileHeight: SC.from_width(68),
          contentPadding: EdgeInsets.only(
            left: 5,
            right: 8,
          ),
          leading: Container(
            alignment: Alignment.center,
            height: SC.from_width(56),
            width: SC.from_width(56),
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey.withOpacity(.1),

            ),
            child: Image.asset((info?.type=='CREDIT')
                ?'assets/icons/transection_History_icons/bank.png'
                :'assets/icons/transection_History_icons/walllet.png',
              width: SC.from_width(25),
              errorBuilder: (context, error, stackTrace) => Icon(Icons.person_2_rounded),),
          ),

          title: Text(
            (info?.type=='CREDIT')
                ?'Bank'
                :'Wallet',
          ),
          subtitle: Text(DateTimeManager().formatTime12Hour(info?.createdAt?.add(Duration(minutes: 330)),showDate: true),style: Const.font_400_12(context,color: Color.fromRGBO(190, 190, 190, 1)),),
          trailing: Text(
            (info?.type=='CREDIT')
                ?'+${info?.amount}'
                :'-${info?.amount}',
          ),

          titleTextStyle: Const.font_700_30(context,size: SC.from_width(14),
          ),

          subtitleTextStyle: Const.font_400_12(context,color: Color.fromRGBO(190, 190, 190, 1)),

          leadingAndTrailingTextStyle: Const.font_700_14(context,
              //status APPROVED,PENDING,REJECTED
              color: (info?.status=='APPROVED')?Colors.green
                  :(info?.status=='PENDING')?Colors.yellow
                  : Colors.red
          ),
        );

        default:
          // return Text("${info?.toJson()}");
        return  ListTile(
          minTileHeight: SC.from_width(68),
          contentPadding: EdgeInsets.only(
            left: 5,
            right: 8,
          ),
          leading: Container(
            height: SC.from_width(56),
            width: SC.from_width(56),
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey.withOpacity(.1),

            ),
            child: Image.network(info?.amountCutId?.image??'',fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Icon(Icons.person_2_rounded),),
          ),

          title: Text(info?.amountCutId?.name??'',maxLines: 1, overflow: TextOverflow.ellipsis,),
          subtitle: Text(DateTimeManager().formatTime12Hour(info?.createdAt?.add(Duration(minutes: 330)),showDate: true),),
          trailing: Text(
            (info?.type=='CREDIT')
                ?'+${info?.amount}'
                :'-${info?.amount}',
          ),

          titleTextStyle: Const.font_700_30(context,size: SC.from_width(14)),

          subtitleTextStyle: Const.font_400_12(context,color: Color.fromRGBO(190, 190, 190, 1)),

          leadingAndTrailingTextStyle: Const.font_700_14(context,
          color:  (info?.status=='APPROVED')?Colors.green
        :(info?.status=='PENDING')?Colors.yellow
        : Colors.red),
        );

    }

    return Text("${info?.TypeCheck}");

    return ListTile(
      minTileHeight: SC.from_width(68),
      contentPadding: EdgeInsets.only(
        left: 5,
        right: 8,
      ),
      leading: Container(
        height: SC.from_width(56),
        width: SC.from_width(56),
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey.withOpacity(.1),

        ),
        child: Image.network("${map?['image']??''}",fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Icon(Icons.person_2_rounded),),
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
