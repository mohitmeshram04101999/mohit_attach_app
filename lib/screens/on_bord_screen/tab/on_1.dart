import 'package:attach/const/app_constante.dart';
import 'package:attach/myfile/screen_dimension.dart';
import 'package:flutter/material.dart';


class On1 extends StatelessWidget {
  final PageController controller;
  const On1({required this.controller,super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Stack(
        children: <Widget>[


          //Text
          Positioned(
            top: SC.from_width(67),
              left: 0,right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Mission",style: Const.font_900_30(context),),
                ],
              )),



          //body
          Positioned(
              top: SC.from_width(110),
              left: 0,right: 0,
              child:AspectRatio(
                aspectRatio: 1,
                
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: SC.from_width(29)),
                  child: Image.asset("assets/onboard/images.png",),
                ),
              )),


          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
              child:
          Container(
            height: SC.from_width(281),
            padding: EdgeInsets.symmetric(horizontal: SC.from_width(42)),
            decoration: BoxDecoration(
              color: Const.primeColor,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(SC.from_width(100))
              ),

            ),
            child: Column(
              children: [
                SizedBox(height: SC.from_width(40),),
                Text('You are not alone',style: Const.font_500_24(context),),
                SizedBox(height: SC.from_width(15),),
                Text("Connect with caring listeners anytime, anywhere. Talk through your thoughts and feel supported."
                ,style: Const.font_500_16(context),
                  textAlign: TextAlign.center,
                )

              ],
            ),
          ))

        ],
      ),

    );
  }
}
