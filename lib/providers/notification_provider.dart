

import 'dart:convert';

import 'package:attach/modles/notification%20model.dart';
import 'package:attach/providers/my_hleper.dart';
import 'package:flutter/cupertino.dart';
import 'package:attach/api/bankpai/other_api.dart';

class NotificationProvider with ChangeNotifier {
  List<NotificationModel> _notifications = [];
  bool _isLoading = true;
  bool _loadMore = false;
  int _page = 1;
  int _total = 0;

  List<NotificationModel> get notifications => _notifications;
  bool get isLoading => _isLoading;
  bool get loadMore => _loadMore;
  int get page => _page;
  int get total => _total;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  set loadMore(bool value) {
    _loadMore = value;
    notifyListeners();
  }

  Future<void> getNotification(BuildContext context,) async {
    final resp = await OtherApi().getNotification(page: _page);

    switch (resp.statusCode) {
      case 200:
        var data = jsonDecode(resp.body);
        NotificationResponce notificationResponce = NotificationResponce.fromJson(data);
        _notifications.addAll(notificationResponce.data??[]);
        break;


      case 400:
        MyHelper.snakeBar(context, title: 'Error', message: '${jsonDecode(resp.body)['message']}', type: SnakeBarType.error);
        break;

      case 500:
        MyHelper.serverError(context, resp.body);
        break;

      case 401:
        MyHelper.tokenExp(context);
        break;

      case 403:
        MyHelper.snakeBar(context, title: 'Error', message: '${jsonDecode(resp.body)['message']}', type: SnakeBarType.error);
        break;

      case 404:
        MyHelper.snakeBar(context, title: 'Not Found', message: '${jsonDecode(resp.body)['message']}', type: SnakeBarType.error);
        break;

        default:
          MyHelper.serverError(context, resp.body);
        break;
    }

    isLoading = false;
    _loadMore = false;
    notifyListeners();
  }

  loadMoreNotification(BuildContext context) async {
    _page += 1;
    _loadMore = true;
    await getNotification(context);
    notifyListeners();
  }

  refreshNotification(BuildContext context) async {
    _page = 1;
    await getNotification(context);
    notifyListeners();
  }




  void clearNotifications() {
    _notifications.clear();
    _loadMore = false;
    _isLoading = true;
  }

}