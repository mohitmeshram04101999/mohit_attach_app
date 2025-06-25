import 'package:attach/componant/BackButton.dart';
import 'package:attach/componant/custome_action_button.dart';
import 'package:attach/componant/laguage_grid_tile.dart';
import 'package:attach/const/app_constante.dart';
import 'package:attach/myfile/action%20Button.dart';
import 'package:attach/myfile/myast%20dart%20file.dart';
import 'package:attach/myfile/screen_dimension.dart';
import 'package:attach/providers/language_provider.dart';
import 'package:attach/providers/profileProvider.dart';
import 'package:attach/screens/dash_board_screen/dash_board_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<LanguageProvider>(context,listen: false).getAllLanguage(context);
  }

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
          Consumer<LanguageProvider>(builder: (context, p, child) {
            if(p.loading)
              {
                return AspectRatio(
                  aspectRatio: 1,
                    child: Center(child: CircularProgressIndicator(),));
              }

            return GridView.builder(
              primary: false,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: SC.from_width(21),
                  mainAxisSpacing: SC.from_width(24),
                  mainAxisExtent: SC.from_width(56)
              ),

              itemCount: p.allLanguage.length,
              itemBuilder:(context, index) => LanguageGridTile(
                  language: p.allLanguage[index],
                active: p.isSelected(p.allLanguage[index]),
                onTap: (){
                    p.selectLanguage(p.allLanguage[index]);
                },

              ),
            );
          },),

          SizedBox(height: SC.from_width(20),),



          SizedBox(
            height: SC.from_width(48),
            child: CustomActionButton(
                action: (){
                 var p =  Provider.of<ProfileProvider>(context,listen: false);
                 var l =  Provider.of<LanguageProvider>(context,listen: false);
                 p.createProfile(context);
                },
              lable: 'Next',
            ),
          )

        ],
      ),

    );
  }
}
