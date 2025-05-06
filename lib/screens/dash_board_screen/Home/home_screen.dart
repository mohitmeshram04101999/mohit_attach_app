import 'package:attach/api/fake_db.dart';
import 'package:attach/componant/online_user_widget.dart';
import 'package:attach/myfile/screen_dimension.dart';
import 'package:attach/screens/dash_board_screen/Home/hoem_story_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(

        physics: BouncingScrollPhysics(),

        padding: EdgeInsets.only(
          top: SC.from_width(20)
        ),
        children: [

          //image Slider
          CarouselSlider(
              items: [
                
                for(int i =0;i<4;i++)
                  Container(
                    clipBehavior: Clip.hardEdge,
                    margin: EdgeInsets.symmetric(horizontal: 14),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(15)
                    ),
                      child: Image.asset("assets/static/homeBanner.png",fit: BoxFit.cover,))
      
              ],
              options: CarouselOptions(
                height: SC.from_width(101),
                viewportFraction: 1
              )),
          SizedBox(height: SC.from_width(18),),


          SingleChildScrollView(

            primary: false,
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Row(
                children: [
                  for(Map d in FakeDb.homeStory())
                    Padding(

                        padding: EdgeInsets.only(right: SC.from_width(9)),
                        child: HomeStoryWidget(data: d,))

                ],
              ),
            ),
          ),

          SizedBox(height: SC.from_width(10),),


          for(Map d in FakeDb.onlineUser())
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: OnlineUserWidget(data: d,),
            )
      
        ],
      ),
    );
  }
}
