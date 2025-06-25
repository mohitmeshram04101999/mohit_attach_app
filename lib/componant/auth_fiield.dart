
import 'package:attach/myfile/screen_dimension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AuthField extends StatelessWidget {
  final TextEditingController? controller;
  final List<TextInputFormatter>? formatters;
  final Widget? leading;
  final String? Function(String?)? validator;
  final String? label;
  final String? hintText;
  final TextInputType? keyTyp;
  const AuthField({this.keyTyp,this.controller,this.validator,this.formatters,this.hintText,this.leading,this.label,super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        if(label!=null)
          Padding(
            padding:  EdgeInsets.only(bottom: SC.from_width(12)),
            child: Text(label??'',style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight:FontWeight.w500,
                fontSize: SC.from_width(14)
            ),),
          ),

        TextFormField(
          controller: controller,
          keyboardType: keyTyp,
          validator: validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,

          style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
              fontSize: SC.from_width(16)
          ),
          inputFormatters: formatters,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                fontSize: SC.from_width(14),
              color: Colors.grey.shade500
            ),
            prefixIcon: leading,
          ),
        )
      ],
    );
  }
}