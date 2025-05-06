import 'dart:math';

import 'package:attach/componant/eleveted_button_custom.dart';
import 'package:attach/const/app_constante.dart';
import 'package:attach/myfile/myast%20dart%20file.dart';
import 'package:attach/myfile/screen_dimension.dart';
import 'package:attach/screens/on_bord_screen/login/log_in_screen.dart';
import 'package:attach/screens/on_bord_screen/tab/on_1.dart';
import 'package:attach/screens/on_bord_screen/tab/on_2.dart';
import 'package:attach/screens/on_bord_screen/tab/on_3.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';



class OnBoardMain extends StatefulWidget {
  const OnBoardMain({super.key});

  @override
  State<OnBoardMain> createState() => _OnBoardMainState();
}

class _OnBoardMainState extends State<OnBoardMain> {

  final controller = PageController();

  int curruntIndex = 0;


  @override
  Widget build(BuildContext context) {
    return  Scaffold(




      //
      body: Stack(
        children: [
          PageView(
            onPageChanged: (d){
              curruntIndex = d.toInt();
              setState(() {
                
              });
            },
            controller: controller,


            children: [

              On1(controller: controller,),
              On2(controller: controller),
              On3(controller: controller),


            ],




          ),

          Positioned(
            bottom: 0,
            left: 0,right: 0,
            child: Container(
              height: SC.from_width(92),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [



                  AnimatedContainer(
                    margin: EdgeInsets.symmetric(horizontal: 3),
                      duration: Duration(milliseconds: 300),
                    height: SC.from_width(10),
                    width: SC.from_width(curruntIndex==0?40:15),

                    decoration: BoxDecoration(
                      color: curruntIndex==0?Const.yellow:Colors.white,
                      borderRadius: BorderRadius.circular(30)
                    ),
                  ),

                  AnimatedContainer(
                    margin: EdgeInsets.symmetric(horizontal: 3),
                    duration: Duration(milliseconds: 300),
                    height: SC.from_width(10),
                    width: SC.from_width(curruntIndex==1?40:15),

                    decoration: BoxDecoration(
                        color: curruntIndex==1?Const.yellow:Colors.white,
                        borderRadius: BorderRadius.circular(30)
                    ),
                  ),

                  AnimatedContainer(
                    margin: EdgeInsets.symmetric(horizontal: 3),
                    duration: Duration(milliseconds: 300),
                    height: SC.from_width(10),
                    width: SC.from_width(curruntIndex==2?40:15),

                    decoration: BoxDecoration(
                        color: curruntIndex==2?Const.yellow:Colors.white,
                        borderRadius: BorderRadius.circular(30)
                    ),
                  ),


                ],
              ),
            ),
          ),

          Positioned(
            bottom: 0,
            left: 0,right: 0,
            child: Container(
              padding: EdgeInsets.only(right: SC.from_width(14)),
              height: SC.from_width(92),
              child: Align(
                alignment: Alignment.centerRight,
                child: curruntIndex==2?ElevatedButtonCustom(
                  foregroundColor: Colors.black,
                  borderSize: 3,
                  onTap: (){
                  RoutTo(context, child: (p0, p1) => LogInScreen(),);
                },label: "Get Started",):
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Const.yellow.withOpacity(.5)
                  ),
                  child: FloatingActionButton(
                    onPressed: (){
                      controller.nextPage(duration: Duration(milliseconds: 200), curve: Curves.easeOut);
                    },
                    child: Icon(Icons.arrow_forward),
                  ),
                ),
              ),
            ),
          )

        ],
      ),
    );
  }
}
