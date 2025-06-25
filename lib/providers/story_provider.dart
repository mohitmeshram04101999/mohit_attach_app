
import 'dart:async';
import 'package:attach/modles/home_data_responce_model.dart';
import 'package:attach/providers/my_hleper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class StoryProvider with ChangeNotifier
{


  //this is for my user
  final bool _activeTimer = (kDebugMode)?true:false;
  //

  List<StoryModel> _story = [];
  final int _userPosition= 0;
  Timer?_timer;
  int _totalUserStory =0;
   int _curruntUserIndex = 0;
   int _currunStory = 0;
   int _currntUserStoryLength =0;
   PageController _userController = PageController();
   PageController _storyController = PageController();
   final TextEditingController _commentController = TextEditingController();
   Duration _timerDuration =  Duration(seconds: 10);

  List<StoryModel> get story =>_story;
  PageController get userPageController =>_userController;
  PageController get storyPageController =>_storyController;
  int get  curruntStory =>_currunStory;
  int get curruntUserIndex =>_curruntUserIndex;
  TextEditingController get commentController =>_commentController;
  Duration get timerDuration =>_timerDuration;

  setStory(List<StoryModel> data)
  {
    _story = data;
    _totalUserStory = _story.length;
    notifyListeners();
  }








  Story? getCurruntStory()
  {
    return _story[_curruntUserIndex].stories?[_currunStory];
  }

  logout()
  {
    clear();
    _story = [];
  }

  clear()
  {
    _timer?.cancel();
    _curruntUserIndex = 0;
    _currunStory = 0;
    _commentController.clear();
  }


  setUser(BuildContext context,{
    required int curruntUserIndex,
})
  {
    print("this is set user");

    _userController.dispose();
    _storyController.dispose();

    _userController = PageController(initialPage: curruntUserIndex);
    _curruntUserIndex = curruntUserIndex;
    _storyController = PageController();
    _currntUserStoryLength =  _story[curruntUserIndex].stories?.length??0;
    _currunStory = 0;
    if(_activeTimer)
      {
        _timer = Timer(Duration(seconds: 10), (){
          changePage(context);
        });
      }
    print("this is set user");
  }

  resetTime(BuildContext context,{Duration? duration})
  {
    _timer?.cancel();
   if(_activeTimer)
     {
       _timer = Timer(duration??Duration(seconds: 10), (){
         changePage(context);
       });
     }
    _commentController.clear();
  }

  
  setPage(int i)
  {
     _userController.jumpTo(i.toDouble());
  }

  updateCurruntUser(BuildContext context,int i)
  {
    _curruntUserIndex = i;
    _currntUserStoryLength  = _story[_curruntUserIndex].stories!.length;
    _storyController.jumpTo(0);
    _currunStory = 0;
    resetTime(context);
  }


  updateCurruntStoryIndex(BuildContext context,int i)
  {
    _currunStory = i;
    print("this is currunt story $_currunStory");
    resetTime(context);
  }


  previousPage()
  {
    if(curruntStory>0)
      {
        _storyController.previousPage(duration:Duration(milliseconds: 300), curve: Curves.linear);
      }
    else if(curruntStory==0&&_curruntUserIndex>0)
      {
        _userController.previousPage(duration:Duration(milliseconds: 300), curve: Curves.linear);
      }

  }



  changePage(BuildContext context)
  {

    print(_currunStory<_currntUserStoryLength-1);

    if(_currunStory<_currntUserStoryLength-1)
      {
        _storyController.nextPage(duration:Duration(milliseconds: 300), curve: Curves.linear);
      }
    else if(_curruntUserIndex<_totalUserStory-1)
      {
        _userController.nextPage(duration:Duration(milliseconds: 300), curve: Curves.linear);
      }
    else
      {
        Navigator.pop(context);
      }

    print("currunt User  = $_curruntUserIndex\n total user = $_totalUserStory \n currntSoty = $_currunStory \n total Story of user = ${_currntUserStoryLength}");

  }


  update()=>notifyListeners();



  // createComment(BuildContext context) async
  // {
  //   if(_commentController.text.trim().isNotEmpty)
  //     {
  //       var resp =  await StoryApi().replyStory(
  //           storyId: getCurruntStory()?.id??'',
  //           listenerId: _story[_curruntUserIndex].listener?.id??'',
  //           message: _commentController.text.trim(),
  //       );
  //
  //
  //
  //       switch(resp.statusCode)
  //       {
  //         case 200:
  //           var d = jsonDecode(resp.body);
  //           MyHelper.snakeBar(context, title: "Story Update", message: "Reply has Sent",type: SnakeBarType.success);
  //           _commentController.clear();
  //           notifyListeners();
  //
  //           break;
  //
  //         case 400:
  //           MyHelper.snakeBar(context,title: 'Can Not Add Comment',message: '${jsonDecode(resp.body)['message']}',type: SnakeBarType.error);
  //           break;
  //
  //         case 403:
  //           MyHelper.snakeBar(context,title: 'Ristrict',message: '${jsonDecode(resp.body)['message']}',type: SnakeBarType.error);
  //           break;
  //
  //
  //         case 409:
  //           MyHelper.snakeBar(context,title: 'Bank Can not Add  ',message: '${jsonDecode(resp.body)['message']}',type: SnakeBarType.error);
  //           break;
  //
  //         case 401:
  //           MyHelper.tokenExp(context);
  //           break;
  //
  //         case 500:
  //           MyHelper.serverError(context, resp.body);
  //           break;
  //
  //         default:
  //           MyHelper.serverError(context, '${resp.statusCode}\n${resp.body}',title: 'Exception');
  //           break;
  //
  //
  //       }
  //     }
  // }




}