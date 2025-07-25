import 'dart:convert';

import 'package:attach/api/apiPath.dart';
import 'package:attach/api/local_db.dart';
import 'package:attach/myfile/animated%20dilog.dart';
import 'package:attach/noticiation/notificationService.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';


bool userLogger = true;

respPrinter(String uri,http.Response resp)
{
  if(userLogger)
    {
      if(resp.statusCode==200||resp.statusCode==201)
      {
        Logger().t('$uri\n${resp.statusCode}');
        Logger().t(jsonDecode(resp.body));
      }
      else
      {
        Logger().t('$uri\n${resp.statusCode}\n${resp.body}');
      }
    }
  else
  {
    print(uri);
    print(resp.body);
  }
}

class AuthApi{


  //
  Future<http.Response> logIn(String mobileNumber) async
  {

    String uri = '${PathApi.baseUri}${PathApi.logIn}';
    var resp = await http.post(Uri.parse(uri),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        'phoneNumber': mobileNumber,
      }),
    );
    respPrinter(uri,resp);
    return resp;
  }


  //
  Future<http.Response> verifyOtp(String mobileNumber,String otp,{String? fcmToken}) async
  {

    String uri = '${PathApi.baseUri}${PathApi.verify}';
    var resp = await http.post(Uri.parse(uri),
      body: jsonEncode({
        "phoneNumber":mobileNumber,
        "otp":otp,
        'fcmToken':fcmToken,
      }),
      headers: {
        "Content-Type": "application/json",
      }
    );
    respPrinter(uri,resp);
    return resp;
  }


  Future<http.Response> goOnlineOfOffline() async
  {

    String uri = '${PathApi.baseUri}${PathApi.goOnlineOrOffline}';



    var resp = await http.put(Uri.parse(uri),
        body: jsonEncode({
          "userId":DB.curruntUser?.id,
        }),
        headers: await DB().getRowHeader(),
    );

    respPrinter(uri,resp);
    return resp;
  }

  Future<http.Response> setAudioVideoOff({
    required bool video,
}) async
  {

    String uri = '${PathApi.baseUri}${PathApi.setViodeoAndAudioOff}';

    var resp = await http.put(Uri.parse(uri),
      body: jsonEncode({
        "listenerId":DB.curruntUser?.id,
        "audioCall":true,
        "videoCall":video,
      }),
      headers: await DB().getRowHeader(),
    );
    respPrinter(uri,resp);
    return resp;
  }



  Future<http.Response> createProfile({
    required  String mobileNumber,
    required  String fullName,
    required  String mail,
    required  String gender,
    required String age,
    required List<String> language,
}) async
  {


    String? fcmToken = await NotificationService().getToken();

    var data = {
      "phoneNumber":mobileNumber,
      "name":fullName,
      "email":mail,
      "gender":gender,
      'languages':language,
      'fcmToken':fcmToken,
    };
    Logger().t(data);

    String uri = '${PathApi.baseUri}${PathApi.createProfile}';
    var resp = await http.post(Uri.parse(uri),
        body: jsonEncode(data),
        headers: {
          "Content-Type": "application/json",
        }
    );
    respPrinter(uri,resp);
    return resp;
  }




  Future<http.Response> getAllLanguage() async
  {

    String uri = '${PathApi.baseUri}${PathApi.language}';
    var resp = await http.get(Uri.parse(uri),);
    respPrinter(uri,resp);
    return resp;
  }


  Future<http.Response> getUser({String? userId}) async
  {

    String uri = PathApi.getUser(DB.curruntUser?.id??'',listenerId: userId);
    var head = await DB().getFormHeader();
    var resp = await http.get(Uri.parse(uri),headers: head);
    respPrinter(uri, resp);
    return resp ;
  }

  Future<http.Response> updateUser(String userId,{
    String? profileImage,
    String? name,
    String? bio,
    String? gender,
    String? email,
    String? avtarUrl,
    List<String>? languages
  }) async
  {


    var d = {
      "name":name,
      "bio":bio,
      "gender":gender,
      "email":email
    };


    if(profileImage==null&&avtarUrl!=null)
      {
        d['imageURL'] = avtarUrl;
      }




    Logger().t(d);
    Logger().t(languages);

    Map<String,String> fd = {};
    d.forEach((key, value) {
      if(value!=null)
        {
          fd[key]=value.toString();
        }
    },);

    String uri = '${PathApi.baseUri}${PathApi.updateUser(userId)}';
    var req = http.MultipartRequest('PUT',Uri.parse(uri));
    var head = await DB().getFormHeader();


    req.headers.addAll(head);
    
    if(profileImage!=null&&avtarUrl==null)
      {
        req.files.add(await http.MultipartFile.fromPath("image", profileImage));
      }

    if(languages!=null)
      {
        for(int i=0;i<languages.length;i++)
          {
            fd['languages[$i]'] = languages[i];
          }
      }

    req.fields.addAll(fd);
    

    var resp = await req.send();

    var nr = http.Response( '', resp.statusCode);
    // respPrinter(uri, nr);
    return  nr;
  }

  logOut({required String userId}) async
  {
    String uri = PathApi.logOut(userId);
    var resp = await http.post(Uri.parse(uri),headers: await DB().getRowHeader());
    respPrinter(uri,resp);
    return resp;
  }


  getAvtar() async
  {
    String uri = '${PathApi.baseUri}getAllAvtar';
    var head = await DB().getFormHeader();
    var resp = await http.get(Uri.parse(uri),headers: head);
    respPrinter(uri,resp);
    return resp;
  }

}