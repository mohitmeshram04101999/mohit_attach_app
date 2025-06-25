import 'package:attach/const/app_constante.dart';
import 'package:attach/myfile/screen_dimension.dart';
import 'package:attach/providers/chatListProvider.dart';
import 'package:attach/screens/dash_board_screen/inbox/tabs/call_history_tab.dart';
import 'package:attach/screens/dash_board_screen/inbox/tabs/chat_tab.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class InboxScreen extends StatefulWidget {
  const InboxScreen({super.key});

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> with SingleTickerProviderStateMixin{

  late TabController controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TabController(length: 2, vsync: this);
    controller.addListener((){
      cr = controller.index;
      setState(() {

      });
      print("asdf");
    });
  }

  int cr  = 0;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(

        appBar: AppBar(
          leading: SizedBox(),
          leadingWidth: 0,
          centerTitle: false,
          titleTextStyle: Const.font_900_20(context,size: SC.from_width(24)),
          title: Text("Attach"),



           //Tab



        ),


        //
        body: Column(



            children: [
              Container(
                width: double.infinity,
                height: SC.from_width(45),
                margin: EdgeInsets.only(
                  left: SC.from_width(10),
                  right: SC.from_width(10),
                  top: SC.from_width(10)
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(100)
                ),
                padding: EdgeInsets.symmetric(vertical: SC.from_width(4),horizontal: SC.from_width(4)),
                child: Consumer<ChatListProvider>(
                  builder: (context, p, child) =>  TabBar(
                    controller: controller,

                      onTap: (d){
                        print(d);
                        cr =d;
                        setState(() {

                        });
                      },

                      tabs: [

                        Tab(
                          child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Chat"),
                            if(p.totalUnread>0)
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: SC.from_width(8)),
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                decoration: BoxDecoration(
                                    color: (cr!=0)?Const.scaffoldColor:Colors.white,
                                    borderRadius:BorderRadius.circular(30)
                                ),
                                child: Text('${p.totalUnread}',style: Const.poppins_400_14(context,size: SC.from_width(8),color: (cr==0)?Const.scaffoldColor:Colors.white)?.copyWith(fontWeight: FontWeight.w700),),)
                          ],),),


                        Tab(child:Text("Call History"),),
                      ]),
                ),
              ),
              Expanded(child:TabBarView(
                controller: controller,
                  children: [
                ChatTab(),
                CallHistoryTab(),
              ]))
        ]),
      ),

    );
  }
}
