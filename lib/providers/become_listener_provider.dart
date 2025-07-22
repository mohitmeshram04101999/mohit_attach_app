import 'dart:convert';
import 'dart:developer';

import 'package:attach/api/bankpai/other_api.dart';
import 'package:attach/api/listners_Api.dart';
import 'package:attach/modles/otp_responce.dart';
import 'package:attach/modles/question_for_listener_model.dart';
import 'package:attach/myfile/myast%20dart%20file.dart';
import 'package:attach/providers/my_hleper.dart';
import 'package:attach/providers/profileProvider.dart';
import 'package:attach/screens/dash_board_screen/dash_board_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class BecomeListenerProvider extends ChangeNotifier {


  bool _isLoading = true;
  bool get isLoading => _isLoading;
  final List<QuestionForListenerModel> _questionList = [];
  List<QuestionForListenerModel> get questionList => _questionList;
  Map<String, AnswerModel> _answer = {};
  Map<String, AnswerModel> get answer => _answer;

  final PageController _pageController = PageController(initialPage: 0);
  PageController get pageController => _pageController;

  int _page = 1;
  int _totalPage = 0;

  int get totalPage => _totalPage;


  Future<void> getQuestion(BuildContext context) async {
    final resp = await OtherApi().getAllQuestionForListener(page: _page);
    switch (resp.statusCode) {

      case 200:
        final data = jsonDecode(resp.body);
        QuestionForListenerModel questionForListenerResponce =
        QuestionForListenerModel.fromJson(data);
        if(_page==1)
          {
            _questionList.clear();
            _questionList.add(questionForListenerResponce);
          }
        else
          {
            _questionList.add(questionForListenerResponce);
          }

        _totalPage = questionForListenerResponce.page ?? 0;

        break;

      case 400:
        MyHelper.snakeBar(
          context,
          title: 'Error',
          message: '${jsonDecode(resp.body)['message']}',
          type: SnakeBarType.error,
        );
        break;


      case 401:
        MyHelper.tokenExp(context);
        break;

      case 404:
        MyHelper.snakeBar(
          context,
          title: 'Not Found',
          message: '${jsonDecode(resp.body)['message']}',
          type: SnakeBarType.error,
        );
        break;



      case 500:
        MyHelper.serverError(context, resp.body);
        break;



      default:
        MyHelper.serverError(context, resp.body);
    }
    _isLoading = false;
    notifyListeners();
  }

  loadMore(BuildContext context) async
  {
    if(_page<_totalPage)
      {
        _page = _page + 1;
        await getQuestion(context);
      }
  }







  addAnswer(AnswerModel answerModel,{bool isUpdate=false})
  {
    log("Adding answer");
    if(_answer.containsKey(answerModel.id))
      {
        _answer.remove(answerModel.id);
        log("old answer removed");
      }
    _answer[answerModel.id]=answerModel;

    log("answer added  ${answerModel.toJson()}");
    if(isUpdate)
      {
        notifyListeners();
      }
    if(kDebugMode&&isUpdate)
      {
        notifyListeners();
      }

  }

  AnswerModel? _getAnswer(String id)
  {

    return _answer[id];
  }




    bool isRequiredAnswerAdded(BuildContext context,int index) {
    bool isAllRequiredAnswerAdded = true;

    _questionList[index].data?.forEach((element) {

      if(element.required==true)
        {
          AnswerModel? checkAnswer = _getAnswer(element.id??'');

         if( isAllRequiredAnswerAdded == false)
          {
            return ;
          }


          if(checkAnswer==null)
            {
              isAllRequiredAnswerAdded = false;
              MyHelper.snakeBar(context, title: 'Answer This Question', message: '${element.question}', type: SnakeBarType.error);
              return;
            }
          else
            {

            }

        }

    },);

    return isAllRequiredAnswerAdded;

  }



  submitAnswer(BuildContext context) async
  {

    List answerForSend = [];


     //[MEDIA_TYPE, BOOLEAN_OPTION, SORT_QUESTION, LONG_QUESTION, MULTIPLE_CHOOSE_OPTION]

    _answer.forEach((key, value) {
      if(value.questionType=='BOOLEAN_OPTION')
        {
          if(value.booleanAnswer!=null)
            {
              answerForSend.add({
                "questionId": value.id,
                "question": value.question,
                "answer": value.booleanAnswer
              });
            }
        }
      else if(value.questionType=='SORT_QUESTION')
        {
          if(value.sortAnswer!=null)
          {
            answerForSend.add({
              "questionId": value.id,
              "question": value.question,
              "answer": value.sortAnswer
            });
          }
        }
      else if(value.questionType=='LONG_QUESTION')
        {
          if(value.longAnswer!=null)
          {
            answerForSend.add({
              "questionId": value.id,
              "question": value.question,
              "answer": value.longAnswer
            });
          }
        }
      else if(value.questionType=='MULTIPLE_CHOOSE_OPTION')
        {
          if(value.multipleChooseAnswer!=null&&value.multipleChooseAnswer?.isNotEmpty==true)
          {
            answerForSend.add({
              "questionId": value.id,
              "question": value.question,
              "answer": value.multipleChooseAnswer?.join(",")
            });
          }
        }
      else if(value.questionType=='MEDIA_TYPE')
        {
          if(value.mediaAnswer!=null&&value.mediaAnswer?.isNotEmpty==true)
          {
            answerForSend.add({
              "questionId": value.id,
              "question": value.question,
              "answer": value.mediaAnswer,
            });
          }
          if(value.multipleMediaAnswer!=null&&value.multipleMediaAnswer?.isNotEmpty==true)
          {
            answerForSend.add({
              "questionId": value.id,
              "question": value.question,
              "answer": value.multipleMediaAnswer?.join(','),
            });
          }




        }
    },);

    {
      var resp = await ListenerApi().becomeListener(answerForSend);

      switch (resp.statusCode) {
        case 200:
          var d = jsonDecode(resp.body);

          var profileProvider = Provider.of<ProfileProvider>(context,listen: false);

          var user = User.fromJson(d['data']);

          await profileProvider.setAndSaveUser(user);

          MyHelper.snakeBar(
            context,
            title: 'Your form has been submitted',
            message: "Your Profile in under review",
            type: SnakeBarType.success,
          );

          ReplaceAll(context, child: (p0, p1) => DashBoardScreen());
          break;
        case 400:
          MyHelper.snakeBar(
            context,
            title: "Bad Request",
            message: '${jsonDecode(resp.body)['message']}',
          );
          break;
        case 403:
          MyHelper.snakeBar(
            context,
            title: "Restrict Request",
            message: '${jsonDecode(resp.body)['message']}',
          );
          break;
        case 401:
          MyHelper.tokenExp(context);
          break;
        case 500:
          MyHelper.serverError(context, resp.body);
          break;
        default:
          MyHelper.serverError(
            context,
            '${resp.statusCode}\n${resp.body}',
            title: 'Exception',
          );
          break;
      }
    }



    
    
    Logger().i(answerForSend);

  }

  clear() {
    _isLoading = true;
    _page = 1;
    _questionList.clear();
    _answer.clear();

  }
}
