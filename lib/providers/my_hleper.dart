
import 'dart:convert';

import 'package:attach/const/app_constante.dart';
import 'package:attach/myfile/myast%20dart%20file.dart';
import 'package:attach/myfile/screen_dimension.dart';
import 'package:attach/screens/on_bord_screen/login/log_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:http/http.dart' as http;

class MyHelper
{


  static serverError(BuildContext context,String data,{String? title})
  {

    showDialog(context: context, builder: (context) => AlertDialog(
      backgroundColor: Const.primeColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8)
      ),
      title: Text(title??"Server Error"),
      content: HtmlWidget(data),
    ),);
  }



  static tokenExp(BuildContext context)
  {
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) =>  LogInScreen(),), (route) => false,);
    MyHelper.snakeBar(context,title: 'Log In Session Expire',message: 'Please Log In Again');
  }


  static snakeBar(BuildContext context,{
    SnakeBarType type = SnakeBarType.warning,
    required String title,
    required String message,
    Duration duration = const Duration(seconds: 3),
})
  {

    String iconPath;
    Color color;


    switch(type)
    {
      case SnakeBarType.error:
        iconPath = 'assets/icons/snakeBar/error.png';
        color  = Color.fromRGBO(240, 67, 73, 1);
        break;

      case SnakeBarType.warning:
        iconPath = 'assets/icons/snakeBar/warning.png';
        color = Color.fromRGBO(253, 205, 15, 1);
        break;

      case SnakeBarType.success:
        iconPath = 'assets/icons/snakeBar/success.png';
        color = Color.fromRGBO(1, 225, 123, 1);
        break;

    }



    Get.snackbar(
      'Title',
      'This is the message',
      snackPosition: SnackPosition.TOP,
      // or SnackPosition.TOP
      backgroundColor: Color.fromRGBO(45, 52, 56, 1),

      colorText: Colors.white,
      isDismissible: true,
      titleText: Container(

        padding: EdgeInsets.only(left: 8),
        child: Text(title,style: Const.poppins_400_14(context,size: SC.from_width(16)),),
      ),

      messageText: Container(

        padding: EdgeInsets.only(left: 8),
        child: Text(message,style:Const.poppins_400_14(context,size: SC.from_width(11)) ,),
      ),
      mainButton: TextButton(
        style: ButtonStyle(
          padding:WidgetStateProperty.resolveWith((states) => EdgeInsets.zero,)
        ),
          onPressed: (){
          Get.closeCurrentSnackbar();
          }, child: Icon(Icons.close,color: color,size: 25,)),

      animationDuration: Duration(milliseconds: 500),
      icon: SizedBox(
        width: 32,
        height: 32,
        child: Align(
          alignment: Alignment(2, 2),
          child: Image.asset(
            iconPath,
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
      duration: duration,
    );
  }



   String? handleResponse(BuildContext context,http.Response response) {
    switch(response.statusCode){
      case 201:
        return jsonDecode(response.body)['media'];
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
    return null;
  }



}




enum SnakeBarType{
  error,
  warning,
  success,
}