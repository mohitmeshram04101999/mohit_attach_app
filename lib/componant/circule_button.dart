
import 'package:attach/const/app_constante.dart';
import 'package:attach/myfile/screen_dimension.dart';
import 'package:flutter/material.dart';

class CirclButton extends StatefulWidget {
  final Widget? icon;
  final Future<void> Function()? onTap;
  final bool active;
  const CirclButton({this.active=true,this.onTap,this.icon,super.key});

  @override
  State<CirclButton> createState() => _CirclButtonState();
}



class _CirclButtonState extends State<CirclButton> {


   bool _canTap = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.active?() async{
        if(widget.onTap!=null&&_canTap)
          {
            _canTap = false;
            setState(() {

            });
            await widget.onTap!();
            _canTap = true;
            setState(() {

            });
          }
      }:null,
      child: Container(
        height: SC.from_width(40),
        width: SC.from_width(40),
        padding: EdgeInsets.all(2),

        decoration: BoxDecoration(
          color: ((widget.active&&_canTap)?Const.yellow:Const.grey_190_190_190).withOpacity(.3),
          shape: BoxShape.circle
        ),
        child: Container(
          padding: EdgeInsets.all(2),
          decoration: BoxDecoration(
              color: ((widget.active&&_canTap)?Const.yellow:Const.grey_190_190_190).withOpacity(.5),
              shape: BoxShape.circle
          ),
          child: Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: widget.active?Const.yellow:Const.grey_190_190_190,
                shape: BoxShape.circle
            ),
            child: IconTheme(data:
                IconThemeData(
                  size: SC.from_width(20)
                )
                , child:(_canTap==false)?Padding(
                  padding: const EdgeInsets.all(2),
                  child: const CircularProgressIndicator(strokeWidth: 2,color: Colors.black,),
                ): widget.icon??SizedBox()),
          ),
        ),
      ),
    );
  }
}
