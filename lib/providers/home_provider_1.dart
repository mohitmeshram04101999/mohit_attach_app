import 'dart:convert';


import 'package:attach/api/listners_Api.dart';
import 'package:attach/api/local_db.dart';
import 'package:attach/api/storyApi.dart';
import 'package:attach/dialog/contect_request_dialog.dart';
import 'package:attach/modles/home_data_responce_model.dart';
import 'package:attach/modles/otp_responce.dart';
import 'package:attach/modles/usertype.dart';
import 'package:attach/myfile/animated%20dilog.dart';

import 'package:attach/noticiation/notificationService.dart';
import 'package:attach/providers/my_hleper.dart';
import 'package:attach/providers/story_provider.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as Io;

class HomeProvider with ChangeNotifier {
  Io.Socket? _socket;

  HomePageData? _homePageData;

  HomePageData? get data => _homePageData;

  setSocket(Io.Socket s) {
    print("socket is connecting in home provider");
    _socket = s;
    _setRegisterEvent();
  }

  _setRegisterEvent() {
    print("regidtor evernt Connect ");
    final payload = {'userId': '${DB.curruntUser?.id}'};
    _socket?.emit("register", payload);
    // if (DB.curruntUser?.userType == UserType.user) {
    //   _socket?.on('initialData', _register);
    // }
    _socket?.on('initialData', _register);
  }

  _register(dynamic data) {
    print("this is init data");




    Logger().i(data);
    var d = HomePageData.fromJson(data);

    var storyProvider = Provider.of<StoryProvider>(navigatorKey.currentContext!,listen: false);


    _homePageData = d;

    storyProvider.setStory(d.stories??[]);
    print("date set");
    notifyListeners();
  }

  follow(BuildContext context, HomeListener l) async {
    var resp = await ListenerApi().followAndUnFollow(l.id ?? '');

    switch (resp.statusCode) {
      case 200:
        var d = jsonDecode(resp.body);

        break;

      case 400:
        MyHelper.snakeBar(
          context,
          title: 'Verify Otp',
          message: '${jsonDecode(resp.body)['message']}',
          type: SnakeBarType.error,
        );
        break;

      case 403:
        MyHelper.snakeBar(
          context,
          title: 'Verify Otp',
          message: '${jsonDecode(resp.body)['message']}',
          type: SnakeBarType.error,
        );
        break;

      case 401:
        MyHelper.tokenExp(context);
        break;

      case 500:
        MyHelper.serverError(context, resp.body);
        break;

      default:
        MyHelper.serverError(
          context,
          '${resp.statusCode}\n${resp.body}',
          title: 'Exception',
        );
        break;
    }
  }

  void disconnectSocket() {
    // Stop listening to 'message' event
    _socket?.offAny(); // (Optional) Remove all event listeners
    _socket?.disconnect(); // Disconnect the socket
    _socket?.destroy();
    _homePageData = null;
  }

  uploadStory(BuildContext context,FileType type) async {



    FilePickerResult? result;


    if(type ==FileType.image)
      {
        result = await FilePicker.platform.pickFiles(
          allowMultiple: false,
          type: FileType.custom,
          allowedExtensions: ['jpg', 'png', 'jpeg'],
        );

      }
    else if(type == FileType.video)
      {
        result = await FilePicker.platform.pickFiles(
          allowMultiple: false,
          type: FileType.custom,
          allowedExtensions: ['mp4', 'mov', 'avi'],
        );

      }
    else
      {
        return;
      }




   
    if (result != null && result.files.isNotEmpty) {
 
      var resp = await StoryApi().uploadStory(
        filePath: result.files.first.path ?? '',
        video: type ==FileType.video,
        onProgress: (d) async {
          await AwesomeNotifications().createNotification(
            content: NotificationContent(
              id: 1001, // keep same ID to update
              channelKey: 'UPLOAD_FILE',
              title: 'Uploading Story...',
              body: '${(d*100).toString().split(".").first}% uploaded',
              notificationLayout: NotificationLayout.ProgressBar,
              progress: d * 100,
              locked: true,
              autoDismissible: false,
            ),
          );
        },
      );

      AwesomeNotifications().dismiss(1001);

      switch (resp.statusCode) {
        case 201:
          MyHelper.snakeBar(
            context,
            title: "Story",
            message: "Story Uploaded",
            type: SnakeBarType.success,
          );
          break;

        case 400:
          MyHelper.snakeBar(
            context,
            title: 'Verify Otp',
            message: '${jsonDecode(resp.body)['message']}',
            type: SnakeBarType.error,
          );
          break;

        case 403:
          MyHelper.snakeBar(
            context,
            title: 'Verify Otp',
            message: '${jsonDecode(resp.body)['message']}',
            type: SnakeBarType.error,
          );
          break;

        case 401:
          MyHelper.tokenExp(context);
          break;

        case 500:
          MyHelper.serverError(context, resp.body);
          break;

        default:
          MyHelper.serverError(
            context,
            '${resp.statusCode}\n${resp.body}',
            title: 'Exception',
          );
          break;
      }
      AwesomeNotifications().dismiss(1001);
    }
  }




}
