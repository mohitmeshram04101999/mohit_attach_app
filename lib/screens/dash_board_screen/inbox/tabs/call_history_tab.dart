

import 'package:attach/api/fake_db.dart';
import 'package:attach/componant/call_history_tile.dart';

import 'package:flutter/material.dart';


class CallHistoryTab extends StatelessWidget {
  const CallHistoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(vertical: 20),
      itemCount: FakeDb.callHistory.length,
      separatorBuilder: (context, index) => Divider(
        endIndent: 4,indent: 4,
        height: 0,thickness: 1,color: Colors.grey,),
      itemBuilder: (context, index) => CallHistoryTile(
        data: FakeDb.callHistory[index],
      ),
    );
  }
}
