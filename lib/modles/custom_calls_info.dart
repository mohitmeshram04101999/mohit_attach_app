import 'package:attach/modles/otp_responce.dart';

class MyCallEvent
{
  String? eventName;
  String? threadId;
  User? user;
  String? callId;

  MyCallEvent({
    this.eventName,
    this.callId,
    this.user,
    this.threadId,
  });


  factory MyCallEvent.fromJson(Map<String, dynamic> json) {
    return MyCallEvent(
      eventName: json['eventName'],
      callId: json['callId'],
      user: User.fromJson(json['user']),
      threadId: json['threadId'],
    );
  }



  toJson()
  {
    return {
      'eventName':eventName,
      'callId':callId,
      'user':user?.toJson(),
      'threadId':threadId
    };
  }
}






class CustomCallEventName
{
  static String videoCallPicked = 'videoCallPicked';
  static String audioCallPicked = 'audioCallPicked';

}
