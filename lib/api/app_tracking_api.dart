
import 'dart:convert';

import 'package:attach/api/apiPath.dart';
import 'package:attach/api/authAPi.dart';
import 'package:attach/api/local_db.dart';
import 'package:http/http.dart' as http;

class TrackingApi{


  startAppTime() async
  {
    String uri = '${PathApi.baseUri}/createAppTime';

    var head = await DB().getRowHeader();

    var d = {
      "userId":DB.curruntUser?.id,
      'startTime':DateTime.now().toIso8601String()
    };

    var resp = await http.post(Uri.parse(uri),body: jsonEncode(d)  ,headers: head);

    respPrinter(uri, resp);
    return resp;
  }

  stopAppTime(String appTimeId) async
  {
    String uri = '${PathApi.baseUri}/updateAppTime';

    var head = await DB().getRowHeader();

    var d = {
      "appTimeId":appTimeId,
      "endTime":DateTime.now().toIso8601String() // "2025-07-19T09:00:00.000Z"
    };

    var resp = await http.put(Uri.parse(uri),body: jsonEncode(d)  ,headers: head);
    respPrinter(uri, resp);
    return resp;
  }



}