

import 'package:attach/api/app_tracking_api.dart';
import 'package:attach/noticiation/notificationService.dart';

import 'package:flutter/cupertino.dart';

import 'package:logger/logger.dart';

class AppLifeCycleProvider with ChangeNotifier,WidgetsBindingObserver {

  var track =  TrackingApi();
  String? _appTimeId;


  init()async{
    WidgetsBinding.instance.addObserver(this);
  }


  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }


  @override
  void didChangeAppLifecycleState(AppLifecycleState state)async{
    print('Lifecycle state changed to: $state');

    switch (state) {
      case AppLifecycleState.resumed:
      // App came to foreground
        Logger().i('Lifecycle state changed to: $state');
        notifyListeners();
        break;
      case AppLifecycleState.inactive:
        Logger().i('Lifecycle state changed to: $state');
        notifyListeners();
        break;

      case AppLifecycleState.paused:

        Logger().i('Lifecycle state changed to: $state');
        notifyListeners();
        break;
      case AppLifecycleState.detached:
        Logger().i('Lifecycle state changed to: $state');
        Logger().i('Lifecycle state changed to: ${navigatorKey.currentContext}');


        if (navigatorKey.currentContext != null) {

          Logger().i('Stop app time called successfully');
        } else {
          Logger().e('Context is null in detached');
        }
        notifyListeners();
        break;

        case AppLifecycleState.hidden:
        Logger().i('Lifecycle state changed to: $state');
        notifyListeners();
        break;
    }
  }







}