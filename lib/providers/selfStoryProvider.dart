import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:attach/api/local_db.dart';
import 'package:attach/api/storyApi.dart';
import 'package:attach/modles/home_data_responce_model.dart';
import 'package:attach/noticiation/notificationService.dart';
import 'package:attach/providers/my_hleper.dart';
import 'package:logger/logger.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

import 'package:flutter/material.dart';



class SelfStoryProvider with ChangeNotifier
{

  io.Socket? _socket;

  List<SelfStoryModel> _story = [];
  List<SelfStoryModel> get story =>_story;
  int _totalViews  = 0;
  int _storyIndex = 0;

  int get totalViews =>_totalViews;
  PageController _pageController = PageController();
  int get storyIndex =>_storyIndex;
  Timer? _timer;


  nextPage(BuildContext context)
  {
    if(_storyIndex<_story.length-1)
      {
        _pageController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.linear);
      }
    else
      {
        Navigator.of(context);
      }
  }

  previousPage()
  {
    if(_storyIndex>0)
      {
        _pageController.previousPage(duration: Duration(milliseconds: 300), curve: Curves.linear);
      }
  }



  stopTimer()
  {
    _timer?.cancel();
  }

  startAgainTimer(BuildContext context,{Duration? d})
  {
    _timer = Timer(d??Duration(seconds: 10), (){
      changePage(context);
    });
  }


  updateIndex(int i)
  {
    _storyIndex = i;
  }

  resatTimer(BuildContext context,{Duration? d})
  {
    _timer?.cancel();
    _timer = Timer(d??Duration(seconds: 10), (){
      changePage(context);
    });
  }


  updatePageController(BuildContext context,PageController p)
  {
    _pageController = p;
    _storyIndex = 0;
    _timer = Timer(Duration(seconds: 10), (){
      changePage(context);
    });
  }


  changePage(BuildContext context)
  {
    print("${_storyIndex}  == ${_totalViews}");
    if(_storyIndex<_story.length-1)
      {
        _pageController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.linear);
      }
    else{
      Navigator.pop(context);
    }
  }




  setSocket(io.Socket s)
  {
    print("this  is from set socket");
    _socket = s;
    init();
  }

  init()
  {
    _socket?.on("myStory",_myStory);
    _socket?.emit("selfStory",{'listenerId':DB.curruntUser?.id});
  }


  _myStory(dynamic data)
  {
    Logger().i(data);
    List d = data['data'];
    _story = d.map((e) => SelfStoryModel.fromJson(e),).toList();
    print("Setting Length ${_story.length}");
    _totalViews = _story.length;
    notifyListeners();
  }

  clear()
  {
    print("Story stare clear");
    _timer?.cancel();
    _storyIndex = 0;
  }





  disconnectSocket()
  {
    _socket?.offAny();
    _socket?.destroy();
    _socket = null;
    _story = [];
    _totalViews = 0;
    _storyIndex = 0;

  }

  deleteStory(BuildContext context,String storyId) async
  {
    var resp = await   StoryApi().deleteStory(storyId: storyId);

    switch(resp.statusCode)
    {
      case 200:

        int _i  = _pageController.page?.toInt()??0;

        int _s = _story.indexWhere((element) => element.id == storyId);

        if(_story.length==1)
          {
            Navigator.pop(context);
          }
        else if(_i==0||_i==_story.length>1)
          {
            // _pageController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.linear);
          }
        else
          {
            _pageController.previousPage(duration: Duration(milliseconds: 300), curve: Curves.linear);
          }

        _story.removeWhere((element) => element.id == storyId);
        break;

      case 400:
         MyHelper.snakeBar(context, title: "Bad request", message: jsonDecode(resp.body)['message']);
        break;
      case 401:
        MyHelper.tokenExp(context);
        break;
      case 403:
        MyHelper.snakeBar(context, title: "Ristrict", message: jsonDecode(resp.body)['message']);
        break;
      case 404:
        MyHelper.snakeBar(context, title: "Not Found", message: jsonDecode(resp.body)['message']);
        break;
      case 500:
        MyHelper.serverError(context, resp.body);
        break;
      default:
        MyHelper.serverError(context, resp.body);
        break;
    }
    notifyListeners();
  }



}