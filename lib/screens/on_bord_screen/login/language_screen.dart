import 'package:attach/componant/BackButton.dart';
import 'package:attach/const/app_constante.dart';
import 'package:attach/myfile/myast%20dart%20file.dart';
import 'package:attach/myfile/screen_dimension.dart';
import 'package:attach/screens/dash_board_screen/dash_board_screen.dart';
import 'package:flutter/material.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {


  List<String> language = [
    'Hindi',
    'English',
    'Gujarati',
    'Bangali',
    'Marathi',
    'Odia',
    'Telugu',
    'Panjabi',
    'Tamil',
    'Malayalam',
    'Assamese',
    'Kannada',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        leading: MyBackButton(),
      ),


      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 20
        ),
        children: [

          Text("Language you speak\nmost",style: Const.font_900_34(context),),
          SizedBox(height: SC.from_width(36),),

          //
          GridView.builder(
            primary: false,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                crossAxisSpacing: SC.from_width(21),
                mainAxisSpacing: SC.from_width(24),
                mainAxisExtent: SC.from_width(56)
              ),

              itemCount: language.length,
              itemBuilder:(context, index) => Ink(



                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.white
                  )
                ),

                child: InkWell(
                  onTap: (){
                    RoutTo(context, child: (p0, p1) => DashBoardScreen(),);
                  },
                    borderRadius:BorderRadius.circular(8),
                    child: Center(child: Text(language[index],style: Const.font_500_16(context,size: SC.from_width(18)),))),
              ),
          )

        ],
      ),

    );
  }
}
