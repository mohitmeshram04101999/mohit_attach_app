import 'package:attach/componant/custome_action_button.dart';
import 'package:attach/const/app_constante.dart';
import 'package:attach/myfile/screen_dimension.dart';
import 'package:attach/providers/listener_filer_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class AgeRangeDialog extends StatefulWidget {
  const AgeRangeDialog({super.key});

  @override
  State<AgeRangeDialog> createState() => _AgeRangeDialogState();
}

class _AgeRangeDialogState extends State<AgeRangeDialog> {



  RangeValues? value;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    value = Provider.of<ListenerFilterProvider>(context,listen: false).selectedRange;
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      backgroundColor: Const.primeColor,
        onClosing: (){},
        builder: (context) {
          return Consumer<ListenerFilterProvider>(builder:(context, p, child) =>
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  SizedBox(height: SC.from_width(10),),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:21),
                    child: Text("Select Age Range",style: Const.font_500_24(context,size: SC.from_width(21)),),
                  ),


                  InkWell(
                    onTap: (){

                        value = null;


                      setState(() {

                      });
                    },
                    child: Padding(

                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: Row(
                        children: [
                          Radio(
                              activeColor:WidgetStateColor.resolveWith((states) => Const.yellow,),
                              value:null, groupValue: value, onChanged: (d){
                                print(d==value);
                            if(d==value)
                            {
                              value = null;
                            }
                            else
                            {
                              value = d;
                            }
                            setState(() {

                            });
                          }),
                          Text("All age",style: Const.font_400_16(context),)
                        ],
                      ),
                    ),
                  ),

                  for(RangeValues v in p.ageRange)
                    InkWell(
                      onTap: (){
                        if(v==value)
                          {
                            value = null;
                          }
                        else
                          {
                            value = v;
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
                                value:v, groupValue: value, onChanged: (d){
                                  if(d==value)
                                    {
                                      value = null;
                                    }
                                  else
                                    {
                                      value = d;
                                    }
                                  setState(() {

                                  });
                            }),
                            Text("${v.start.toInt()} - ${v.end.toInt()}  age",style: Const.font_400_16(context),)
                          ],
                        ),
                      ),
                    ),

                  SizedBox(height: SC.from_width(10),),
                    Container(
                      padding:  const EdgeInsets.symmetric(horizontal: 14),
                    height: SC.from_width(48),
                    child: CustomActionButton(

                      action: (){
                      p.setAgeRange(value);
                      p.refresh();
                      Navigator.pop(context);
                    },lable: 'Submit',),
                  ),
                  SizedBox(height: SC.from_width(15),)


                ],
              ),);
        }
    );
  }
}
