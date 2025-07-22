import 'package:attach/const/app_constante.dart';
import 'package:attach/myfile/screen_dimension.dart';
import 'package:attach/providers/chatProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class AttachDocDialogOption extends StatelessWidget {
  const AttachDocDialogOption({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Card(
        shadowColor: Const.yellow,
        color: Const.primeColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        margin: EdgeInsets.symmetric(
          horizontal: SC.from_width(20),
          vertical: SC.from_width(70),
        ),
        child: Consumer<ChatProvider>(builder: (context, p, child) => GridView(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,),
          children: [



            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Ink(
                    width: SC.from_width(50),
                    height: SC.from_width(50),

                    decoration: BoxDecoration(
                      color: Const.scaffoldColor,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Const.yellow,width:1),
                    ),
                    child: InkWell(
                        onTap: (){
                          p.uploadMediaFromCamera(context);
                          Navigator.pop(context);},
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          // child: Image.asset("assets/icons/soty_icon/2dc2f413434b1a638282711334d0cbe41df7e56f.png",width: SC.from_width(20),height: SC.from_width(40)),
                          child: Image.asset("assets/newIcons/img_3.png",color: Colors.white,width: SC.from_width(20),height: SC.from_width(40)),
                        ))),
                Text("Camera Image",style: Const.font_400_14(context),),
              ],
            ),

            //
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Ink(
                    width: SC.from_width(50),
                    height: SC.from_width(50),

                    decoration: BoxDecoration(
                      color: Const.scaffoldColor,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Const.yellow,width:1),
                    ),
                    child: InkWell(
                        onTap: (){
                          p.uploadMediaFromCamera(context,isVideo: true);
                          Navigator.pop(context);
                          },
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Image.asset("assets/newIcons/img_6.png",color: Colors.white,width: SC.from_width(20),height: SC.from_width(40)),
                        ))),
                Text("Camera Video",style: Const.font_400_14(context),),
              ],
            ),

            //
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Ink(
                    width: SC.from_width(50),
                    height: SC.from_width(50),

                    decoration: BoxDecoration(
                        color: Const.scaffoldColor,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Const.yellow,width:1)
                    ),
                    child: InkWell(
                        onTap: (){
                          p.uploadMedia(context);
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Image.asset("assets/newIcons/img_4.png",color: Colors.white,width: SC.from_width(20),height: SC.from_width(40)),
                        ))),
                Text("Gallery",style: Const.font_400_14(context),),
              ],
            ),


            // //
            // Column(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Ink(
            //         width: SC.from_width(50),
            //         height: SC.from_width(50),
            //         decoration: BoxDecoration(
            //             color: Const.scaffoldColor,
            //             borderRadius: BorderRadius.circular(8),
            //             border: Border.all(color: Const.yellow,width:1)
            //         ),
            //         child: Padding(
            //           padding: EdgeInsets.all(10),
            //           child: Image.asset("assets/icons/soty_icon/docs.png",width: SC.from_width(20),height: SC.from_width(40)),
            //         )),
            //     Text("Documents",style: Const.font_400_14(context),),
            //   ],
            // ),




          ],
        ),),
      ),
    );
  }
}