import 'package:attach/api/fake_db.dart';
import 'package:attach/componant/transection_histroy_tile.dart';
import 'package:attach/const/app_constante.dart';
import 'package:attach/providers/transection_history_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class TransectionHistoryScreen extends StatefulWidget {
  const TransectionHistoryScreen({super.key});

  @override
  State<TransectionHistoryScreen> createState() => _TransectionHistoryScreenState();
}

class _TransectionHistoryScreenState extends State<TransectionHistoryScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener((){
      if(_scrollController.position.pixels==_scrollController.position.maxScrollExtent)
        {
          Provider.of<TransectionHistoryProvider>(context,listen: false).loadMore(context);
        }
    });
  }



  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

      floatingActionButton: Consumer<TransectionHistoryProvider>(
        builder: (context, p, child) {
          if(p.loadingMore)
            {
              return FloatingActionButton(
                onPressed: (){},child: CircularProgressIndicator(),);
            }
          return SizedBox() ;
          // return FloatingActionButton(
          //   onPressed: (){},child: CircularProgressIndicator(),);
        } ,
      ),

      appBar: AppBar(
        centerTitle: false,
        title: Text("Transection History"),
      ),

      body:  Consumer<TransectionHistoryProvider>(
        builder: (context, p, child) {
          if(p.loading)
            {
              return Center(child: CircularProgressIndicator(),);
            }
          if(p.allTransection.isEmpty)
            {
              return Center(child: Text("No data"),);
            }
          return RefreshIndicator(
            color: Colors.white,
            backgroundColor: Const.yellow,
            onRefresh: ()async{
              await p.refresh(context);
            },
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 14),
              itemCount: p.allTransection.length,
              separatorBuilder: (context, index) => Divider(height:0,thickness: 1,color: Color.fromRGBO(39, 25, 49, 1),
              ),
              itemBuilder: (context, index) => TransectionHistoryTile(
                info: p.allTransection[index],
                // map: FakeDb.transiction()[index],
              ),),
          );
        },
      ),
    );
  }
}
