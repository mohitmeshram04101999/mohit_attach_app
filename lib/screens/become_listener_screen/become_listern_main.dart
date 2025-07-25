import 'package:attach/const/app_constante.dart';
import 'package:attach/myfile/screen_dimension.dart';
import 'package:attach/providers/become_listener_provider.dart';
import 'package:attach/screens/become_listener_screen/tabs/become_listener_tab_three.dart';
import 'package:attach/screens/become_listener_screen/tabs/become_listener_tab_two.dart';
import 'package:attach/screens/become_listener_screen/tabs/become_listener_tap_one.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class BecomeListenerMain extends StatefulWidget {
  const BecomeListenerMain({super.key});

  @override
  State<BecomeListenerMain> createState() => _BecomeListenerMainState();
}

class _BecomeListenerMainState extends State<BecomeListenerMain> {



  int index = 0;
  final PageController _controller = PageController(initialPage: 0);


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<BecomeListenerProvider>(context,listen: false).getQuestion(context);
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        Provider.of<BecomeListenerProvider>(context,listen: false).clear();
        return true;
      },
      child: Scaffold(

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
              child: Consumer<BecomeListenerProvider>(
                builder: (context, p, child) => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [


                    if(kDebugMode)
                      Text('${p.questionList.length}'),

                    for(int i=0;i<p.totalPage;i++)
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [

                          //
                          AnimatedContainer(
                            height: SC.from_width(32),
                            width: SC.from_width(32),
                            duration: Duration(milliseconds: 300),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 2,
                                color: (index >= i) ? Const.yellow : Colors.white,
                              ),
                              color: (index >= i)? Colors.white : null,
                            ),
                            child: Center(
                              child: Text(
                                "${i+1}",
                                style: TextStyle(
                                  color: (index >= i) ?Const.yellow: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          //
                          if(i<p.totalPage-1)
                          Container(
                              height: 2,
                              width: SC.from_height(20),
                              color: Colors.white,
                              margin: EdgeInsets.symmetric(horizontal: 5),
                            ),
                        ],
                      ),

                  ],
                ),
              )
            ,),

            Expanded(child: Consumer<BecomeListenerProvider>(
              builder: (context, p, child) {

                if(p.isLoading)
                  {
                    return Center(child: CircularProgressIndicator(),);
                  }
                if(p.questionList.isEmpty)
                  {
                    return Center(child: Text("No Question"),);
                  }

                return  PageView(
                  controller: _controller,
                  onPageChanged: (value) {
                    p.loadMore(context);
                    setState(() {
                      index = value;
                    });
                  },
                  children: [
                    for(int i=0;i<p.totalPage;i++)
                      if(i<p.questionList.length)...[
                        BecomeListenerTapOne(
                          isLast: i==p.questionList.length-1,
                          questionForListenerModel: p.questionList[i],pageController: _controller,),
                      ]
                    else...[
                      SizedBox()
                      ]

                  ],);

              },
            ))
          ],
        ),

      ),
    );


  }
}
