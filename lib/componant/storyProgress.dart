import 'package:flutter/material.dart';

class StoryProgressBar extends StatefulWidget {
  final bool isVideo;
  final Duration duration;
  const StoryProgressBar({this.isVideo = false, required this.duration,super.key});

  @override
  State<StoryProgressBar> createState() => _StoryProgressBarState();
}

class _StoryProgressBarState extends State<StoryProgressBar> with TickerProviderStateMixin {

  late AnimationController _controller;


  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _controller.reset();
    _controller.forward();
  }

  @override
  void didUpdateWidget(covariant StoryProgressBar oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    // Check if duration changed
    if (oldWidget.duration != widget.duration) {
      _controller.stop();
      _controller.dispose();
      _controller = AnimationController(vsync: this,duration: widget.duration);
      _controller.forward();
    }
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(vsync: this,duration: widget.duration);
    _controller.forward();

  }

  @override
  Widget build(BuildContext context) {
    int d = 100;

    return AnimatedBuilder(
      animation: _controller, // Listen to the controller directly
      builder: (context, child) {
        return Container(
          clipBehavior: Clip.hardEdge,
          margin: EdgeInsets.symmetric(horizontal: 2),
          height: 2,
          decoration: BoxDecoration(
            color: Colors.grey.shade500,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              for (int i = 0; i < d; i++)
                Expanded(
                  child: Container(
                    color: _controller.value * d > i ? Colors.white : null,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

}
