
import 'dart:convert';

import 'package:attach/api/authAPi.dart';
import 'package:attach/modles/log_in_responce.dart';
import 'package:attach/modles/otp_responce.dart';
import 'package:attach/myfile/myast%20dart%20file.dart';
import 'package:attach/noticiation/notificationService.dart';
import 'package:attach/providers/my_hleper.dart';
import 'package:attach/providers/profileProvider.dart';
import 'package:attach/screens/dash_board_screen/dash_board_screen.dart';
import 'package:attach/screens/on_bord_screen/login/complit_profile.dart';

import 'package:attach/screens/on_bord_screen/login/otpScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class AuthProvider with ChangeNotifier{


  final TextEditingController _phone = TextEditingController();
  final TextEditingController _otp = TextEditingController();



  TextEditingController get phoneNumberController =>_phone;
  TextEditingController get otpController =>_otp;


  clear()
  {
    _phone.clear();
    _otp.clear();
  }

  logIn(BuildContext context) async
  {
    Logger().e(_phone.text);
    var resp = await AuthApi().logIn(_phone.text.trim());

    switch(resp.statusCode)
        {

      case 200:
        var d = jsonDecode(resp.body);

        LogInResponceModel logInResponce = LogInResponceModel.fromJson(d);

        MyHelper.snakeBar(context,title: 'OTP',message: '${logInResponce.otp??''}',type: SnakeBarType.success);
        RoutTo(context, child: (p0, p1) => OtpScreen());

        break;

      case 400:
        MyHelper.snakeBar(context,title: 'Bad Request',message: '${jsonDecode(resp.body)['message']}',type: SnakeBarType.error);
        break;

      case 403:
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


  resendOtp(BuildContext context) async
  {
    Logger().e(_phone.text);
    var resp = await AuthApi().logIn(_phone.text.trim());

    switch(resp.statusCode)
    {

      case 200:
        var d = jsonDecode(resp.body);

        LogInResponceModel logInResponce = LogInResponceModel.fromJson(d);

        MyHelper.snakeBar(context,title: 'OTP',message: '${logInResponce.otp??''}',type: SnakeBarType.success);

        break;

      case 400:
        MyHelper.snakeBar(context,title: 'Bad Request',message: '${jsonDecode(resp.body)['message']}',type: SnakeBarType.error);
        break;

      case 403:
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

  verifyOtp(BuildContext context) async
  {

    print("object");
    Logger().e('${_phone.text}\n${_otp.text}');

    if(_otp.length<4)
      {
        MyHelper.snakeBar(context,title: 'Incorrect Otp',message: 'Enter 4 Digit Otp ');
        return;
      }


    print("this is verify otp strt getting token");
    var _t = await NotificationService().getToken();

    print("toke get deon this is token $_t");

    var resp = await AuthApi().verifyOtp(_phone.text.trim(),_otp.text.trim(),fcmToken: _t);

    switch(resp.statusCode)
    {

      case 200:
        var d = jsonDecode(resp.body);
        VerifyOtpResponceModel logInResponce = VerifyOtpResponceModel.fromJson(d);

        if(logInResponce.profileComplete==true)
          {
            Provider.of<ProfileProvider>(context,listen: false).setAndSaveUser(logInResponce.data!);
            ReplaceAll(context, child: (p0, p1) => DashBoardScreen(),);
            clear();
          }
        else
          {
            ReplaceTo(context, child: (p0, p1) => CompleteProfileScreen(),);
          }
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
    _otp.clear();

  }


}