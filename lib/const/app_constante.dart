

import 'package:attach/myfile/screen_dimension.dart';
import 'package:flutter/material.dart';

class Const{

  static Color primeColor = Color.fromRGBO(39, 25, 49, 1);
  static Color scaffoldColor = Color.fromRGBO(16, 0, 27, 1);
  static Color yellow = Color.fromRGBO(221, 161, 94, 1);
  static Color grey_190_190_190 = Color.fromRGBO(190 ,190, 190, 1);


  static  TextStyle?  font_900_34(context,{Color? color})
  {
    return TextStyle(
      fontFamily: 'ProductSans',
      color:  color,
      fontWeight: FontWeight.w900,
      fontSize: SC.from_width(34)
    );
  }


  static  TextStyle? font_900_30(context,{Color? color})
  {
    return TextStyle(
        fontFamily: 'ProductSans',
        color:  color,
        fontWeight: FontWeight.w900,
        fontSize: SC.from_width(30)
    );
  }

  static  TextStyle? font_900_20(context,{Color? color,double? size})
  {
    return TextStyle(
        fontFamily: 'ProductSans',
        color:  color,
        fontWeight: FontWeight.w900,
        fontSize: size??SC.from_width(20)
    );
  }


  static  TextStyle? font_900_28(context,{Color? color,double? size})
  {
    return TextStyle(
        fontFamily: 'ProductSans',
        color:  color,
        fontWeight: FontWeight.w900,
        fontSize: size??SC.from_width(28)
    );
  }

  static  TextStyle? font_400_12(context,{Color? color,double? size})
  {
    return TextStyle(
        fontFamily: 'ProductSans',
        color:  color,
        fontWeight: FontWeight.w400,
        fontSize: size??SC.from_width(12)
    );
  }

  static  TextStyle? font_400_16(context,{Color? color,double? size})
  {
    return TextStyle(
        fontFamily: 'ProductSans',
        color:  color,
        fontWeight: FontWeight.w400,
        fontSize: size??SC.from_width(16)
    );
  }


  static  TextStyle? font_400_14(context,{Color? color,double? size})
  {
    return TextStyle(
        fontFamily: 'ProductSans',
        color:  color,
        fontWeight: FontWeight.w400,
        fontSize: size??SC.from_width(14)
    );
  }



  static  TextStyle? font_500_24(context,{Color? color,double? size})
  {
    return TextStyle(
        fontFamily: 'ProductSans',
        color:  color,
        fontWeight: FontWeight.w500,
        fontSize:size?? SC.from_width(24),
    );
  }


  static  TextStyle? font_500_16(context,{Color? color,double? size})
  {
    return TextStyle(
        fontFamily: 'ProductSans',
        color:  color,
        fontWeight: FontWeight.w500,
        fontSize: size??SC.from_width(16)
    );
  }



  static  TextStyle? font_500_14(context,{Color? color,double? size})
  {
    return TextStyle(
        fontFamily: 'ProductSans',
        color:  color,
        fontWeight: FontWeight.w500,
        fontSize: size??SC.from_width(14)
    );
  }


  static  TextStyle? font_500_12(context,{Color? color,double? size})
  {
    return TextStyle(
        fontFamily: 'ProductSans',
        color:  color,
        fontWeight: FontWeight.w500,
        fontSize: size??SC.from_width(12)
    );
  }


  static  TextStyle? font_500_18(context,{Color? color,double? size})
  {
    return TextStyle(
        fontFamily: 'ProductSans',
        color:  color,
        fontWeight: FontWeight.w500,
        fontSize: size??SC.from_width(18)
    );
  }


  static  TextStyle? font_700_30(context,{Color? color,double? size})
  {
    return TextStyle(
        fontFamily: 'ProductSans',
        color:  color,
        fontWeight: FontWeight.w700,
        fontSize: size??SC.from_width(30)
    );
  }

  static  TextStyle? font_700_14(context,{Color? color,double? size})
  {
    return TextStyle(
        fontFamily: 'ProductSans',
        color:  color,
        fontWeight: FontWeight.w700,
        fontSize: size??SC.from_width(14)
    );
  }


  static  TextStyle? font_700_16(context,{Color? color,double? size})
  {
    return TextStyle(
        fontFamily: 'ProductSans',
        color:  color,
        fontWeight: FontWeight.w700,
        fontSize: size??SC.from_width(16)
    );
  }


  static  TextStyle? poppins_500_14(context,{Color? color,double? size})
  {
    return TextStyle(
        fontFamily: 'Poppins',
        color:  color,
        fontWeight: FontWeight.w500,
        fontSize: size??SC.from_width(14)
    );
  }


  static  TextStyle? poppins_400_14(context,{Color? color,double? size})
  {
    return TextStyle(
        fontFamily: 'Poppins',
        color:  color,
        fontWeight: FontWeight.w400,
        fontSize: size??SC.from_width(14)
    );
  }


  static  TextStyle? poppins_600_14(context,{Color? color,double? size})
  {
    return TextStyle(
        fontFamily: 'Poppins',
        color:  color,
        fontWeight: FontWeight.w600,
        fontSize: size??SC.from_width(14)
    );
  }





  static  TextStyle? poppins_500_142(context,{Color? color,double? size})
  {
    return TextStyle(
        fontFamily: 'Poppins',
        // fontStyle: FontStyle.italic,
        color:  color,
        fontWeight: FontWeight.w500,
        fontSize: size??SC.from_width(14)
    );
  }


  static  TextStyle? roboto_300_12(context,{Color? color,double? size})
  {
    return TextStyle(
        fontFamily: 'Roboto',
        // fontStyle: FontStyle.italic,
        color:  color,
        fontWeight: FontWeight.w300,
        fontSize: size??SC.from_width(12)
    );
  }

  static  TextStyle? roboto_400_12(context,{Color? color,double? size})
  {
    return TextStyle(
        fontFamily: 'Roboto',
        // fontStyle: FontStyle.italic,
        color:  color,
        fontWeight: FontWeight.w400,
        fontSize: size??SC.from_width(12)
    );
  }


  static  TextStyle? inter_700_21(context,{Color? color,double? size})
  {
    return TextStyle(
        fontFamily: 'inter',
        // fontStyle: FontStyle.italic,
        color:  color,
        fontWeight: FontWeight.w700,
        fontSize: size??SC.from_width(21)
    );
  }

  static  TextStyle? inter_400_11(context,{Color? color,double? size})
  {
    return TextStyle(
        fontFamily: 'inter',
        // fontStyle: FontStyle.italic,
        color:  color,
        fontWeight: FontWeight.w400,
        fontSize: size??SC.from_width(11)
    );
  }


}