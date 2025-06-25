
import "dart:ui";

import "package:attach/myfile/customClips.dart";
import "package:flutter/material.dart";
import "package:attach/myfile/routanimationConfigration.dart";

import "my_math.dart";



//-------------------dimention--------------------------------


double Screen_height =0;
double Screen_width = 0;

void getScreen(BuildContext context)
{
  print(MediaQuery.of(context).size.height);
  print(MediaQuery.of(context).size.width);

  Screen_height = MediaQuery.of(context).size.height;
  Screen_width = MediaQuery.of(context).size.width;

  print(Screen_height);
  print(Screen_width);
}

double from_width(double n)
{
  double fgh = 375;
  double pr = (n*100)/fgh;
  double ans = (Screen_width/100)*pr;

  return ans;
}


double from_height(double n)
{
  double fgw = 812;
  double pr = (n*100)/fgw;
  double ans = (Screen_height/100)*pr;
  return ans;
}

//--------------Clips---------------------------------------
class myclip extends CustomClipper<Path>{

  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width*.25, 0);
    path.quadraticBezierTo(size.width*.33, 0, size.width*.4, size.height*.3);
    path.quadraticBezierTo(size.width*.5, size.height-20, size.width*.6,size.height*.3);
    path.quadraticBezierTo(size.width*.67, 0, size.width*.75, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return false;
  }
}

//---------Route----------------------------------------------------
Route createPageRoute(Widget Function(Animation,Animation) page,{RoutAnimationConfiguration configuration = const RoutAnimationConfiguration()}) {
  return PageRouteBuilder(
    transitionDuration: configuration.transitioDuration,
    reverseTransitionDuration: configuration.reversDuration,
    pageBuilder: (context, animation, secondaryAnimation) => page(animation,secondaryAnimation),


    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0); // Start off the screen to the right
      const end = Offset.zero;
      const curve = Curves.easeInOut;
      Curve? riversCurve;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: configuration.curve));
      var _tweem = Tween(begin: begin,end: end).animate(CurvedAnimation(parent: animation, curve: curve,reverseCurve: riversCurve));
      var offsetAnimation = animation.drive(tween);
      var curvedAnimation = CurvedAnimation(parent: animation, curve: curve,reverseCurve: riversCurve);


      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}

Route createPageRouteSlidDown(Widget Function(Animation,Animation) page,{RoutAnimationConfiguration configuration = const RoutAnimationConfiguration()}) {
  return PageRouteBuilder(
    transitionDuration: configuration.transitioDuration,
    reverseTransitionDuration: configuration.reversDuration,
    pageBuilder: (context, animation, secondaryAnimation) => page(animation,secondaryAnimation),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {

      //AnimationOne
      const begin = Offset(0, -1); // Start off the screen to the right
      const end = Offset.zero;
      const curve = Curves.easeInOut;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: configuration.curve));
      var offsetAnimation = animation.drive(tween);


      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}

Route createPageRouteSlidRight(Widget Function(Animation,Animation) page,{RoutAnimationConfiguration configuration = const RoutAnimationConfiguration()}) {
  return PageRouteBuilder(
    transitionDuration: configuration.transitioDuration,
    reverseTransitionDuration: configuration.reversDuration,
    pageBuilder: (context, animation, secondaryAnimation) => page(animation,secondaryAnimation),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(-1, 0); // Start off the screen to the right
      const end = Offset.zero;
      const curve = Curves.easeInOut;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: configuration.curve));
      var offsetAnimation = animation.drive(tween);
      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}


Route createPageRouteClipAnimation(Widget Function(Animation,Animation) page,{RoutAnimationConfiguration configuration = const RoutAnimationConfiguration()}) {
  return PageRouteBuilder(
    transitionDuration: configuration.transitioDuration,
    reverseTransitionDuration: configuration.reversDuration,
    pageBuilder: (context, animation, secondaryAnimation) => page(animation,secondaryAnimation),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0, 0); // Start off the screen to the right
      const end = Offset.zero;
      var size = MediaQuery.of(context).size;
      const curve = Curves.easeInOut;
      var tween = RectTween(

          begin: configuration.clipBeginPosition??Rect.fromLTRB(0, 0, 0, 0),
          end: Rect.fromLTWH(0,0,size.width,size.height),
        //

      ).animate(CurvedAnimation(parent: animation ,curve: configuration.curve));
      // var offsetAnimation = animation.drive(tween);
      return ClipPath(
        clipper:CircleFromRectClipper(tween.value!),
        child: child,
      );
    },
  );
}


Route createPageRouteSlidUp(Widget Function(Animation,Animation) page,{RoutAnimationConfiguration configuration = const RoutAnimationConfiguration()}) {
  return PageRouteBuilder(
    transitionDuration: configuration.transitioDuration,
    reverseTransitionDuration: configuration.reversDuration,
    pageBuilder: (context, animation, secondaryAnimation) => page(animation,secondaryAnimation),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0, 1); // Start off the screen to the right
      const end = Offset.zero;
      const curve = Curves.easeInOut;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: configuration.curve));
      var offsetAnimation = animation.drive(tween);
      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}



Route createPageRouteFade(Widget Function(Animation,Animation) page,{RoutAnimationConfiguration configuration = const RoutAnimationConfiguration()}) {
  return PageRouteBuilder(
    transitionDuration: configuration.transitioDuration,
    reverseTransitionDuration: configuration.reversDuration,
    pageBuilder: (context, animation, secondaryAnimation) => page(animation,secondaryAnimation),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      double b = 0;
      double e = 1;
      var tween = Tween(begin: b, end:e).chain(CurveTween(curve: configuration.curve));
      var opacityAnimation = tween.animate(animation);
      return FadeTransition(
        opacity:opacityAnimation,
        child: child,
      );
    },
  );
}



Route createPageRouteScale(Widget Function(Animation,Animation) page,{RoutAnimationConfiguration configuration = const RoutAnimationConfiguration()}) {
  return PageRouteBuilder(
    transitionDuration: configuration.transitioDuration,
    reverseTransitionDuration: configuration.reversDuration,
    pageBuilder: (context, animation, secondaryAnimation) => page(animation,secondaryAnimation),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      double begin = 0; // Start off the screen to the right
      double end = 1;
      Curve curve = configuration.curve;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);
      return ScaleTransition(
        scale: offsetAnimation,
        child: child,
      );
    },
  );
}


Route createPageRouteRotation(Widget Function(Animation,Animation) page,{RoutAnimationConfiguration configuration = const RoutAnimationConfiguration()}) {
  return PageRouteBuilder(
    transitionDuration: configuration.transitioDuration,
    reverseTransitionDuration: configuration.reversDuration,
    pageBuilder: (context, animation, secondaryAnimation) => page(animation,secondaryAnimation),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = 0.0; // Start off the screen to the right
      const end = 1.0;
      Curve curve = configuration.curve;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);
      return RotationTransition(
        turns: offsetAnimation,
        child: child,
      );
    },
  );
}

enum RoutAnimation{
  fade,
  slid,
  rotate,
  scale,
  slidUp,
  slidDown,
  slidRight,
  clip,
}


//Apun ka Tag
dynamic RoutTo(
    BuildContext context,
    {
      required Widget Function(Animation,Animation) child,
      RoutAnimation animation = RoutAnimation.slid,
      RoutAnimationConfiguration configuration = const RoutAnimationConfiguration()
    })async{

  var result;
  if(animation == RoutAnimation.fade)
  {
    result = await Navigator.of(context).push(createPageRouteFade(child,configuration:configuration));
  }
  if(animation == RoutAnimation.slid)
  {
    result = await Navigator.of(context).push(createPageRoute(child,configuration:configuration));
  }
  if(animation == RoutAnimation.scale)
  {
    result = await Navigator.of(context).push(createPageRouteScale(child,configuration:configuration));
  }
  if(animation == RoutAnimation.rotate)
  {
    result = await Navigator.of(context).push(createPageRouteRotation(child,configuration:configuration));
  }
  if(animation == RoutAnimation.slidDown)
  {
    result = await Navigator.of(context).push(createPageRouteSlidDown(child,configuration:configuration),);
  }
  if(animation == RoutAnimation.slidUp)
  {
    result = await Navigator.of(context).push(createPageRouteSlidUp(child,configuration:configuration));
  }
  if(animation == RoutAnimation.slidRight)
  {
    result = await Navigator.of(context).push(createPageRouteSlidRight(child,configuration:configuration));
  }
  if(animation == RoutAnimation.clip)
  {
    print("this is page Rout ");
    result = await Navigator.of(context).push(createPageRouteClipAnimation(child,configuration:configuration));
  }
  return result;
}








dynamic ReplaceTo(BuildContext context,{
  required Widget Function(Animation,Animation) child,
  RoutAnimation animation = RoutAnimation.fade,
  RoutAnimationConfiguration configuration =const RoutAnimationConfiguration(),
})async{
  var result;
  if(animation == RoutAnimation.fade)
  {
    result = await Navigator.of(context).pushReplacement(createPageRouteFade(child,configuration: configuration));
  }
  if(animation == RoutAnimation.slid)
  {
    result = await Navigator.of(context).pushReplacement(createPageRoute(child,configuration: configuration));
  }
  if(animation == RoutAnimation.scale)
  {
    result = await Navigator.of(context).pushReplacement(createPageRouteScale(child,configuration: configuration));
  }
  if(animation == RoutAnimation.rotate)
  {
    result = await Navigator.of(context).pushReplacement(createPageRouteRotation(child,configuration: configuration));
  }
  if(animation == RoutAnimation.slidDown)
  {
    result = await Navigator.of(context).pushReplacement(createPageRouteSlidDown(child,configuration: configuration));
  }
  if(animation == RoutAnimation.slidUp)
  {
    result = await Navigator.of(context).pushReplacement(createPageRouteSlidUp(child,configuration: configuration));
  }
  if(animation == RoutAnimation.slidRight)
  {
    result = await Navigator.of(context).pushReplacement(createPageRouteSlidRight(child,configuration: configuration));
  }
  if(animation == RoutAnimation.clip)
  {
    result = await Navigator.of(context).pushReplacement(createPageRouteClipAnimation(child,configuration: configuration));
  }
  return result;
}



dynamic ReplaceAll(BuildContext context,{
  required Widget Function(Animation,Animation) child,
  RoutAnimation animation = RoutAnimation.fade,
  RoutAnimationConfiguration configuration =const RoutAnimationConfiguration(),
})async{
  var result;
  if(animation == RoutAnimation.fade)
  {
    result = await Navigator.of(context).pushAndRemoveUntil(createPageRouteFade(child,configuration: configuration),(route) => false,);
  }
  if(animation == RoutAnimation.slid)
  {
    result = await Navigator.of(context).pushAndRemoveUntil(createPageRoute(child,configuration: configuration),(route) => false,);
  }
  if(animation == RoutAnimation.scale)
  {
    result = await Navigator.of(context).pushAndRemoveUntil(createPageRouteScale(child,configuration: configuration),(route) => false,);
  }
  if(animation == RoutAnimation.rotate)
  {
    result = await Navigator.of(context).pushAndRemoveUntil(createPageRouteRotation(child,configuration: configuration),(route) => false,);
  }
  if(animation == RoutAnimation.slidDown)
  {
    result = await Navigator.of(context).pushAndRemoveUntil(createPageRouteSlidDown(child,configuration: configuration),(route) => false,);
  }
  if(animation == RoutAnimation.slidUp)
  {
    result = await Navigator.of(context).pushAndRemoveUntil(createPageRouteSlidUp(child,configuration: configuration),(route) => false,);
  }
  if(animation == RoutAnimation.slidRight)
  {
    result = await Navigator.of(context).pushAndRemoveUntil(createPageRouteSlidRight(child,configuration: configuration),(route) => false,);
  }
  if(animation == RoutAnimation.clip)
  {
    result = await Navigator.of(context).pushAndRemoveUntil(createPageRouteClipAnimation(child,configuration: configuration),(route) => false,);
  }
  return result;
}


//-------------------Jump Animation Slider---------------------------------

class JumpAppearAnimation extends StatelessWidget {
  Widget? child;
  double jumpHeight;
  Curve? curve;
  Duration? duration;
  JumpAppearAnimation({this.duration,this.curve,this.jumpHeight = 60,this.child});

  Tween<double > jump= Tween<double >(begin:0,end: 1);

  @override
  Widget build(BuildContext context) {
    var  animation = CurveTween(curve: Curves.linear,);
    return TweenAnimationBuilder(
      tween: jump,
      curve: curve??Curves.bounceOut,
      duration: duration??Duration(milliseconds: 1000),
      builder: (context,value,child){
        return  Padding(
          padding: EdgeInsets.only(bottom:PerraBolaEq(value)*jumpHeight*4),
          child: this.child,
        );
      },

    );
  }
}




//-----------------------------------My Wave Slider ---------------------------------------------------------------------------------------------------






class WaveSlider extends StatefulWidget {
  double curvetop;
  double curvWidth;
  double ancureSize;
  double blur ;
  double minValue;
  double maxValue;
  double elevetion ;
  Color thumbColor;
  Color shadowColor;
  double thickness;
  double height;
  double width;
  double value;
  double thumbSize;
  double inactiveHeight;
  bool offset;
  Color color;
  Color ancureColor;
  double dragPercent =0;
  Function(double n)? onDrag;
  WaveSlider({this.ancureSize = 8,this.curvWidth= 80,this.curvetop = 25,this.minValue = 0,this.maxValue = 100,this.shadowColor = Colors.grey,this.elevetion = 0,this.blur  = 0,this.offset = true,this.thickness = 5,this.ancureColor = Colors.black,this.color = Colors.black,this.inactiveHeight = 10,this.thumbColor = Colors.black,this.thumbSize = 7,this.onDrag,this.value = 0,this.width = double.infinity,this.height = 50})
  {
    ;
  }
  @override
  State<WaveSlider> createState() => _WaveSliderState();
}

class _WaveSliderState extends State<WaveSlider> with TickerProviderStateMixin {
  GlobalKey _containerKwy = GlobalKey();



  double canvasWidth = 0;
  @override

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

  }
  double sliderPosition = 0;


  bool is_draging = false;

  void returnvalue()
  {

  }
  @override
  Widget build(BuildContext context) {

    sliderPosition = (widget.value- widget.minValue)*100/(widget.maxValue - widget.minValue);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      child: Stack(
        children: [
          GestureDetector(
            //----------------------------------------------------
            onHorizontalDragStart: (d){
              var box = _containerKwy.currentContext!.findRenderObject() as RenderBox;
              canvasWidth = box.size.width;
              double dragPr = (d.localPosition.dx*100)/canvasWidth;

              double diffrence = (widget.maxValue-widget.minValue);
              double valpr = diffrence/100*dragPr;
              double rvalue = widget.minValue+valpr;
              rvalue = (rvalue<widget.minValue)?widget.minValue:rvalue;
              rvalue = (rvalue>widget.maxValue)?widget.maxValue:rvalue;

              if(widget.onDrag!=null)
              {
                widget.onDrag!(rvalue);
              }
              is_draging = true;setState(() {});},
            //------------------------------------------------------
            onHorizontalDragEnd: (d){is_draging = false;setState(() {});
            },
            //----------------------------------------------------------
            onHorizontalDragUpdate: (d){

              var box = _containerKwy.currentContext!.findRenderObject() as RenderBox;
              canvasWidth = box.size.width;
              double dragPr = (d.localPosition.dx*100)/canvasWidth;

              double diffrence = (widget.maxValue-widget.minValue);
              double valpr = diffrence/100*dragPr;
              double rvalue = widget.minValue+valpr;
              rvalue = (rvalue<widget.minValue)?widget.minValue:rvalue;
              rvalue = (rvalue>widget.maxValue)?widget.maxValue:rvalue;

              if(widget.onDrag!=null)
              {
                widget.onDrag!(rvalue);
              }

            },
            //------------------------------------------------------------
            child: Container(
              key: _containerKwy,
              padding: EdgeInsets.only(bottom: 20),
              height: widget.height+20,
              width: widget.width,
              child: CustomPaint(

                //Initialize paint -----------------------------------------
                painter: wavePainter(
                    elevation: widget.elevetion,
                    shadowColor: widget.shadowColor,
                    blur: widget.blur,
                    offset: widget.offset,
                    thickness: widget.thickness,
                    sliderColor: widget.color,
                    thumbsize: widget.thumbSize,
                    dragging: is_draging,
                    value: sliderPosition,
                    thumbColor: widget.thumbColor,
                    curveGap: widget.inactiveHeight,
                    ancureColor: widget.ancureColor,
                    curveWidth:widget.curvWidth,
                    ancurSize: widget.ancureSize
                ) ,
                child: SizedBox(
                  height: double.infinity,
                  width: double.infinity,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}







class wavePainter extends CustomPainter
{
  double blur;
  double value;
  double curveWidth;
  double bend;
  double thickness;
  bool dragging;
  double thumbsize;
  double curveGap;
  Color thumbColor;
  Color ancureColor;
  Color sliderColor;
  bool offset;
  double elevation;
  Color shadowColor;
  double canvaswidth;
  double ancurSize;

  //constructor values  end

  double oldposition = 0;
  double maxbend = 50;
  double maxBendPow = 50;
  double diffrenc = 0;

  double curveStartPoint  = 0;
  double curveendPoint = 0;
  double controlPoint1x = 0;
  double controlPoint2x = 0;
  double curvetop = 0;
  double curvebottom = 0;
  double controlPoint3x = 0;
  double dragPercentage = 0;
  double controlPoint4x = 0;
  double sliderposition = 0;

  // double color;
  wavePainter({this.ancurSize = 8,this.canvaswidth = 0,this.shadowColor = Colors.grey,this.elevation = 0,this.blur = 0,this.offset=true ,this.thickness = 5,this.sliderColor = Colors.black,this.ancureColor = Colors.black,this.thumbColor =Colors.black,this.curveGap = 30,this.thumbsize = 5,this.dragging = false,this.bend = 0,required this.value,this.curveWidth = 80})
  {

  }


  Paint curvepaint = Paint();
  Paint shacurvepaint = Paint();

  // filter for value so valu ony under is height and width
  double filter(double n,Size s)
  {
    if(n<=0)
    {
      return 0;
    }
    else if(n>=s.width)
    {
      return s.width;
    }
    else{
      return n;
    }
  }

  //-----------funtion for every initialization--------------------------------------------------------------------------------------------
  void initvar(Size s)
  {
    //-------------------------------------------------------------------
    curvepaint
      ..color = sliderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = thickness
      ..strokeCap = StrokeCap.round
      ..imageFilter = ImageFilter.blur(sigmaX: blur,sigmaY: blur);

    //---------------------------------------------------------------------------------------------------------------------------------------------------------------------
    shacurvepaint
      ..color = shadowColor
      ..imageFilter = ImageFilter.blur(sigmaX:elevation,sigmaY:elevation)
      ..style = PaintingStyle.stroke
      ..strokeWidth = thickness+elevation/2;

    //-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    sliderposition =filter(( s.width/100)*value, s);
    curveStartPoint = filter(sliderposition -curveWidth/2, s);
    curveendPoint = filter(sliderposition +curveWidth/2, s);
    maxbend = 35;
    double posdiffrence = oldposition-sliderposition;
    bend = (posdiffrence.abs()>maxbend)?((posdiffrence>0)?maxbend:maxbend*-1):posdiffrence;

    bend = (dragging)?bend*1.5:0;

    controlPoint1x = filter(sliderposition- curveWidth/4 , s);
    controlPoint2x = filter(sliderposition-curveWidth/4, s);
    controlPoint3x = filter(sliderposition+curveWidth/4, s);
    controlPoint4x = filter(sliderposition+curveWidth/4, s);
    curveGap = (curveGap>s.height)?s.height:curveGap;
    curvetop =(dragging)?0: s.height- curveGap;


    //------------------------------------------------------------------

  }


//-----------------------------------------------------paint method-------------------------------------------------------------------


  @override
  void paint(Canvas canvas, Size size) {
    initvar(size);
    drawLine(canvas, size);
    drawWave(canvas, size);
    create_erncer(canvas, size);
  }

//-------------------------------------------------crate ancure mathod------------------------------------------------------------


  void create_erncer(Canvas canvas,Size s)
  {
    Paint ancurPaint = Paint()
      ..color = ancureColor
      ..style = PaintingStyle.fill;
    Paint thumbPaint = Paint()
      ..color = thumbColor
      ..style = PaintingStyle.fill;
    Paint shadowthumbPaint = Paint()
      ..color = (thumbColor==Colors.transparent)?Colors.transparent:thumbColor.withOpacity(.5)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(Offset(0,s.height), ancurSize, ancurPaint);
    canvas.drawCircle(Offset(s.width,s.height), ancurSize, ancurPaint);
    if(dragging)
    {
      canvas.drawCircle(Offset(sliderposition,s.height), thumbsize+thumbsize*.2, shadowthumbPaint);
    }
    canvas.drawCircle(Offset(sliderposition,s.height), thumbsize, thumbPaint);
  }


  //-----------------------------------------------------------------crate Line------------------------------------------------------------
  void drawLine(Canvas canvas,Size s)
  {
    Path linePath = Path();
    linePath.moveTo(0,s.height);
    linePath.lineTo(curveStartPoint, s.height);
    linePath.moveTo(curveendPoint, s.height);
    linePath.lineTo(s.width, s.height);

    canvas.drawPath(linePath, shacurvepaint);
    canvas.drawPath(linePath, curvepaint);
  }
  //--------------------------------------------------------------create Wave-------------------------------------------------------------
  void drawWave(Canvas canvas,Size s)
  {
    Path wavePath = Path();
    wavePath.moveTo(curveStartPoint, s.height);
    wavePath.cubicTo(controlPoint1x, s.height, controlPoint2x+bend, curvetop, sliderposition+bend, curvetop);
    wavePath.cubicTo(controlPoint3x+bend, curvetop, controlPoint4x, s.height, curveendPoint, s.height);

    canvas.drawPath(wavePath,shacurvepaint);
    canvas.drawPath(wavePath,curvepaint);

  }


  @override
  bool shouldRepaint(covariant wavePainter oldDelegate) {
    oldposition = oldDelegate.sliderposition;
    // TODO: implement shouldRepaint
    return true;
  }

}


class MyInkWell extends StatelessWidget {
  Function? onTap;
  double? height;
  EdgeInsets? margin;
  EdgeInsets? padding;
  double? width;
  Widget? child;
  BoxDecoration? decoration;
  MyInkWell({this.onTap,this.padding,this.margin,this.child,this.decoration,this.height,this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      margin: margin,
      height: height,
      width: width,
      decoration: decoration,
      child: Card(
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(0)
        ),
        margin: EdgeInsets.zero,
        elevation: 0,
        color: Colors.transparent,
        clipBehavior: Clip.hardEdge,
        child: Ink(
          height:height,
          width: width,
          decoration: decoration,
          child: InkWell(
            child: Padding(
              padding:(padding!=null)?padding!:EdgeInsets.all(0),
              child: child,
            ),
            onTap: (){
              if(onTap!=null)
                {
                  onTap!();
                }
            },
          ),
        ),
      ),
    );
  }
}









//----------------------------------------------------------------------------------------------------------------------------------------------
