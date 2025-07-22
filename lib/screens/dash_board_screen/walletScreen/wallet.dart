import 'package:attach/api/fake_db.dart';
import 'package:attach/componant/transection_histroy_tile.dart';
import 'package:attach/const/app_constante.dart';
import 'package:attach/myfile/screen_dimension.dart';
import 'package:attach/providers/profileProvider.dart';
import 'package:attach/providers/transection_history_provider.dart';
import 'package:attach/screens/dash_board_screen/walletScreen/wallet_opttion_row.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<TransectionHistoryProvider>(context,listen: false).refresh(context);
    Provider.of<ProfileProvider>(context,listen: false).getUser(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child:
    Padding(
      padding: EdgeInsets.symmetric(horizontal: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: SC.from_width(20),),

          Container(
            // margin: EdgeInsets.symmetric(horizontal: 10),
            height: SC.from_width(181),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Const.primeColor,
              borderRadius: BorderRadius.circular(12)
            ),
            child: Consumer<ProfileProvider>(builder: (context, p, child) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Wallet Balance",style: Const.font_700_30(context),),
                Text("₹${p.user?.wallet??0}",style: Const.font_900_20(context,size: SC.from_width(50)),)
              ],
            ),),
          ),
          SizedBox(height: SC.from_width(12),),

          // wallet Option
          WalletOptionRow(),
          SizedBox(height: SC.from_width(22),),


          Text("Recent Transactions",style: Const.font_900_20(context),),


          Expanded(

            child: Consumer<TransectionHistoryProvider>(builder: (context, p, child) {

              if(p.loading)
                {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              if(p.allTransection.isEmpty)
                {
                  return Center(child: Text("No Data"),);
                }

              return RefreshIndicator(
                color: Colors.white,
                backgroundColor: Const.yellow,
                onRefresh: () async {
                  await p.refresh(context);
                  await Provider.of<ProfileProvider>(context,listen: false).getProfile(context);
                },
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  itemCount: p.allTransection.length,
                  separatorBuilder: (context, index) => Divider(
                    height: 5,
                    thickness: 1,
                    color: Color.fromRGBO(39, 25, 49, 1),
                  ),
                  itemBuilder: (context, index) => TransectionHistoryTile(
                    info:   p.allTransection[index],
                  ),
                ),
              );

            },),
          )


        ],

      ),
    ));
  }
}
