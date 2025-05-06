import 'package:attach/componant/circule_button.dart';
import 'package:attach/const/app_constante.dart';
import 'package:attach/myfile/screen_dimension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';



class OnlineUserWidget extends StatelessWidget {
  final Map? data;
  const OnlineUserWidget({this.data,super.key});

  @override
  Widget build(BuildContext context) {


    //
    return Container(
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.symmetric(vertical: SC.from_width(10)),

      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius:BorderRadius.circular(12),
        border: Border.all(color: Const.yellow)
      ),


      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [



          //Profile
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [



              //profile image
              SizedBox(
                height: SC.from_width(56),
                width: SC.from_width(56),
                child: Stack(
                  children: [

                    Container(
                      height: double.infinity,
                      width: double.infinity,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        color: Const.primeColor,
                        shape: BoxShape.circle,
                      ),
                      child: Image.network("${data?['image']}",fit: BoxFit.cover,),
                    ),


                    Positioned(
                      bottom: 0,right: 0,
                      child: Container(
                        height: SC.from_width(16),
                        width: SC.from_width(16),
                        decoration: BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                          border:Border.all(color: Colors.white,width: 2)
                        ),
                      ),
                    ),



                  ],

                ),
              ),
              SizedBox(width: SC.from_width(10),),


              //
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                  
                  // name Row
                  Row(
                    children: [
                      
                      
                      Text("${data?['name']??''}",style: Const.font_900_20(context),),
                      SizedBox(width: SC.from_width(10),),
                      Image.asset("assets/icons/verIcon.png",width: SC.from_width(24),),
                      Spacer(),
                      Text("Following",style: Const.font_500_16(context),),
                    ],
                  ),
                    SizedBox(height: SC.from_width(2),),


                    // age row
                    Row(
                      children: [


                        Text("${data?['gender']??''} : ${data?['age']??''}",style: Const.font_500_14(context),),
                        Spacer(),
                        StarRating(rating: 3.5,size: SC.from_width(17),
                        emptyIcon: Icons.star_rate_rounded,
                          color:Const.yellow,
                          filledIcon: Icons.star_rate_rounded,
                        ),
                      ],
                    ),
                    SizedBox(height: SC.from_width(2),),
                    


                    //
                    Row(
                      children: [


                        Text("Experience : ${data?['Experience']}",style: Const.font_400_12(context),),

                        Spacer(),
                        Text("5.0 (2K+)",style: Const.font_500_16(context,size: SC.from_width(12)),),
                      ],
                    ),

                
                
                ],),
              )

            ],
          ),
          SizedBox(height: SC.from_width(10),),


          //Disc
          Text("${data?['about']}",
          style: Const.font_400_12(context,size: SC.from_width(14)),
          ),
          SizedBox(height: SC.from_width(10),),


          Row(
            children: [
              Expanded(child: SizedBox()),
              
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                
                    CirclButton(
                      icon: Center(child: Image.asset('assets/icons/onlinwidgetIcons/Group (8).png',width: SC.from_width(16), ),),
                    ),
                
                
                    CirclButton(
                      icon: Center(child: Image.asset('assets/icons/onlinwidgetIcons/Vector (17).png',width: SC.from_width(16), ),),
                    ),
                
                    CirclButton(
                      icon: Center(child: Image.asset('assets/icons/onlinwidgetIcons/Vector (18).png',width: SC.from_width(16), ),),
                    ),
                
                
                
                
                
                
                
                  ],
                ),
              ),
            ],
          )
          

        ],
      ),

      //



    );



  }
}
