
import 'dart:convert';

import 'package:attach/api/authAPi.dart';
import 'package:attach/api/listners_Api.dart';
import 'package:attach/modles/otp_responce.dart';
import 'package:attach/providers/my_hleper.dart';
import 'package:flutter/cupertino.dart';

class ListenerProfileDetailProvider with ChangeNotifier
{

  bool _loadin = true;
  User? _detail;


  bool get loading => _loadin;
  User? get detail=>_detail;



  clear()
  {
    _loadin = true;
    _detail = null;
  }

  getDetail(BuildContext context,String userId) async
  {

    _loadin = true;
    var resp = await AuthApi().getUser(userId: userId);
    switch(resp.statusCode)
    {

      case 200:
        var d = jsonDecode(resp.body);
        var _d = User.fromJson(d['data']);
        _detail = _d;
        break;

      case 400:
        MyHelper.snakeBar(context,title: 'Bad Request',message: '${jsonDecode(resp.body)['message']}',type: SnakeBarType.error);
        break;

      case 403:
        MyHelper.snakeBar(context,title: 'Denied',message: '${jsonDecode(resp.body)['message']}',type: SnakeBarType.error);
        break;

      case 401:
        MyHelper.tokenExp(context);
        break;

      case 500:
        MyHelper.serverError(context, resp.body);
        break;

      default:
        MyHelper.serverError(context, '${resp.statusCode}\n${resp.body}',title: 'Exception');
        break;


    }
    _loadin  =  false;
    notifyListeners();

  }

  followUser(BuildContext context) async
  {

    var resp = await ListenerApi().followAndUnFollow(_detail?.id??'');
    switch(resp.statusCode) {
      case 200:
        var d = jsonDecode(resp.body);
        var _d = User.fromJson(d['data']);
        _detail = _d;
        notifyListeners();
        break;

      case 400:
        MyHelper.snakeBar(context,title: 'Bad Request',message: '${jsonDecode(resp.body)['message']}',type: SnakeBarType.error);
        break;

      case 403: MyHelper.snakeBar(context,title: 'Denied',message: '${jsonDecode(resp.body)['message']}',type: SnakeBarType.error);
        break;

      case 401:
        MyHelper.tokenExp(context);
        break;

      case 500:
        MyHelper.serverError(context, resp.body);
        break;

      default:
        MyHelper.serverError(context, '${resp.statusCode}\n${resp.body}',title: 'Exception');
        break;
    }
  }



  updateBell(BuildContext context) async
  {
    var resp = await ListenerApi().updateNotificationBellForListener(_detail?.id??'');
    switch(resp.statusCode) {
      case 201:
        var d = jsonDecode(resp.body);
        bool _d = d['data']['bellOn'];

        var _userMap = _detail!.toJson();
        _userMap['isBellOn'] = _d;
        _detail = User.fromJson(_userMap);
        notifyListeners();
        break;

      case 400:
        MyHelper.snakeBar(context,title: 'Bad Request',message: '${jsonDecode(resp.body)['message']}',type: SnakeBarType.error);
        break;

      case 403: MyHelper.snakeBar(context,title: 'Denied',message: '${jsonDecode(resp.body)['message']}',type: SnakeBarType.error);
        break;

      case 401:
        MyHelper.tokenExp(context);
        break;

      case 500:
        MyHelper.serverError(context, resp.body);
        break;

      default:
        MyHelper.serverError(context, '${resp.statusCode}\n${resp.body}',title: 'Exception');
        break;
    }
  }

}