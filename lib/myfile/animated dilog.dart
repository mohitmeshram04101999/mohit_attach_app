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
}


dynamic OpenDailogWithAnimation(
    BuildContext context,{
      Color barriarColor = Colors.black38,
      required Widget dailog,
      Duration? duration,
      Curve curve =Curves.linear,
      dailogAnimation animation = dailogAnimation.slidDown,
      bool barriarDissmesible = true,
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
                position: tween.animate(CurvedAnimation(parent: apanimation, curve: curve)),
                child: child,
              );
            }

            //slid left
            case(dailogAnimation.slidLeft):
        {
          Tween<Offset> tween = Tween(begin: Offset(1,0),end: Offset.zero);
          return SlideTransition(
            position: tween.animate(CurvedAnimation(parent: apanimation, curve: curve)),
            child: child,
          );
        }

        //slide rigt
          case(dailogAnimation.slidRight):
            {
              Tween<Offset> tween = Tween(begin: Offset(-1,0),end: Offset.zero);
              return SlideTransition(
                position: tween.animate(CurvedAnimation(parent: apanimation, curve: curve)),
                child: child,
              );
            }

            //slide up
          case(dailogAnimation.fade):
            {
              Tween<double > tween = Tween(begin: 0,end:1);
              return FadeTransition(
                opacity: tween.animate(CurvedAnimation(parent: apanimation, curve: curve)),
                child: child,
              );
            }

          case(dailogAnimation.scale):
            {
              Tween<double> tween = Tween(begin: 0,end: 1);
              return ScaleTransition(
                scale: tween.animate(CurvedAnimation(parent: apanimation, curve: curve)),
                child: child,
              );
            }

          case(dailogAnimation.rotation):
            {
              Tween<double> tween = Tween(begin: 0.0,end: 1.0);
              return ScaleTransition(
                scale: tween.animate(CurvedAnimation(parent: apanimation, curve: curve)),
                child: RotationTransition(
                  turns: tween.animate(CurvedAnimation(parent: apanimation, curve: curve)),
                  child: child,
                ),
              );
            }

              //default animatio
              default:
                {
                  Tween<Offset> tween = Tween(begin: Offset(0,-1),end: Offset.zero);
                  return SlideTransition(
                    position: tween.animate(CurvedAnimation(parent: apanimation, curve: curve)),
                    child: child,
                  );
                }
        }
      },

      //builder
      pageBuilder: (context,_,_1)=>dailog

  );
  return value;
}