import 'package:flutter/material.dart';
import 'dart:math';


Offset DrawCircal(double radius, Offset center, double rotation) {
  double radians = (rotation * (pi / 180))*2;
  double x = center.dx + radius * cos(radians)/2;
  double y = center.dy + radius * sin(radians)/2;
  return Offset(x, y);
}


double PerraBolaEq(double v)
{
  double k = -(v*v)+v;
  return k;
}

Offset DrawWave(double i) {
  double x = i;
  double y = 350/(i*sin(i/8));
  return Offset(x, y);
}


double distence_beetween_points(Offset p1,Offset p2)
{
   double x = p2.dx - p1.dx;
   double y = p2.dy - p1.dy;
   double d = sqrt((x*x)+(y*y));
   return d;
}