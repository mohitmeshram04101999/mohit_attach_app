
import 'dart:convert';

import 'package:attach/modles/custom_calls_info.dart';
import 'package:attach/modles/otp_responce.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DB
{


  static User? curruntUser;


  Future<bool> isFirstTimer() async
  {
    var db = await SharedPreferences.getInstance();
    String? d = db.getString("install");
    if(d==null)
      {
        db.setString("install", "value");
        return true;
      }
    else
      {
        return false;
      }

  }


  // Future<void> saveBusiness(BusinessModel business) async
  // {
  //   var db = await SharedPreferences.getInstance();
  //   db.setString('business', jsonEncode(business.toJson()));
  // }
  //
  //
  // Future<BusinessModel?> getBusiness() async
  // {
  //   var db = await SharedPreferences.getInstance();
  //
  //   String? d =  db.getString('business');
  //   if(d==null)
  //   {
  //     return null;
  //   }
  //   else
  //   {
  //     BusinessModel user = BusinessModel.fromJson(jsonDecode(d));
  //     return user;
  //   }
  // }
  //
  Future<void> saveUser(User user) async
  {
    var db = await SharedPreferences.getInstance();
    curruntUser = user;
    db.setString('user', jsonEncode(user.toJson()));

  }


  //
  Future<Map<String,String>> getRowHeader()async
  {
    var db = await SharedPreferences.getInstance();

    String? d =  db.getString('user');
    if(d==null)
    {
      return {};
    }
    else
    {
      User user = User.fromJson(jsonDecode(d));
      return {
        "Content-Type": "application/json",
        'Authorization':'Bearer ${user.token}'
      };
    }
  }


  Future<Map<String,String>> getFormHeader()async
  {
    var db = await SharedPreferences.getInstance();

    String? d =  db.getString('user');
    if(d==null)
    {
      return {};
    }
    else
    {
      User user = User.fromJson(jsonDecode(d));
      return {
        'Authorization':'${user.token??''}'
      };
    }

  }

  Future<User?> getUser() async
  {
    var db = await SharedPreferences.getInstance();

    String? d =  db.getString('user');
    if(d==null)
    {
      return null;
    }
    else
    {
      User user = User.fromJson(jsonDecode(d));
      curruntUser = user;
      return user;
    }
  }

  Future<void> clear() async
  {
    var db = await SharedPreferences.getInstance();
    await db.clear();
    db.setString("install", "value");

  }



  saveCallEvent(MyCallEvent event)
  {
    var db =  SharedPreferences.getInstance();
    db.then((value) => value.setString('callEvent', jsonEncode(event.toJson())));
  }


  Future<MyCallEvent?> getCallEvent()async
  {
    var db =  await SharedPreferences.getInstance();
    String? d =  db.getString('callEvent');
    if(d==null)
    {
      return null;
    }
    else
    {
      db.remove('callEvent');
      MyCallEvent callEvent = MyCallEvent.fromJson(jsonDecode(d));
      return callEvent;
    }
  }

  deleteCallEvent()
  {
    var db =  SharedPreferences.getInstance();
    db.then((value) => value.remove('callEvent'));
  }



  Future<void> saveSomeDate(Map<String,dynamic> data) async
  {
    var db = await SharedPreferences.getInstance();
    db.setString('data', jsonEncode(data));
  }

  Future<Map<String,dynamic>?> getSomeDate() async
  {
    var db = await SharedPreferences.getInstance();
    String? d =  db.getString('data');
    if(d==null)
    {
      return null;
    }
    else
    {
      db.remove('data');
      return jsonDecode(d);
    }
  }



}