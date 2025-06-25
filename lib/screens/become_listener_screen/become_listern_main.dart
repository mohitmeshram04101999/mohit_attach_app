import 'package:attach/const/app_constante.dart';
import 'package:attach/myfile/screen_dimension.dart';
import 'package:attach/screens/become_listener_screen/tabs/become_listener_tab_three.dart';
import 'package:attach/screens/become_listener_screen/tabs/become_listener_tab_two.dart';
import 'package:attach/screens/become_listener_screen/tabs/become_listener_tap_one.dart';
import 'package:flutter/material.dart';



class BecomeListenerMain extends StatefulWidget {
  const BecomeListenerMain({super.key});

  @override
  State<BecomeListenerMain> createState() => _BecomeListenerMainState();
}

class _BecomeListenerMainState extends State<BecomeListenerMain> {



  int index = 0;
  final PageController _controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        centerTitle: false,
        title: Text("Become Listener"),),



      body:Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 14),
            padding: const EdgeInsets.only(top:24,bottom: 10),
            decoration: BoxDecoration(
              color: Const.primeColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // First Circle
                AnimatedContainer(
                  height: SC.from_width(32),
                  width: SC.from_width(32),
                  duration: Duration(milliseconds: 300),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: 2,
                      color: (index >= 0) ? Const.yellow : Colors.white,
                    ),
                    color: (index >= 0)? Colors.white : null,
                  ),
                  child: Center(
                    child: Text(
                      "1",
                      style: TextStyle(
                        color: (index >= 0) ?Const.yellow: Colors.white,
                      ),
                    ),
                  ),
                ),
                
                // First Separator
                Container(
                  height: 2,
                  width: 40,
                  color: Colors.white,
                  margin: EdgeInsets.symmetric(horizontal: 5),
                ),

                // Second Circle
                AnimatedContainer(
                  height: SC.from_width(32),
                  width: SC.from_width(32),
                  duration: Duration(milliseconds: 300), 
                  decoration: BoxDecoration(

                    shape: BoxShape.circle,
                    border: Border.all(
                      width: 2,
                      color: (index >= 1) ? Const.yellow : Colors.white,
                    ),
                    color: (index >= 1)? Colors.white : null,
                  ),
                  child: Center(
                    child: Text(
                      "2",
                      style: TextStyle(
                        color: (index >= 1) ? Const.yellow : Colors.white,
                      ),
                    ),
                  ),
                ),
                
                // Second Separator
                Container(
                  height: 2,
                  width: 40,
                  color: Colors.white,
                  margin: EdgeInsets.symmetric(horizontal: 5),
                ),
                
                // Third Circle
                AnimatedContainer(
                  height: SC.from_width(32),
                  width: SC.from_width(32),
                  duration: Duration(milliseconds: 300),
                  decoration: BoxDecoration(

                    shape: BoxShape.circle,
                    border: Border.all(
                      width: 2,
                      color: (index >= 2) ? Const.yellow: Colors.white,
                    ),
                    color: (index >= 2)? Colors.white : null,
                  ),
                  child: Center(
                    child: Text(
                      "3",
                      style: TextStyle(
                        color: (index >= 2) ? Const.yellow : Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ,),

          Expanded(child: PageView(
            controller: _controller,
            onPageChanged: (value) {
              setState(() {
                index = value;
              });
            },
            children: [
              BecomeListenerTapOne(pageController: _controller,),
              BecomeListenerTabTwo(pageController: _controller,),
              BecomeListenerTabThree()
            ],))
        ],
      ),

    );


  }
}
