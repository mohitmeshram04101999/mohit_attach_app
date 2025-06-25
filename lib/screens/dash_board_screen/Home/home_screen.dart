import 'package:attach/api/fake_db.dart';
import 'package:attach/componant/custome_action_button.dart';
import 'package:attach/componant/custome_shimmer.dart';
import 'package:attach/componant/online_user_widget.dart';
import 'package:attach/const/app_constante.dart';
import 'package:attach/modles/home_data_responce_model.dart';
import 'package:attach/myfile/myast%20dart%20file.dart';
import 'package:attach/myfile/screen_dimension.dart';
import 'package:attach/providers/home_provider.dart';
import 'package:attach/providers/home_provider_1.dart';
import 'package:attach/screens/dash_board_screen/Home/hoem_story_widget.dart';
import 'package:attach/screens/home_sub_screen/listerFilterScreen.dart';
import 'package:attach/screens/home_sub_screen/notification_screen/notification_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(




      child: Scaffold(

        // floatingActionButton: (kDebugMode)?FloatingActionButton(onPressed: (){
        //
        //
        // }):null,


        appBar: AppBar(
          centerTitle: false,
          title: Image.asset('assets/icons/home_icon/logo4-removebg-preview 1.png',width: SC.from_width(103),),

          actions: [
            IconButton(onPressed: (){
              RoutTo(context, child:(p0, p1) =>  ListerFilterScreen());
            }, icon:Image.asset('assets/icons/home_icon/uil_search.png',width: SC.from_width(21),) ),

            Consumer<HomeProvider>(
              builder: (context, p, child) => AspectRatio(
                aspectRatio: 1,
                child: Container(
                  child: Stack(
                    children: [ 
                      Center(child: IconButton(onPressed: (){
                        RoutTo(context, child:(p0, p1) =>  NotificationScreen());
                      }, icon:Image.asset('assets/icons/home_icon/bell 1.png',width: SC.from_width(21),) )),
                     if(p.data?.notificationCount!=null&&p.data?.notificationCount!=0)
                       Positioned(
                           right: SC.from_width(12),
                           top: SC.from_width(12),
                           child: Container(
                               alignment: Alignment.center,
                               height: SC.from_width(15),
                               width: SC.from_width(15),

                               decoration: BoxDecoration(
                                   shape: BoxShape.circle,
                                   color: Colors.red
                               ),
                               child: Text("${(p.data?.notificationCount??0)<=99?p.data?.notificationCount:'+99'}",style: Const.font_900_20(context,size: SC.from_width(7)),)))
                    ],
                  ),
                ),
              ),
            ),
          ],

        ),


        body: Consumer<HomeProvider>(
          builder: (context, p, child) => ListView(



            physics: BouncingScrollPhysics(),

            padding: EdgeInsets.only(
                top: SC.from_width(20)
            ),
            children: [

              if(kDebugMode)
                Column(
                  children: [
                    Text("${p.data}"),
                    Text("${p.data?.homeBanner?.length}"),
                    Text("${p.data?.stories?.length}"),
                    Consumer<Socket_Provider>(builder: (context, value, child) => Text("${value}"),)
                  ],
                ),

              //image Slider
              CarouselSlider(
                  items: [
                    


                    for(int i =0;i<(p.data?.homeBanner?.length??0);i++)
                      Container(
                          clipBehavior: Clip.hardEdge,
                          margin: EdgeInsets.symmetric(horizontal: 14),
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(15)
                          ),
                          child: Image.network("${p.data?.homeBanner?[i]}",fit: BoxFit.cover,))

                  ],
                  options: CarouselOptions(
                      height: SC.from_width(101),
                      viewportFraction: 1,
                    enableInfiniteScroll: false
                  )),



              SizedBox(height: SC.from_width(18),),


              SingleChildScrollView(
                primary: false,
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Row(
                    children: [
                      for(StoryModel data in p.data?.stories??[])
                        Padding(
                            padding: EdgeInsets.only(right: SC.from_width(9)),
                            child: HomeStoryWidget(data:data,))

                    ],
                  ),
                ),
              ),

              // SizedBox(height: SC.from_width(10),),



              SizedBox(height: SC.from_width(10),),



              for(HomeListener l in p.data?.listeners??[])
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: CustomShimmer(loading: false,child:
                  OnlineUserWidget(
                    key: ValueKey(l.id),
                    onFollow: (){
                      Provider.of<HomeProvider>(context,listen: false).follow(context, l);
                    },
                    listener: l,
                  )),
                ),



              //
              // Container(
              //   height: SC.from_width(48),
              //   margin: EdgeInsets.symmetric(horizontal: 14,vertical: SC.from_width(10)),
              //   child: CustomActionButton(
              //     lable: 'View All',
              //     action: (){
              //
              //   },),
              // ),
              
              Center(child: OutlinedButton(onPressed: (){
                RoutTo(context, child: (p0, p1) =>ListerFilterScreen(),);
              }, child: Text("View All")))

            ],
          ),
        ),
      ),
    );
  }
}
