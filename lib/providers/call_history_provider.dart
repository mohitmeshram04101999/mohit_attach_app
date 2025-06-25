import 'dart:convert';

import 'package:attach/api/callsApi.dart';
import 'package:attach/modles/call_history_responce_model.dart';
import 'package:attach/providers/my_hleper.dart';
import 'package:flutter/cupertino.dart';

class CallHistoryProvider extends ChangeNotifier{

  List<CallHistory> _callHistoryData = [];
  int _page = 1;
  int _totalPage = 0;
  bool _isLoading = true;
  bool _isLoadingMore = false;


  bool get isLoading => _isLoading;
  bool get isLoadingMore => _isLoadingMore;


  List<CallHistory> get callHistoryData => _callHistoryData;




  void clear(){
    _page = 1;
    _totalPage = 0;
    _isLoading = true;
    _isLoadingMore = false;
    _callHistoryData.clear();
  }


  getCallHistory(BuildContext context) async{
    var resp = await CallsApi().getCallsHistory(_page);

    switch(resp.statusCode){

      case 200:
        var data = jsonDecode(resp.body);
        CallHisteryApiResponse d = CallHisteryApiResponse.fromJson(data);
        _totalPage = d.totalPages??0;
        if(d.data!=null && d.data!.isNotEmpty)
          {
            if(_page==1)
              {
                _callHistoryData = d.data??[];
              }
            else
              {
                _callHistoryData.addAll(d.data??[]);
              }
          }

        break;

      case 401:
        MyHelper.tokenExp(context);
          break;

          case 403:
        MyHelper.snakeBar(context, title: "Forbidden", message: jsonDecode(resp.body)['message']);
          break;


      case 400:
        MyHelper.snakeBar(context, title: "Bad Request", message: jsonDecode(resp.body)['message']);
          break;


      case 404:
        MyHelper.snakeBar(context, title: "Not Found", message: jsonDecode(resp.body)['message']);
          break;


      case 500:
        MyHelper.serverError(context, resp.body);
          break;

      default:
        {
          MyHelper.serverError(context, resp.body);
        }
        break;
    }

    _isLoading = false;
    _isLoadingMore = false;
    notifyListeners();
  }

  resetPage(BuildContext context)async{
    _page = 1;
    await getCallHistory(context);
  }

  loadMore(BuildContext context)async{
    if(_page<_totalPage)
      {
        _isLoadingMore = true;
        _page++;
        await getCallHistory(context);
      }
  }

}