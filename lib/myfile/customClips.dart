import 'package:flutter/cupertino.dart';

class CircleClipper extends CustomClipper


<Path> {
  final double radius;

  CircleClipper({required this.radius});

  @override
  Path getClip(Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    return Path()..addOval(Rect.fromCircle(center: center, radius: radius));
  }

  @override
  bool shouldReclip(covariant CircleClipper oldClipper) {
    return radius != oldClipper.radius;
  }
}


class RectClipper extends CustomClipper<Rect> {
  final Rect rect;

  RectClipper(this.rect);

  @override
  Rect getClip(Size size) => rect;

  @override
  bool shouldReclip(covariant RectClipper oldClipper) {
    return rect != oldClipper.rect;
  }
}


class CircleFromRectClipper extends CustomClipper<Path> {
  final Rect rect;

  CircleFromRectClipper(this.rect);

  @override
  Path getClip(Size size) {
    final center = rect.center;
    final radius = rect.shortestSide*1.3; // use the smaller side for a perfect circle
    return Path()..addOval(Rect.fromCircle(center: center, radius: radius));
  }

  @override
  bool shouldReclip(covariant CircleFromRectClipper oldClipper) {
    return rect != oldClipper.rect;
  }
}