

import 'package:attach/api/fake_db.dart';
import 'package:attach/componant/call_history_tile.dart';
import 'package:attach/const/app_constante.dart';
import 'package:attach/providers/call_history_provider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class CallHistoryTab extends StatefulWidget {
  const CallHistoryTab({super.key});

  @override
  State<CallHistoryTab> createState() => _CallHistoryTabState();
}

class _CallHistoryTabState extends State<CallHistoryTab> {


  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<CallHistoryProvider>(context,listen: false).clear();
    Provider.of<CallHistoryProvider>(context,listen: false).getCallHistory(context);
    scrollController.addListener(() {
      print("this is lode More");
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        Provider.of<CallHistoryProvider>(context,listen: false).loadMore(context);
      }
    });
  }



  @override
  Widget build(BuildContext context) {
    return Consumer<CallHistoryProvider>(builder: (context, p, child) {
      if(p.isLoading)
        {
          return Center(child: CircularProgressIndicator(),);
        }
      if(p.callHistoryData.isEmpty)
        {
          return Center(child: Text("No Call History"),);
        }
      return RefreshIndicator(

        color: Colors.white,
        backgroundColor: Const.yellow,
        onRefresh: () async => await p.resetPage(context),
        child: ListView.separated(
          controller: scrollController,
          padding: EdgeInsets.symmetric(vertical: 20),
          itemCount: p.callHistoryData.length,
          separatorBuilder: (context, index) => Divider(
            endIndent: 4,indent: 4,
            height: 0,thickness: 1,color: Color.fromRGBO(58, 61, 64, 1),),
          itemBuilder: (context, index) => CallHistoryTile(
            history: p.callHistoryData[index],
          ),
        ),
      );
    }
,
    );
  }
}
