


import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';

class RoutAnimationConfiguration
{
  final Duration transitioDuration;
  final Duration reversDuration;
  final Curve curve;

  const RoutAnimationConfiguration({
    this.transitioDuration =const Duration(milliseconds: 500),
    this.reversDuration = const Duration(milliseconds: 500),
    this.curve = Curves.fastEaseInToSlowEaseOut,
});
}