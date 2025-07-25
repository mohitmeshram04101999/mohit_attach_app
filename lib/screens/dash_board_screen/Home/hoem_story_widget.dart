import 'package:attach/const/app_constante.dart';
import 'package:attach/modles/home_data_responce_model.dart';
import 'package:attach/myfile/myast%20dart%20file.dart';
import 'package:attach/myfile/routanimationConfigration.dart';
import 'package:attach/myfile/screen_dimension.dart';
import 'package:attach/screens/storyView/view_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';


class HomeStoryWidget extends StatelessWidget {
  final StoryModel? data;
  final bool self;
  const HomeStoryWidget({this.self = false,this.data,super.key});

  @override
  Widget build(BuildContext context) {


    return Column(
      children: [
        SizedBox(
          height: SC.from_width(73),
          width: SC.from_width(73),
          child: Stack(
            children: [
              SfRadialGauge(

                enableLoadingAnimation: false,

                axes: [
                  RadialAxis(
                    endAngle: 360,
                    startAngle: 0,
                    showTicks: false,
                    maximum:360,
                    minimum: 0,
                    annotations: [
                      GaugeAnnotation(
                          widget: Container(
                              clipBehavior: Clip.hardEdge,
                              margin: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Const.scaffoldColor,
                              ),
                              child: Container(
                                clipBehavior: Clip.hardEdge,
                                margin: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: Image.network(
                                  data?.listener?.image??'',
                                  height: double.infinity,
                                  width: double.infinity,
                                  errorBuilder: (context, error, stackTrace)=>Container(
                                    color: Color.fromRGBO(97, 97, 97, .58),
                                  ),
                                  fit: BoxFit.cover,),
                              )))
                    ],
                    showLabels: false,


                    ranges: List.generate(data?.stories?.length??0, (i) {

                      var stoCount = data?.stories?.length??0;

                      var gSize = 360/stoCount;

                      var gap = data?.stories?.length==1?0:5;


                      double start = (i.toDouble()*gSize)+gap;
                      double end = start+gSize-gap;

                        return GaugeRange(
                          startValue: start,
                          endValue: end,
                          color: data?.stories?[i].seen==true?Const.grey_190_190_190:Const.yellow,
                          endWidth: 3,
                          startWidth: 3,
                        );

                        },),

                  )
                ],

              ),
              InkWell(
                borderRadius: BorderRadius.circular(100),
                onTap: ()
                {
                  RoutTo(context, child: (p0, p1) => StoryViewPage(

                    data: {'':''},storyId: data?.listener?.id,));
                },
                child: Container(
                  // color: Colors.red,
                  height: double.infinity,
                  width: double.infinity,

                ),
              )
            ],
          ),
        ),
        SizedBox(height: SC.from_width(3),),
        Text("${data?.listener?.name??''}${kDebugMode?'${data?.stories?.length}':''}",style: Const.font_500_12(context),)
      ],
    );
  }
}
