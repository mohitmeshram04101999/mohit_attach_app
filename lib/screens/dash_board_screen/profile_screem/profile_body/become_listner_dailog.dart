import 'package:attach/componant/eleveted_button_custom.dart';
import 'package:attach/const/app_constante.dart';
import 'package:attach/myfile/myast%20dart%20file.dart';
import 'package:attach/myfile/screen_dimension.dart';
import 'package:flutter/material.dart';



class BecomeListenerDailog extends StatelessWidget {
  final Animation<double> animation;
  const BecomeListenerDailog({required this.animation,super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AlertDialog(
        contentPadding: EdgeInsets.symmetric(horizontal: SC.from_width(19),vertical: SC.from_width(11)),
        insetPadding: EdgeInsets.symmetric(horizontal: SC.from_width(44)),
        backgroundColor: Const.primeColor,
        title: Text("Become a Listner",style: Const.font_500_16(context),),

        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Do you want to become a Listener? Once you switch to a Listener account, you won’t be able to return to a regular user account.",
            style: Const.font_400_12(context,color: Color.fromRGBO(190, 190, 190, 1)),),

           SizedBox(height: SC.from_width(28),),



           Row(children: [
             Expanded(
               child: ClipRect(

                 child: OutlinedButton(
                     style: ButtonStyle(
                         side: WidgetStateBorderSide.resolveWith((states) => BorderSide(color: Colors.white),)
                     ),
                     onPressed: (){
                       Navigator.pop(context,false);
                     }, child: Text("Cancle",style: Const.font_400_14(context,color: Colors.white))),
               ),
             ),

             SizedBox(width: SC.from_width(10),),
             //
             Expanded(
               child: ElevatedButton(
                 style: ButtonStyle(
                   padding: WidgetStateProperty.resolveWith((states) => EdgeInsets.symmetric(horizontal: SC.from_width(4)),)
                 ),
                 onPressed: (){
                   Navigator.pop(context,true);
                 },child: Text('Be a Listener',),),
             ),
           ],),



          ],
        ),
        
        actions: [


        ],
      ),
    );
  }
}







