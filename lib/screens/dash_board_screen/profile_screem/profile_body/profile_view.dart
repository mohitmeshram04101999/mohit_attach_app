import 'package:attach/componant/profile_aVTAR.dart';
import 'package:attach/const/app_constante.dart';
import 'package:attach/myfile/screen_dimension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';

class ProfileView extends StatelessWidget {
  final bool listner;
  const ProfileView({this.listner=true,super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

      ProfileAvtar(),
      SizedBox(width: SC.from_width(26),),

      Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
        
            //
            Row(
              children: [
                Text("Roshan Sharma",style: Const.font_700_16(context),),
                SizedBox(width: SC.from_width(5),),
                Image.asset("assets/icons/verIcon.png",width: SC.from_width(14),),
              ],
            ),
            SizedBox(height: SC.from_width(17),),
            Row(
              children: [
                Expanded(child: Text("6965",style: Const.font_400_12(context,size: SC.from_width(16)),)),
                if(listner)
                  Expanded(
                    flex: 2,
                      child: Text("Rating",style: Const.font_400_12(context,size: SC.from_width(14)),)),
              ],
            ),
            SizedBox(height: SC.from_width(7),),
        
            if(listner)...[
              
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                Expanded(
                    child: Text("Followers",style: Const.font_400_12(context,size: SC.from_width(14)),)),

                Expanded(
                  flex: 2,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                      StarRating(
                        filledIcon: Icons.star_rate_rounded,
                        emptyIcon: Icons.star_rate_rounded,
                        color: Const.yellow,
                        halfFilledIcon: Icons.star_half_rounded,
                        rating: 2,
                        allowHalfRating: false,
                        size: SC.from_width(18),
                      ),
                      Text("3.0 (2K+)",style: Const.font_500_12(context,color: Color.fromRGBO(190, 190, 190, 1)),)

                    ],)
                ),
              ],)
              
            ]
            else...[
              Text("Following",style: Const.font_400_12(context,size: SC.from_width(14)),),
            ]
            
        
          ],
        ),
      ),



    ],);
  }
}
