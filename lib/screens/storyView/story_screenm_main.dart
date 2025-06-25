import 'package:attach/providers/story_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StoryScreenMain extends StatefulWidget {
  const StoryScreenMain({super.key});

  @override
  State<StoryScreenMain> createState() => _StoryScreenMainState();
}

class _StoryScreenMainState extends State<StoryScreenMain> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var  p = Provider.of<StoryProvider>(context,listen: false);


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(


    );
  }
}
