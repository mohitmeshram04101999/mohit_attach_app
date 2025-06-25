import 'package:attach/componant/custome_action_button.dart';
import 'package:attach/const/app_constante.dart';
import 'package:attach/modles/all_language_responce_model.dart';
import 'package:attach/myfile/screen_dimension.dart';
import 'package:attach/providers/language_provider.dart';
import 'package:attach/providers/listener_filer_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class LanguageDialog extends StatefulWidget {
  const LanguageDialog({super.key});

  @override
  State<LanguageDialog> createState() => _LanguageDialogState();
}

class _LanguageDialogState extends State<LanguageDialog> {



  Language? language;
  var _p;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _p = Provider.of<ListenerFilterProvider>(context,listen: false);
    language = _p.selectedLanguage;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SC.from_width(400),
      child: BottomSheet(
          backgroundColor: Const.primeColor,
          onClosing: (){},
          builder: (context) {
            return Consumer<LanguageProvider>(builder:(context, p, child) {
              if(p.loading)
                {
                  return Center(child: CircularProgressIndicator(),);
                }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: SC.from_width(10),),
      
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:21),
                    child: Text("Select Language",style: Const.font_500_24(context,size: SC.from_width(21)),),
                  ),


                  Expanded(
                    child: ListView(
                      children: [

                        InkWell(
                          onTap: (){

                            language = null;
                            setState(() {

                            });
                          },
                          child: Padding(

                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            child: Row(
                              children: [
                                Radio(
                                    activeColor:WidgetStateColor.resolveWith((states) => Const.yellow,),
                                    value:null, groupValue: language, onChanged: (d){
                                  if(d==language)
                                  {
                                    language = null;
                                  }
                                  setState(() {
                                  });
                                }),
                                Text("All Language",style: Const.font_400_16(context),)
                              ],
                            ),
                          ),
                        ),

                        for(Language v in p.allLanguage)
                          InkWell(
                            onTap: (){
                              if(v == language)
                              {
                                language = null;
                              }
                              else
                              {
                                language = v;
                              }
                              setState(() {

                              });
                            },
                            child: Padding(

                              padding: const EdgeInsets.symmetric(horizontal: 6),
                              child: Row(
                                children: [
                                  Radio(
                                      activeColor:WidgetStateColor.resolveWith((states) => Const.yellow,),
                                      value:v, groupValue: language, onChanged: (d){
                                    if(d==language)
                                    {
                                      language = null;
                                    }
                                    else
                                    {
                                      language = d;
                                    }
                                    setState(() {

                                    });
                                  }),
                                  Text("${v.name??''}",style: Const.font_400_16(context),)
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
      
                  SizedBox(height: SC.from_width(10),),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 14),
                    height: SC.from_width(48),
                    child: CustomActionButton(
      
                      action: (){
                        _p.setLanguage(language);
                        _p.refresh();
                        Navigator.pop(context);
                      },lable: 'Submit',),
                  ),
                  SizedBox(height: SC.from_width(15),)
      
      
                ],
              );
            }
      
              ,);
          }
      ),
    );
  }
}
