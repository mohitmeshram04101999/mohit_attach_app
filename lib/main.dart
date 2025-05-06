import 'package:attach/const/app_constante.dart';
import 'package:attach/myfile/myast%20dart%20file.dart';
import 'package:attach/myfile/screen_dimension.dart';
import 'package:attach/providers/audioCallProvider.dart';
import 'package:attach/screens/on_bord_screen/on_board_main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => AudioCallProvider(),)
    ],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    SC.getScreen(context);
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',




      theme: ThemeData(


        cardTheme: CardThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(9)
          ),
          color: Const.primeColor,
          elevation: 0,

        ),

        tabBarTheme: TabBarTheme(
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

        listTileTheme: ListTileThemeData(
          // minTileHeight: SC.from_width(48),
          titleTextStyle:Const.font_500_14(context)

        ),
        
        radioTheme: RadioThemeData(
          fillColor: WidgetStateColor.resolveWith((states) => Colors.white,)
        ),

        checkboxTheme: CheckboxThemeData(
          checkColor:WidgetStateColor.resolveWith((states) => Colors.white,),


          shape: RoundedRectangleBorder(),
          side: BorderSide.none
        ),

        //
        appBarTheme: AppBarTheme(
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontFamily: 'ProductSans',
            fontWeight: FontWeight.w900,
            fontSize: SC.from_width(16),

          ),
          elevation: 0,
          surfaceTintColor: Colors.transparent,
          color: Colors.transparent
        ),
        
        inputDecorationTheme: InputDecorationTheme(

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

          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: Colors.red,
              )
          ),

          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8)),

        ),




        
        
        
        //
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            elevation: WidgetStateProperty.resolveWith((states) => 0,),
            shape: WidgetStateOutlinedBorder.resolveWith((states) => LinearBorder.none,),
            backgroundColor: WidgetStateColor.resolveWith((states) => Colors.transparent,),
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

        colorScheme: ColorScheme.dark(primary: Const.primeColor),


        scaffoldBackgroundColor: Const.scaffoldColor,


      ),
      home: OnBoardMain(),
    );
  }
}


