import 'package:attach/const/app_constante.dart';
import 'package:attach/myfile/screen_dimension.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';


class ReferAndEarnScreen extends StatelessWidget {
  const ReferAndEarnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      centerTitle: false,
      title: Text("Refer & Earns"),
    ),

      body: ListView(children: [

        //Top
        AspectRatio(
          aspectRatio:1.5,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
              right: 0,
                bottom: SC.from_width(39),
                child: Container(
                  padding: EdgeInsets.only(left:17),
                  color:Const.primeColor,
                  child: Center(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                      
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Refer your friends",style: Const.font_500_16(context,size: SC.from_width(18)),),
                            Text("Earn ₹150 each",style: Const.font_900_20(context,size: SC.from_width(26)),),
                          ],
                        ),
                      ),

                        Image.asset("assets/banners/referandearnbanner.png",width: SC.from_width(154),),


                    ],),
                  ),
                ),
              ),
              
              Positioned(
                left: 17,
                  right: 17,
                  bottom: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(9),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(.5),
                          blurRadius: 5
                        )
                      ]
                    ),

                    child: ListTile(
                      minVerticalPadding: 0,
                      contentPadding: EdgeInsets.symmetric(horizontal: 17),
                      minTileHeight: SC.from_width(77),
                      
                      leading: Image.asset("assets/banners/coin.png"),
                      
                      title: Text("TOTAL REWARD"),
                      subtitle: Text("₹300"),

                      titleTextStyle: Const.font_900_20(context,size: SC.from_width(16),color: Color.fromRGBO(39, 25, 49, 1)),
                      subtitleTextStyle: Const.font_900_20(context,size: SC.from_width(27),color: Color.fromRGBO(39, 25, 49, 1)),
                      
                      trailing: CircleAvatar(radius: SC.from_width(20),
                      child: Icon(Icons.arrow_forward_ios),backgroundColor: Colors.grey.shade200,),

                                  ),
                  ))
            ],
          ),
        ),
        SizedBox(height: SC.from_width(23),),


        Card(
          margin: EdgeInsets.symmetric(horizontal: 17),
          child: Padding(
            padding: EdgeInsets.only(
              left: 18,
              right: 18,
              top: SC.from_width(24),
              bottom: SC.from_width(24),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

              Row(children: [

                CircleAvatar(
                  backgroundColor: Const.scaffoldColor,
                  child: Image.asset("assets/icons/refanda_earn/link.png",width: SC.from_width(18),),
                ),
                SizedBox(width: SC.from_width(11),),

                Expanded(child: Text("Invite your friend to install the app with this referal code.",
                style: Const.font_500_12(context),))

              ],),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: SC.from_width(8),vertical: 3),
                child: Icon(Icons.arrow_downward),
              ),


              Row(children: [

                CircleAvatar(
                  backgroundColor: Const.scaffoldColor,
                  child: Image.asset("assets/icons/refanda_earn/chat.png",width: SC.from_width(18),),
                ),
                SizedBox(width: SC.from_width(11),),

                Expanded(child: Text("Your friend must talk for at least 30 minutes with a minimum of 5 listeners.",
                  style: Const.font_500_12(context),))

              ],),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: SC.from_width(8),vertical: 3),
                  child: Icon(Icons.arrow_downward),
                ),


              Row(children: [

                CircleAvatar(
                  backgroundColor: Const.scaffoldColor,
                  child: Image.asset("assets/icons/refanda_earn/wallet.png",width: SC.from_width(18),),
                ),
                SizedBox(width: SC.from_width(11),),

                Expanded(child: Text("You will get ₹150 when your friend fulfills this criteria.",
                  style: Const.font_500_12(context),))

              ],),

            ],),
          ),
        ),

        SizedBox(height: SC.from_width(27),),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17),
          child: SizedBox(
            height: SC.from_width(60),
            child: Row(
              children: [
            
            
                Expanded(
                  child: DottedBorder(
                    radius: Radius.circular(6),
                      borderType: BorderType.RRect,
                      dashPattern: [
                        5,5
                      ],
                      color: Colors.white,
                      child: Container(
                    width: double.infinity,
                    height: SC.from_width(60),
                    decoration: BoxDecoration(
                      color: Const.primeColor,
                      borderRadius: BorderRadius.circular(6)
                    ),
                    child: Center(child: SelectableText("RMT20DX",
                    style: Const.font_900_20(context)?.copyWith(
                      letterSpacing: SC.from_width(14)
                    ),
                    )),
                  
                  )),
                ),
                
                SizedBox(width: SC.from_width(17),),
            
            
                AspectRatio(aspectRatio: 1,
                child: Ink(
                  decoration: BoxDecoration(
                    color: Const.primeColor,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Const.yellow),
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(6),
                    
                    onTap: (){
                      SharePlus.instance.share(
                          ShareParams(text: 'check out my website https://example.com')
                      );
                    },
                    child: Center(child: Image.asset("assets/icons/refanda_earn/share.png",width: SC.from_width(40),)),
                  ),
                ),),


            
              ],
            ),
          ),
        ),



        Container(
            padding: EdgeInsets.symmetric(horizontal: 17,vertical: SC.from_width(50)),

            child: Row(
              children: [

                Image.asset("assets/icons/refanda_earn/heart.png",width: SC.from_width(105),),

                Expanded(
                  child: Text("Share Your Feelings",style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w800,
                    fontSize: SC.from_width(28),
                    color: Color.fromRGBO(190, 190, 190, 1),
                  ),),
                )


              ],
            ))


      ],),



    );


  }
}
