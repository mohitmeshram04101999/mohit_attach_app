import 'dart:convert';


import 'package:attach/api/apiPath.dart';
import 'package:attach/api/authAPi.dart';
import 'package:attach/api/local_db.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
class CallsApi
{


  Future<http.Response>createCall({
    required String listenerId,
    required String threadId,
    required String callType,
}) async
  {

    String uri = '${PathApi.baseUri}${PathApi.createCallHistory}';

    var d = {
      "callRequestById":DB.curruntUser?.id??'',
      "callToUserId":listenerId,
      "threadId":threadId,
      "callType":callType,  // "AUDIO", "VIDEO"
      "callDirection":"OUTGOING", // "INCOMING", "OUTGOING",
      "recordingUrl":""
    };

    Logger().t("$d");

    var head = await DB().getRowHeader();
    var resp = await http.post(Uri.parse(uri),headers: head,body: jsonEncode(d));
     respPrinter(uri, resp);
     return resp;

  }



  Future<http.Response>updateCall({
    required String callId,
    required String status,
    String? callEndedById,
  }) async
  {

    print("update dating call pickUop");

    String uri = '${PathApi.baseUri}${PathApi.updateCallHistory}';

    var d =  {
      "callId":callId,
      "status":status, // "MISSED", "REJECTED", "ANSWERED", "BUSY","COMPLETE"
      "answered":status=="ANSWERED",  // true or false
      "endTime":DateTime.now().toIso8601String(),
      "recordingUrl":"",
      'callEndedById':callEndedById
    };

    var fd = {};

    print("data i set no filter tile");

    d.forEach((key, value) {
      if(value!=null)
        {
          fd[key]=value;
        }
    },);

    print("data is filter");
    Logger().t("$d \n$fd");

    var head = await DB().getRowHeader();
    print("header get ");
    var resp = await http.put(Uri.parse(uri),headers: head,body: jsonEncode(fd));
    print("respons get kar liya h ");
    respPrinter(uri, resp);
    return resp;

  }


  getCallsHistory(int page) async
  {
    String uri = PathApi.getCallHistory(DB.curruntUser?.id??'',"$page");
    var resp = await http.get(Uri.parse(uri),headers: await DB().getFormHeader());
    respPrinter(uri, resp);
    return resp;
  }

}