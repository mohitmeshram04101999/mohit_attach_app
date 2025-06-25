import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';


class DottedBorderButton extends StatelessWidget {
  final Widget title;
  final VoidCallback onTap;
  const DottedBorderButton({required this.title,required this.onTap,super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
        side: BorderSide.none,
      ),
      clipBehavior: Clip.hardEdge,
      color: Colors.transparent,
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: onTap,
        child: DottedBorder(
          color: Colors.white,
          borderType: BorderType.RRect,
          radius: Radius.circular(4),
          dashPattern: [5, 5],
          strokeCap: StrokeCap.round,
          child: Center(child: title),
        ),
      ),
    );
  }
}
