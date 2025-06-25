import 'package:attach/myfile/customClips.dart';
import 'package:flutter/material.dart';
enum dailogAnimation
{
  slidLeft,
  slidRight,
  slidDown,
  slidUp,
  scale,
  rotation,
  fade,
  clip,
}


dynamic OpenDailogWithAnimation(
    BuildContext context,{
      Color barriarColor = Colors.black38,
      required Widget Function(Animation<double> animation, Animation<double> secondryAnimation) dailog,
      Duration? duration,
      Curve curve =Curves.linear,
      Curve reversCurve =Curves.linear,
      dailogAnimation animation = dailogAnimation.slidDown,
      bool barriarDissmesible = true,
      Rect clipSartRect = const Rect.fromLTWH(0, 0, 0, 0),
    }) async
{
  duration = duration??Duration(milliseconds: 300);

  //Open Dailog
  var value = await showGeneralDialog(

    //context
      context: (context),

      barrierColor: barriarColor,


      //transito duration
      transitionDuration: duration,

      barrierDismissible: barriarDissmesible,

      barrierLabel: "",


      //transition builder
      transitionBuilder: (context,apanimation,secondryanimation,child)
      {

        //switch
        switch(animation)
            {

              //slid up
        case(dailogAnimation.slidUp):
            {
              Tween<Offset> tween = Tween(begin: Offset(0,1),end: Offset.zero);
              return SlideTransition(
                position: tween.animate(CurvedAnimation(parent: apanimation, curve: curve,reverseCurve: reversCurve)),
                child: child,
              );
            }

            //slid left
            case(dailogAnimation.slidLeft):
        {
          Tween<Offset> tween = Tween(begin: Offset(1,0),end: Offset.zero);
          return SlideTransition(
            position: tween.animate(CurvedAnimation(parent: apanimation, curve: curve,reverseCurve: reversCurve)),
            child: child,
          );
        }

        //slide rigt
          case(dailogAnimation.slidRight):
            {
              Tween<Offset> tween = Tween(begin: Offset(-1,0),end: Offset.zero);
              return SlideTransition(
                position: tween.animate(CurvedAnimation(parent: apanimation, curve: curve,reverseCurve: reversCurve)),
                child: child,
              );
            }

            //slide up
          case(dailogAnimation.fade):
            {
              Tween<double > tween = Tween(begin: 0,end:1);
              return FadeTransition(
                opacity: tween.animate(CurvedAnimation(parent: apanimation, curve: curve,reverseCurve: reversCurve)),
                child: child,
              );
            }

          case(dailogAnimation.scale):
            {
              Tween<double> tween = Tween(begin: 0,end: 1);
              return ScaleTransition(
                scale: tween.animate(CurvedAnimation(parent: apanimation, curve: curve,reverseCurve: reversCurve)),
                child: child,
              );
            }

          case(dailogAnimation.rotation):
            {
              Tween<double> tween = Tween(begin: 0.0,end: 1.0);
              return ScaleTransition(
                scale: tween.animate(CurvedAnimation(parent: apanimation, curve: curve,reverseCurve: reversCurve)),
                child: RotationTransition(
                  turns: tween.animate(CurvedAnimation(parent: apanimation, curve: curve,reverseCurve: reversCurve)),
                  child: child,
                ),
              );
            }

          case(dailogAnimation.clip):
            {
              var tween = RectTween(
                begin: clipSartRect,
                  end: Rect.fromLTWH(0,0,MediaQuery.of(context).size.width,MediaQuery.of(context).size.height),
              );
              return ClipPath(
                clipper: CircleFromRectClipper(tween.animate(apanimation).value!),
                child: child,
              );
            }

              //default animatio
              default:
                {
                  Tween<Offset> tween = Tween(begin: Offset(0,-1),end: Offset.zero);
                  return SlideTransition(
                    position: tween.animate(CurvedAnimation(parent: apanimation, curve: curve,reverseCurve: reversCurve)),
                    child: child,
                  );
                }
        }
      },

      //builder
      pageBuilder: (context,a,b)=>dailog(a,b),

  );
  return value;
}