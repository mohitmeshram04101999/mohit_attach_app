import 'package:attach/componant/custome_action_button.dart';
import 'package:attach/const/app_constante.dart';
import 'package:attach/myfile/screen_dimension.dart';
import 'package:flutter/material.dart';

class ListerCard extends StatelessWidget {
  final void Function()? onTap;
  const ListerCard({this.onTap,super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: SC.from_width(14),
      vertical: SC.from_width(16)),
      decoration: BoxDecoration(
        
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Const.yellow,
          width: 1,
        ),

        boxShadow: [
          BoxShadow(
            color: Const.yellow.withOpacity(.7),
            blurRadius: 4
          )
        ],
 
        color: Const.primeColor
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Want to become a Listener?",style: Const.font_500_18(context),),
          SizedBox(height: SC.from_width(6),),
          Text("Start your journey by completing Aadhaar KYC verification",style: Const.font_400_12(context),),
          SizedBox(height: SC.from_width(8),),
          SizedBox(
            height: SC.from_width(44),
              child: CustomActionButton(action: (){
                if(onTap!=null)
                  {
                    onTap!();
                  }
              },lable: 'Become a Listener',)),
          SizedBox(height: SC.from_width(1),)

        ],
      ),
    );
  }
}
