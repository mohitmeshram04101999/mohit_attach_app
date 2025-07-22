

import 'dart:convert';
import 'dart:io';

import 'package:attach/api/apiPath.dart';
import 'package:attach/api/authAPi.dart';
import 'package:attach/api/local_db.dart';
import 'package:attach/providers/my_hleper.dart';
import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;

class ListenerApi
{

  Future<http.Response>followAndUnFollow(String listenerId) async
  {
    var uri = PathApi.baseUri+PathApi.follow;
    print("1");
    var head =  await DB().getRowHeader();
    print("2");
    var d = {
      "userId":DB.curruntUser?.id??'',
      "listenerId":listenerId
    };
    var resp =  await http.post(Uri.parse(uri),headers: head,body: jsonEncode(d));
    print("${resp.body}");

    respPrinter(uri, resp);
    return resp;

  }

  Future<http.Response>createThread(String listenerId) async
  {
    var uri = PathApi.baseUri+PathApi.createThread;
    print("1");
    var head =  await DB().getRowHeader();
    print("2");
    var d = {
      "userId":DB.curruntUser?.id??'',
      "listenerId":listenerId
    };
    var resp =  await http.post(Uri.parse(uri),headers: head,body: jsonEncode(d));
    print("3");

    respPrinter(uri, resp);
    return resp;

  }


  Future<http.Response>becomeListener(List form) async
  {
    var uri = PathApi.baseUri+PathApi.becomeListener;

    var head =  await DB().getRowHeader();

    var d = {
      "userId":DB.curruntUser?.id??'',
      'form':form
    };


    var resp =  await http.post(Uri.parse(uri),headers: head,body: jsonEncode(d));

    respPrinter(uri, resp);
    return resp;

  }

  Future<http.Response>updateNotificationBellForListener(String listenerId) async
  {
    var uri = PathApi.baseUri+PathApi.updateBell;
    var head =  await DB().getRowHeader();

    var d = {
      "userId":DB.curruntUser?.id??'',
      "listenerId":listenerId
    };

    var resp =  await http.post(Uri.parse(uri),body: jsonEncode(d)  ,headers: head);
    respPrinter(uri, resp);
    return resp;
  }



  static Future<void> sendContactRequest(BuildContext context,String listenerId,
      String message,
      {required Function(http.Response response) onSuccess}) async
  {
    var uri = PathApi.baseUri+PathApi.sendContactRequest;
    var head =  await DB().getRowHeader();

    var d = {
      "userId":DB.curruntUser?.id??'',
      "listenerId":listenerId ,
      "message":message,
    };


    final response = await http.post(Uri.parse(uri),body: jsonEncode(d),headers: head);


    respPrinter(uri, response);

    switch(response.statusCode)
    {
      case 201:
        print('this is 201');
        onSuccess(response);
        break;

      case 400:
        MyHelper.snakeBar(context,title: 'Can,t send Message',message: '${jsonDecode(response.body)['message']}',type: SnakeBarType.error);
        break;

      case 403:
        MyHelper.snakeBar(context,title: 'Forbidden',message: 'You are not allowed to access this feature',type: SnakeBarType.error);
        break;

      case 401:
        MyHelper.tokenExp(context);
        break;

      case 500:
        MyHelper.serverError(context, response.body);
        break;

      default:
        MyHelper.serverError(context, '${response.statusCode}\n${response.body}',title: 'Exception');
        break;
    }
  }


}