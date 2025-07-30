
import 'package:attach/bd/bd_call_event_handler.dart';
import 'package:attach/bd/bg_main.dart';
import 'package:attach/const/app_constante.dart';
import 'package:attach/firebase_options.dart';

import 'package:attach/myfile/screen_dimension.dart';
import 'package:attach/noticiation/notification%20action%20handler.dart';
import 'package:attach/noticiation/notificationService.dart';
import 'package:attach/noticiation/notificationservice/backgoundNotification%20handler.dart';
import 'package:attach/providers/appLifesycalProvider.dart';
import 'package:attach/providers/audio%20call%20provider.dart';

import 'package:attach/providers/auth_provider.dart';
import 'package:attach/providers/bank_account_provider.dart';
import 'package:attach/providers/become_listener_provider.dart';
import 'package:attach/providers/call_history_provider.dart';
import 'package:attach/providers/chatListProvider.dart';
import 'package:attach/providers/chatProvider.dart';
import 'package:attach/providers/home_provider.dart';
import 'package:attach/providers/home_provider_1.dart';
import 'package:attach/providers/language_provider.dart';
import 'package:attach/providers/listener_filer_provider.dart';
import 'package:attach/providers/listner_profile_detail_provider.dart';
import 'package:attach/providers/notification_provider.dart';
import 'package:attach/providers/profileProvider.dart';
import 'package:attach/providers/selfStoryProvider.dart';
import 'package:attach/providers/story_provider.dart';
import 'package:attach/providers/transection_history_provider.dart';
import 'package:attach/providers/videoCallProvider.dart';
import 'package:attach/screens/dash_board_screen/Home/home_screen.dart';


import 'package:attach/screens/splash_screen.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:get/get.dart';

import 'package:provider/provider.dart';
import 'package:no_screenshot/no_screenshot.dart';




Future<void> waitForContext() async {
  while (navigatorKey.currentState == null || !navigatorKey.currentState!.mounted) {
    print("⏳ Waiting for context...");
    await Future.delayed(Duration(milliseconds: 200)); // Wait and recheck
  }
  print("✅ Context is now ready!");
}






offScreenShot() async
{
  final  noScreenshot = NoScreenshot.instance;
  var result =  await noScreenshot.screenshotOff();
  print("this is result $result");

}



void main() async {
  await WidgetsFlutterBinding.ensureInitialized();

  await offScreenShot();

  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
  );


  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);





  const callChannel = MethodChannel('com.attachchat.app/call');



  callChannel.setMethodCallHandler((call) async {
    if (call.method == "showCallScreen") {

      final data = call.arguments;
      print("this is call argumant comming from nativ code $data");


      // await waitForContext();


      // Navigate to your call screen
      navigatorKey.currentState?.push(
        MaterialPageRoute(
          builder: (_) => HomeScreen(), // your custom screen
        ),
      );
    }
  });



  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);



  print("Getting init action ....");
  ReceivedAction? initTaction  = await AwesomeNotifications().getInitialNotificationAction();

  print("d $initTaction");

  //


  await AwesomeNotifications().setListeners(
      onActionReceivedMethod:notificationActionHandler,

    onDismissActionReceivedMethod: (d) async{
      print("onDismissActionReceivedMethod $d");},
  );



  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => AudioCallProvider(),),
      ChangeNotifierProvider(create: (context) => AuthProvider(),),
      ChangeNotifierProvider(create: (context) => ProfileProvider(),),
      ChangeNotifierProvider(create: (context) => LanguageProvider(),),
      ChangeNotifierProvider(create: (context) => Socket_Provider(),),
      ChangeNotifierProvider(create: (context) => BankProvider(),),
      ChangeNotifierProvider(create: (context) => TransectionHistoryProvider(),),
      ChangeNotifierProvider(create: (context) => HomeProvider(),),
      ChangeNotifierProvider(create: (context) => ListenerProfileDetailProvider(),),
      ChangeNotifierProvider(create: (context) => ChatProvider(),),
      ChangeNotifierProvider(create: (context) => ChatListProvider(),),
      ChangeNotifierProvider(create: (context) => VideoCallProvider(),),
      ChangeNotifierProvider(create: (context) => StoryProvider(),),
      ChangeNotifierProvider(create: (context) => ListenerFilterProvider(),),
      ChangeNotifierProvider(create: (context) => SelfStoryProvider(),),
      ChangeNotifierProvider(create: (context) => CallHistoryProvider(),),
      ChangeNotifierProvider(create: (context) => NotificationProvider(),),
      ChangeNotifierProvider(create: (context) => BecomeListenerProvider(),),
      ChangeNotifierProvider(create: (context) => AppLifeCycleProvider(),),
    ],
      child:  MyApp(action: initTaction)));
}

class MyApp extends StatelessWidget {
  final ReceivedAction? action;
  const MyApp({this.action,super.key});


  @override
  Widget build(BuildContext context) {
    SC.getScreen(context);


    return GetMaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',

      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: child!,
        );
      },

      // routes: {
      //   '/incoming_call':(context)=>IncomingCallScreen(
      //   )
      // },




      theme: ThemeData(

        colorScheme: ColorScheme.dark(primary: Const.primeColor,
        onPrimary: Colors.white),









        indicatorColor: Colors.white,

        datePickerTheme: DatePickerThemeData(


          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side:BorderSide(color: Colors.white)
          ),



          
          backgroundColor: Const.primeColor,

          
          // dayForegroundColor: WidgetStateColor.resolveWith((states) => Colors.white,),

          

          cancelButtonStyle: ButtonStyle(
            foregroundColor: WidgetStateColor.resolveWith((states) => Const.yellow),
            textStyle: WidgetStateProperty.resolveWith((states) => Const.font_700_14(context),)
          ),

          confirmButtonStyle: ButtonStyle(
              foregroundColor: WidgetStateColor.resolveWith((states) => Const.yellow),
              textStyle: WidgetStateProperty.resolveWith((states) => Const.font_700_14(context),)
          ),
            
            
            
            todayForegroundColor: WidgetStateColor.resolveWith((states) => Colors.white,),
          todayBorder: WidgetStateBorderSide.resolveWith((states) => BorderSide(width: 6,color: Const.yellow),),
          // todayBackgroundColor: ,
          
          
          // dayBackgroundColor: WidgetStateColor.resolveWith((states) => Colors.red,),
          dayStyle: Const.font_700_14(context),
          dayShape: WidgetStateOutlinedBorder.resolveWith((states) => RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8)
          ),),


          weekdayStyle: Const.font_700_14(context),







        ),


        cardTheme: CardThemeData(
          color: Const.primeColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(9),

          ),

          elevation: 0,

        ),




        progressIndicatorTheme: ProgressIndicatorThemeData(
          color: Colors.white
        ),

        tabBarTheme: TabBarThemeData(
          unselectedLabelColor: Color.fromRGBO(58, 61, 64, 1),
          labelColor: Colors.white,



          indicatorSize: TabBarIndicatorSize.tab,

          dividerColor: Colors.transparent,
          labelPadding: EdgeInsets.symmetric(horizontal: 0),
          indicator: BoxDecoration(
            color:Const.scaffoldColor,
            borderRadius: BorderRadius.circular(100)
          ),


          unselectedLabelStyle: Const.poppins_400_14(context),
          labelStyle: Const.poppins_600_14(context),

        ),
        
        
        outlinedButtonTheme: OutlinedButtonThemeData(
          
          

          style: ButtonStyle(

            side: WidgetStateBorderSide.resolveWith((states) => BorderSide(color: Const.yellow)),
          shape: WidgetStateOutlinedBorder.resolveWith((states) => RoundedRectangleBorder(borderRadius: BorderRadius.circular(4),
            side: BorderSide(color: Const.yellow)
          ),),
            backgroundColor:WidgetStateColor.resolveWith((states) =>Colors.black) ,
            foregroundColor: WidgetStateColor.resolveWith((states) => Const.yellow,),
            textStyle: WidgetStateTextStyle.resolveWith((states) => Const.font_700_16(context,size: SC.from_width(13))!)
          )
          
        ),

        listTileTheme: ListTileThemeData(
          // minTileHeight: SC.from_width(48),
          titleTextStyle:Const.font_500_14(context),

        ),
        
        radioTheme: RadioThemeData(
          fillColor: WidgetStateColor.resolveWith((states) => Colors.white,)
        ),

        checkboxTheme: CheckboxThemeData(

          checkColor:WidgetStateColor.resolveWith((states) => Color.fromRGBO(114, 114, 114, 1),
          ),
          
          fillColor: WidgetStateColor.resolveWith((states) => Colors.white,),


          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
          side: BorderSide.none
        ),

        //
        appBarTheme: AppBarTheme(
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontFamily: 'ProductSans',
            fontWeight: FontWeight.w900,
            fontSize: SC.from_width(18),

          ),
          elevation: 0,
          surfaceTintColor: Colors.transparent,
          color: Colors.transparent
        ),
        
        inputDecorationTheme: InputDecorationTheme(
          fillColor: Const.primeColor,

          errorStyle: TextStyle(
              fontFamily: 'ProductSansa',
              fontWeight: FontWeight.w400,
              color: Colors.red,
              fontSize: SC.from_width(10)
          ),

          hintStyle: TextStyle(
            fontFamily: 'ProductSansa',
            fontWeight: FontWeight.w400,
            color: Colors.grey.shade500,
            fontSize: SC.from_width(14)
          ),

          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: Colors.white,
            )
          ),

            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: Colors.white,
                )
            ),


          enabledBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: Colors.white,
              )
          ),

          focusedErrorBorder:OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                  color: Colors.red
              )
          ) ,



          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: Colors.red
              )
          ),

          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8)),

        ),






        
        
        
        //
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            elevation: WidgetStateProperty.resolveWith((states) => 0,),
            shape: WidgetStateOutlinedBorder.resolveWith((states) => RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
            )),
            backgroundColor: WidgetStateColor.resolveWith((states) => Const.yellow,),
            foregroundColor: WidgetStateColor.resolveWith((states) => Colors.white,),
            iconColor: WidgetStateColor.resolveWith((states) => Colors.white,),
            textStyle: WidgetStateTextStyle.resolveWith((states) => TextStyle(fontWeight: FontWeight.w700,fontSize: SC.from_width(15)),)

          )
          
        ),
        
        
        //
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Const.yellow,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(1000)
          ),
          foregroundColor: Colors.black
        ),



        scaffoldBackgroundColor: Const.scaffoldColor,


      ),
      // home: OnBoardMain(),
      home: SplashScreen(action: action,),

    );
  }
}





