import 'package:flutter/material.dart';


//My()..myconfigratio n =0;

class ExpandableCard extends StatefulWidget {
  double height;
  double width;
  Widget? child;
  Widget? title;
  Widget? subtitle;
  Widget? trailing;
  Offset? offset;
  double expand;
  double? bottomExpand;
  Duration? duration;
  Color? backGroundColor;
  Widget? backGround;
  Color? expandedBackgroundColor;
  ExpandableCard({
    this.height =150,
    this.width=100,
    this.child,
    this.bottomExpand,
    this.title,
    this.subtitle,
    this.trailing,
    this.offset,
    this.expand=20,
    this.duration,
    this.backGroundColor,
    this.expandedBackgroundColor,
    super.key});

  @override
  State<ExpandableCard> createState() => _ExpandableCardState();
}

class _ExpandableCardState extends State<ExpandableCard> {
  bool isExpended = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(

      onPanUpdate: (d){
        if(d.delta.dy>0)
        {
          isExpended = false;
          setState(() {

          });
        }
        if(d.delta.dy<0)
        {
          isExpended = true;
          setState(() {
          });
        }
      },
      child: SizedBox(
        height: widget.height,
        width: widget.width,

        child: Stack(
          clipBehavior: Clip.none,
          children: [


            AnimatedPositioned(
                top: 0,
                bottom: isExpended?((widget.bottomExpand==null)?-widget.expand:-widget.bottomExpand!):0,
                left: isExpended?-widget.expand:0,
                right: isExpended?-widget.expand:0,
                child: SizedBox.expand(
                  child: AnimatedOpacity(
                    opacity: isExpended?1:0,
                    curve: Interval(.5,1,curve: Curves.easeOut),
                    duration: Duration(milliseconds: 300),
                    child: Container(
                      color: widget.expandedBackgroundColor??Colors.white,
                      child:  Stack(
                        children: [



                          Align(
                              alignment: Alignment.bottomCenter,
                              child: ListTile(
                                titleTextStyle: Theme.of(context).textTheme.titleMedium,
                                subtitleTextStyle: TextStyle(color: Colors.grey.shade600),
                                title: widget.title,
                                subtitle: widget.subtitle,
                                trailing: widget.trailing,
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
                curve:Interval(.5,1,curve:Curves.easeOut),
                duration: Duration(milliseconds: 300)),

            AnimatedPositioned(
                top:(isExpended)?((widget.offset!=null)?-widget.offset!.dy:-50):0,
                bottom:(isExpended)?((widget.offset!=null)?widget.offset!.dy:50):0,
                left: (isExpended)?((widget.offset!=null)?widget.offset!.dx:0):0,
                right: (isExpended)?((widget.offset!=null)?-widget.offset!.dx:0):0,

                child: Container(
                  child: widget.child,
                  color: widget.backGroundColor,
                ),
                curve:Interval(0,1,curve:Curves.easeOut),
                duration: Duration(milliseconds: 300)),

          ],
        ),
      ),
    );
  }
}
