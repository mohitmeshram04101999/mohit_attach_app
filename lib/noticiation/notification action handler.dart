
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:logger/logger.dart';

@pragma("vm:entry-point")
Future<void> notificationActionHandler(ReceivedAction action)async{
  print("Tap On notification ");

  Logger().i(action.payload);
}