import 'package:attach/myfile/screen_dimension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final List<TextInputFormatter>? formatters;
  final Widget? leading;
  final String? Function(String?)? validator;
  final String? label;
  final String? hintText;
  final int? maxLine ;
  final bool expand;
  final TextInputType? keyTyp;
  const CustomTextField({this.expand = false,this.maxLine=1,this.keyTyp,this.controller,this.validator,this.formatters,this.hintText,this.leading,this.label,super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        if(label!=null)
          Padding(
            padding:  EdgeInsets.only(bottom: SC.from_width(12)),
            child: Text(label??'',style: TextStyle(
              fontFamily: 'ProductSans',
              fontWeight:FontWeight.w400,
              fontSize: SC.from_width(14)
            ),),
          ),

        TextFormField(
          // expands: true,
          maxLines: maxLine,
          keyboardType: keyTyp,
          validator: validator,
          style: TextStyle(
            fontFamily: 'ProductSans',
            fontWeight: FontWeight.w400,
            fontSize: SC.from_width(14)
          ),
          inputFormatters: formatters,
          decoration: InputDecoration(
            hintText: hintText,

            prefixIcon: leading,
          ),
        )
      ],
    );
  }
}




