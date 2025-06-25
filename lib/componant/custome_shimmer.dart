import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomShimmer extends StatelessWidget {
  final Widget child;
  final bool loading;
  const CustomShimmer({this.loading = false,required this.child,super.key});

  @override
  Widget build(BuildContext context) {
    if(loading)
      {
        return Shimmer(
          gradient: LinearGradient(colors: [Colors.grey,Colors.grey.shade900]),
            child: AbsorbPointer(
              absorbing: true,
              child: child,
            ));
      }
    return child;
  }
}
