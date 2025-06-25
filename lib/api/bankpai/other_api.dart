import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:attach/api/apiPath.dart';
import 'package:attach/api/authAPi.dart';
import 'package:attach/api/local_db.dart';
import 'package:attach/modles/compiny_responce_model.dart';
import 'package:attach/providers/my_hleper.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';



class OtherApi

{


  Future<CompanyResponce?> getCompany() async
  {
    try{

      String uri = PathApi.baseUri+PathApi.company;
      var head =await DB().getFormHeader();
      var resp  = await http.get(Uri.parse(uri),headers: head);
      respPrinter(uri, resp);

      if(resp.statusCode==200)
        {
          var d = jsonDecode(resp.body);
          var daata = CompanyResponce.fromJson(d);
          return daata;
        }



    }
    catch(e)
    {
      Logger().e("Error From GetCompany\n$e");
    }
    return null;
  }


  Future<void> contactUs(
      BuildContext context, {
        required String name,
        required String email,
        required String phone,
        required String message,
        required void Function() onDone
      }) async {
    try {

      var head = await DB().getRowHeader();

      final response = await http.post(
        Uri.parse(PathApi.baseUri+PathApi.contactus),
        headers: head,
        body: jsonEncode({
          "name":name,
          "email":email,
          "phoneNumber":phone,
          "message":message
        }),
      );

      switch(response.statusCode)
      {

        case 201:
          var d = jsonDecode(response.body);
          onDone();

          break;

        case 400:
          MyHelper.snakeBar(context,title: 'Bad Request',message: '${jsonDecode(response.body)['message']}',type: SnakeBarType.error);
          break;

        case 403:
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
    } catch (e) {
      print("Error: $e");
    }
  }



  Future<http.Response>  createKyc(
      BuildContext context,
      {
    required String aadharFrontImage,
    required String aadharBackImage,
    required String aadharDOB,
    required String aadharNumber,
    required String aadharName,
        required void Function(double) onProgressFront,
        required void Function(double) onProgressBack,

}) async
  {


  String uri = PathApi.baseUri+PathApi.createKyc;

  var head = await DB().getFormHeader();

  var file = File(aadharFrontImage);
  final length = await file.length();
  int bytesSent = 0;


  final stream = http.ByteStream(file.openRead().transform(
    StreamTransformer.fromHandlers(
      handleData: (data, sink) {
        bytesSent += data.length;
        onProgressBack(bytesSent / length);
        sink.add(data);
      },
    ),
  ));


  var file2 = File(aadharBackImage);
  final length2 = await file.length();
  int bytesSent2 = 0;

  final stream2 = http.ByteStream(file.openRead().transform(
    StreamTransformer.fromHandlers(
      handleData: (data, sink) {
        bytesSent2 += data.length;
        onProgressBack(bytesSent2 / length2);
        sink.add(data);
      },
    ),
  ));

  var req = http.MultipartRequest("POST",Uri.parse(uri));

  req.headers.addAll(head);
  req.fields.addAll({
    'listenerId':DB.curruntUser?.id??'',
    "aadharDOB":aadharDOB,
    "aadharNumber":aadharNumber,
    "aadharName":aadharName
  });

  final multipartFile = http.MultipartFile(
  'aadharFrontImage',
  stream,
  length,
  filename: file.path.split("/").last,
  );

  final multipartFile2 = http.MultipartFile(
    'aadharBackImage',
    stream2,
    length2,
    filename: file2.path.split("/").last,
  );



  req.files.add(await multipartFile);
  req.files.add(await multipartFile2);

  var sResp = await req.send();

  var resp = http.Response(await sResp.stream.bytesToString(),sResp.statusCode);
  respPrinter(uri, resp);

  return resp;
}




  Future<http.Response> getNotification({int page=1}) async
  {
    String uri = PathApi.getNotification(DB.curruntUser!.id??'', page);

    var head = await DB().getFormHeader();

    var resp =  await http.get(Uri.parse(uri),headers: head,);


    respPrinter(uri, resp);

    return resp;

  }




  Future<http.Response> endSession(String sessionId) async
  {
    String uri = PathApi.baseUri+PathApi.endSession;

    var head = await DB().getRowHeader();

    var resp =  await http.put(Uri.parse(uri),headers: head,body: jsonEncode({
      "sessionId":sessionId,
    }));

    respPrinter(uri, resp);

    return resp;

  }


  Future<http.Response> rattingListener(
  {
    required String listenerId,
    required int rating,
    String? message
}
      ) async
  {
    String uri = PathApi.baseUri+PathApi.createRating;

    var head = await DB().getRowHeader();

    var resp =  await http.post(Uri.parse(uri),headers: head,body: jsonEncode({
      "userId":DB.curruntUser?.id??'',
      "listenerId":listenerId,
      "rating":rating,
      "message":message
    }));

    respPrinter(uri, resp);

    return resp;

  }








}