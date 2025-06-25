// import 'package:attach/const/app_constante.dart';
// import 'package:attach/myfile/screen_dimension.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
//
//
// class AmountFiled extends StatelessWidget {
//   final TextEditingController?  controller;
//   const AmountFiled({this.controller,super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return TextField(
//       textAlign: TextAlign.center,
//       cursorColor: Colors.white,
//       keyboardType: TextInputType.number,
//       inputFormatters: [
//         FilteringTextInputFormatter.digitsOnly
//       ],
//       style: Const.font_900_20(context,size: SC.from_width(50)),
//
//       onChanged: (d){
//         print("this os on Chnasasge ${d.startsWith("₹")}  ${controller!=null}");
//         if(d.startsWith("₹"))
//           {
//
//           }
//         else
//           {
//             if(controller!=null)
//               {
//                 String new_s = '₹$d';
//                 print("$new_s");
//                 controller!.text= new_s;
//               }
//           }
//       },
//
//
//       decoration: InputDecoration(
//           hintText: '₹ 0',
//           hintStyle:Const.font_900_20(context,size: SC.from_width(50)) ,
//           border: InputBorder.none,
//           focusedBorder: InputBorder.none,
//           enabledBorder: InputBorder.none,
//           focusedErrorBorder: InputBorder.none
//
//       ),
//     );
//   }
// }
import 'package:attach/const/app_constante.dart';
import 'package:attach/myfile/screen_dimension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AmountFiled extends StatefulWidget {
    final TextEditingController?  controller;
  const AmountFiled({super.key,this.controller});

  @override
  State<AmountFiled> createState() => _AmountFieldState();
}

class _AmountFieldState extends State<AmountFiled> {
  late TextEditingController _controller;
  bool isFormatting = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();

    _controller.addListener(() {
      if(widget.controller!=null)
        {
          widget.controller?.text = _controller.text;
        }
      print('this is My ${isFormatting}');
      if (isFormatting) return;
      String text = _controller.text;

      if (!text.startsWith('₹') && text.isNotEmpty) {
        isFormatting = true;

        _controller.text = '₹$text';
        _controller.selection = TextSelection.fromPosition(
          TextPosition(offset: _controller.text.length),
        );
        isFormatting = false;
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextField(
        controller: _controller,
        textAlign: TextAlign.center,
        cursorColor: Colors.white,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          style: Const.font_900_20(context,size: SC.from_width(50)),
              decoration: InputDecoration(
          hintText: '₹ 0',
                  hintStyle:Const.font_900_20(context,size: SC.from_width(50)) ,
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none

      ),
      ),
    );
  }
}
