import 'package:attach/const/app_constante.dart';
import 'package:attach/myfile/screen_dimension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final List<TextInputFormatter>? formatters;
  final Widget? leading;
  final String? Function(String?)? validator;
  final String? label;
  final String? labelSide;
  final String? hintText;
  final int? maxLine ;
  final bool expand;
  final bool filled;
  final TextInputType? keyTyp;
  final void Function()? onTap;
  final bool readOnly;
  const CustomTextField({this.labelSide,this.readOnly= false,this.onTap,this.filled=false,this.expand = false,this.maxLine=1,this.keyTyp,this.controller,this.validator,this.formatters,this.hintText,this.leading,this.label,super.key});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  
  String? vMessage;
  
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        if(widget.label!=null)
          Padding(
            padding: EdgeInsets.only(bottom: SC.from_width(8)),
            child: RichText(
              text: TextSpan(
                text: widget.label ?? '',
                style: TextStyle(
                  fontFamily: 'ProductSans',
                  fontWeight: FontWeight.w400,
                  fontSize: SC.from_width(14), // Default text color
                ),

                children: (widget.labelSide != null)
                    ? [
                        WidgetSpan(
                          child: Padding(
                            padding: EdgeInsets.only(left: SC.from_width(5)),
                            child: Text(
                              widget.labelSide ?? '',
                              style: TextStyle(
                                fontFamily: 'ProductSans',
                                fontWeight: FontWeight.w400,
                                fontSize: SC.from_width(14),
                                color: Const.grey_190_190_190// Default text color
                              ),
                            ),
                          ),
                        ),
                      ]
                    : [],

              ),
            ),
          ),

        TextFormField(
          onTap: widget.onTap,
          readOnly: widget.readOnly,
          controller: widget.controller,
          // expands: true,
          cursorColor: Colors.white,
          maxLines: widget.maxLine,

          onChanged: (d){
            if(widget.validator!=null)
              {
                vMessage = widget.validator!(d);
                setState(() {

                });
              }

          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          keyboardType: widget.keyTyp,
          validator: (d)
          {
            if(widget.validator!=null)
              {
                vMessage = widget.validator!(d);

              }

            return vMessage;
          },
          style: TextStyle(
            fontFamily: 'ProductSans',
            fontWeight: FontWeight.w400,
            fontSize: SC.from_width(14),
             color: Colors.white
          ),

          inputFormatters: widget.formatters,
          decoration: InputDecoration(
            // contentPadding: EdgeInsets.zero,
            hintText: widget.hintText,
            errorStyle: TextStyle(fontSize: 0),
            errorText: null,
            filled: widget.filled,
            prefixIcon: widget.leading,
          ),
        ),
        if(vMessage!=null)
          Padding(
            padding:  EdgeInsets.only(top: SC.from_width(5)),
            child: Text(vMessage!,style: Const.font_400_12(context,size: SC.from_width(10),color: Colors.red),),
          )
      ],
    );
  }
}




