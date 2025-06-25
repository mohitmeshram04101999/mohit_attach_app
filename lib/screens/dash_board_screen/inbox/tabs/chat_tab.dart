
import 'package:attach/api/fake_db.dart';
import 'package:attach/componant/chatPageListTile.dart';
import 'package:attach/providers/chatListProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatTab extends StatefulWidget {
  const ChatTab({super.key});

  @override
  State<ChatTab> createState() => _ChatTabState();
}

class _ChatTabState extends State<ChatTab> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ChatListProvider>(context,listen: false).getContact();

  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatListProvider>(
      builder: (context, p, child) {


        if(p.contacts.isEmpty)
          {
            return Center(child: Text("No Contact"),);
          }

        return ListView.separated(
          padding: EdgeInsets.symmetric(vertical: 20),
          itemCount: p.contacts.length,
          separatorBuilder: (context, index) => Divider(
            endIndent: 4,indent: 4,
            height: 0,thickness: 1,color: Color.fromRGBO(58, 61, 64, 1),
          ),
          itemBuilder: (context, index) => ChatPageListTile(
            contact: p.contacts[index],
          ),
        );
      },
    );
  }
}
