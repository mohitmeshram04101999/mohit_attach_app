
import 'package:attach/api/fake_db.dart';
import 'package:attach/componant/chatPageListTile.dart';
import 'package:flutter/material.dart';

class ChatTab extends StatelessWidget {
  const ChatTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(vertical: 20),
      itemCount: FakeDb.chatContect().length,
      separatorBuilder: (context, index) => Divider(
        endIndent: 4,indent: 4,
        height: 0,thickness: 1,color: Colors.grey,
      ),
        itemBuilder: (context, index) => ChatPageListTile(
          data: FakeDb.chatContect()[index],
        ),
    );
  }
}
