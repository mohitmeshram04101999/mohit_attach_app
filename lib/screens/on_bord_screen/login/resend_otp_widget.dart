import 'dart:async';

import 'package:attach/const/app_constante.dart';
import 'package:attach/myfile/screen_dimension.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


class ResendOtpWidget extends StatefulWidget {
  final void Function() onTap;
  const ResendOtpWidget({required this.onTap,super.key});

  @override
  State<ResendOtpWidget> createState() => _ResendOtpWidgetState();
}

class _ResendOtpWidgetState extends State<ResendOtpWidget> {

  int timer = 30;


  Timer? _timer;

  dispose(){
    _timer?.cancel();
    super.dispose();
  }




    @override
    void initState() {
      // TODO: implement initState
      super.initState();
      _timer = Timer.periodic((Duration(seconds: 1)), (d){
        if(timer>0)
          {
            timer--;
            setState(() {

            });
          }
      });


    }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async {
        _timer?.cancel();
        return true;
      },
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: SC.from_width(10)),
        child: Row(children: [
          Text("${(timer/60).toInt().toString().padLeft(2,'0')}:${(timer%60).toInt().toString().padLeft(2,'0')}",style: Const.font_500_14(context),),
          Spacer(),
          if(kDebugMode)
            Text("$timer"),
          if(timer==0)
            InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: (){
                timer = 10;
                widget.onTap();

              },
                child: Text("Resend Code",style: Const.font_500_14(context),)),
        ],),
      ),
    );
  }
}
