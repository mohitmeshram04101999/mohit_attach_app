

import 'dart:convert';
import 'dart:developer';

import 'package:attach/api/apiPath.dart';
import 'package:attach/api/authAPi.dart';
import 'package:attach/api/local_db.dart';
import 'package:http/http.dart' as http;

class CallRecordApi
{



  acquire(String channel, int uid)
  async{
    String uri = '${PathApi.baseUri}${PathApi.acquire}';

    var d = {
      "channel":channel,
      "uid":uid
    };

    var resp = await http.post(Uri.parse(uri),headers: await DB().getRowHeader(),body: jsonEncode(d));
    respPrinter(uri, resp);
    return resp;
  }


  startRecord({
    required String channelId,
    required int uid,
    required String resourceId,
    required String token,
})async{
    String uri = '${PathApi.baseUri}${PathApi.startRecord}';

    var head = await DB().getRowHeader();

    var d = {
      "channel":channelId,
      "uid":uid,
      "resourceId":resourceId,
      "token":token
    };

    var resp = await http.post(Uri.parse(uri),headers: head,body: jsonEncode(d));

    log("this is frome start recording");
    respPrinter(uri, resp);

    return resp;
  }

  stopRecord({
    required String resourceId,
    required String sid,  // stop id
    required String channel,
    required int uid,
  })async{

    String uri = '${PathApi.baseUri}${PathApi.stopRecord}';

    var head = await DB().getRowHeader();

    var d = {
      "resourceId":resourceId,
      "sid":sid,  // stop id
      "channel":channel,
      "uid":uid
    };


    var resp = await http.post(Uri.parse(uri),headers: head,body:  jsonEncode(d));

    print("this respnse is frome stop recording");
    respPrinter(uri, resp);

    return resp;
  }


}