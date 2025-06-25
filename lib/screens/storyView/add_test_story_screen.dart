import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:attach/api/apiPath.dart';
import 'package:attach/api/local_db.dart';
import 'package:attach/api/storyApi.dart';
import 'package:attach/myfile/action%20Button.dart';
import 'package:attach/myfile/animated%20dilog.dart';
import 'package:attach/myfile/screen_dimension.dart';
import 'package:attach/providers/my_hleper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
// Optional: to save image



List<Color> _randomColors = [
  Color(0xFFe57373), // Light Red
  Color(0xFF81c784), // Light Green
  Color(0xFF64b5f6), // Light Blue
  Color(0xFFffd54f), // Yellow
  Color(0xFFba68c8), // Purple
  Color(0xFF4db6ac), // Teal
  Color(0xFFf06292), // Pink
  Color(0xFFa1887f), // Brown
  Color(0xFF90a4ae), // Grey Blue
  Color(0xFFff8a65), // Orange
];


class AddTestStoryScreen extends StatefulWidget {
  const AddTestStoryScreen({super.key});

  @override
  State<AddTestStoryScreen> createState() => _AddTestStoryScreenState();
}

class _AddTestStoryScreenState extends State<AddTestStoryScreen> {







  GlobalKey _globalKey = GlobalKey();

  late Color selectedColor;

  initState() {
    super.initState();
    selectedColor = _randomColors[Random().nextInt(_randomColors.length)];
  }


  Future<Uint8List?> _captureAndSave() async {

    try {
      RenderRepaintBoundary boundary = _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      return pngBytes;

      // Or do something else with the pngBytes like upload or display
    } catch (e) {
      print('Error capturing image: $e');
    }
  }



  Future<void> uploadImage(Uint8List pngBytes) async {
    try {
      print("Uploading image");
      var resp = await StoryApi().uploadStoryImageBytes(imageBite:pngBytes);

      switch (resp.statusCode) {
        case 201:
          MyHelper.snakeBar(context,title: 'Story uploaded',message: 'Story uploaded successfully',type: SnakeBarType.success);
          Navigator.pop(context);
          break;
        case 400:
          MyHelper.snakeBar(context,title: 'Story not uploaded',message: jsonDecode(resp.body)['message'],type: SnakeBarType.error);
          break;

          case 401:
            MyHelper.tokenExp(context);
            break;

        case 500:
          MyHelper.serverError(context, resp.body);
          break;
        default:
          print('Unknown error');
      }


    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  bool _showColors = false;

  bool _isType = false;



  @override
  Widget build(BuildContext context) {
    return Scaffold(

      extendBody: true,
      extendBodyBehindAppBar: true,


      appBar: AppBar(
        backgroundColor: Colors.transparent,

        actions: [
          // IconButton(onPressed:(){
          //
          // }, icon: Icon(Icons.text_fields,size: SC.from_width(25),),),
          IconButton(onPressed: (){
            _showColors = !_showColors;
            setState(() {});
          }, icon: Icon(Icons.color_lens,size: SC.from_width(25),),),

          if(_isType)
            IconButton(onPressed: () async{

              FocusScope.of(context).unfocus();

              OpenDailogWithAnimation(context,
                  barriarDissmesible: false, dailog: (animation, secondryAnimation) => Center(child: CircularProgressIndicator(color: Colors.white,),),);

              await Future.delayed(Duration(milliseconds: 300));
             var value = await _captureAndSave();

             await uploadImage(value!);
             Navigator.pop(context);

            }, icon: Text('Done',style: TextStyle(color: Colors.white,fontSize: SC.from_width(16),fontWeight: FontWeight.w900),),),

          const SizedBox(width: 14,)
        ],

      ),

      body: Stack(
        children: [


          Positioned(
            top: 0,
            right: 0,
            bottom: 0,
            left: 0,
            child: RepaintBoundary(
              key: _globalKey,
              child: Container(
                color: selectedColor,
                padding: EdgeInsets.all(20),
                child: Center(
                  child: TextField(
                    onChanged: (d){
                      if(d.isEmpty&&_isType==true)
                        {
                          _isType = false;
                          setState(() {});
                        }
                      else if(d.isNotEmpty&&_isType==false) {
                        _isType = true;
                        setState(() {});

                      }
                    },
                    maxLines: null,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: 'Type your story',
                      hintStyle: TextStyle(fontSize: 24, color: Colors.white,),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      focusedErrorBorder:  InputBorder.none,
                      errorBorder: InputBorder.none,
                    ),
                    style: TextStyle(fontSize: 24, color: Colors.white,fontWeight: FontWeight.w700),
                    cursorColor: selectedColor,
                  ),
                ),
              ),
            ),
          ),


          if(_showColors)
            Positioned(
              bottom: SC.from_width(30),
              right: 0,
              left: 0,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    for (int i = 0; i < _randomColors.length; i++)
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            selectedColor = _randomColors[i];
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 3),
                          decoration: BoxDecoration(
                            border :Border.all(
                                color: Colors.white,
                                width:selectedColor==_randomColors[i]?2:1
                            ),
                            shape: BoxShape.circle,
                            color: _randomColors[i],
                          ),
                          height: 40,
                          width: 40,
                          child: selectedColor==_randomColors[i]?Icon(Icons.check):null,
                        ),
                      )
                  ],
                ),
              ),
            ),


        ],
      ),
    );
  }
}
