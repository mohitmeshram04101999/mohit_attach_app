import 'dart:async';
import 'dart:developer';
import 'package:attach/const/app_constante.dart';
import 'package:attach/myfile/screen_dimension.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';



class MyactionButton extends StatefulWidget {

  bool activeOnInit;
  bool showLoader;
  Color? color;
  Color? foregroundColor;
  bool? handelError;
  Duration? duretion;
  BorderRadius? borderRadius;
  Widget? child;
  Widget? trailingIcon;
  double? height;
  String? customErrorMessage;
  String? lable;
  Curve? curve;
  double? width;
  EdgeInsets? margin;
  bool inversTheme;
  Function(dynamic)? onActionComplit;
  Function action;
  Widget? activeChild;
  BoxDecoration? decoration;
  BoxDecoration? activeDecoration;
  TextStyle? lableStyle;
  MyactionButton({

    this.handelError,
    this.showLoader= true,
    this.lable,
    this.color,
    this.margin,
    this.customErrorMessage,
    this.curve,
    this.height,
    this.trailingIcon,
    this.lableStyle,
    this.width,
    this.foregroundColor,
    this.onActionComplit,
    required this.action,
    this.child,
    this.activeChild,
    this.decoration,
    this.activeDecoration,
    this.duretion,
    this.borderRadius,
    this.inversTheme = false,
    this.activeOnInit = false,
    super.key,
  });

  @override
  State<MyactionButton> createState() => _MyactionButtonState();
}

class _MyactionButtonState extends State<MyactionButton> {
  @override
  void didUpdateWidget(covariant MyactionButton oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.activeOnInit)
    {
      Timer(Duration(seconds: 1),(){
        onTapFunction();
      });
    }
  }

  bool loding = false;

  onTapFunction() async {
    if (loding == false) {
      if(widget.showLoader)
      {
        loding = true;
        setState(() {});
      }

      if (kDebugMode) {
        dynamic returnData = await widget.action();
        log(widget.onActionComplit.toString());
        if (widget.onActionComplit != null) {
          widget.onActionComplit!(returnData);
        }
      } else {
        try {
          dynamic returnData = await widget.action();
          log(widget.onActionComplit.toString());
          if (widget.onActionComplit != null) {
            widget.onActionComplit!(returnData);
          }
        } catch (e) {
          log("${'--' * 10} Error from myActionButton ${'--' * 10}\n");
          log(e.toString());
          log(widget.customErrorMessage.toString());
          log("${'--' * 10} Error from myActionButton ${'--' * 10}\n");
          if (widget.customErrorMessage != null) {
            ('${widget.customErrorMessage}');
          } else {
            print("Something went wrong");
          }
        }
      }

      if(widget.showLoader)
      {
        loding = false;
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapFunction,
      child: AnimatedContainer(
        margin: widget.margin ?? EdgeInsets.zero,
        curve: widget.curve ?? Curves.easeInOut,
        duration: widget.duretion ?? Duration(milliseconds: 300),
        height: widget.height ?? SC.from_width(46),

        // width: loding
        //     ? widget.height
        //     : widget.width ?? MediaQuery.of(context).size.width - 30,

        // width: loding
        //     ? (widget.height ?? SC.from_width(43)) // Use a default height value
        //     : (widget.width ?? MediaQuery.of(context).size.width - 30),
        width: (widget.width ?? MediaQuery.of(context).size.width),
        decoration:
        !loding
            ? widget.decoration ??
            BoxDecoration(
              color:
              widget.inversTheme
                  ? Colors.white
                  : (widget.color ?? Const.primeColor),
              borderRadius:
              widget.borderRadius ?? BorderRadius.circular(2),
              boxShadow: [
                if (widget.inversTheme)
                  BoxShadow(
                    color: Colors.grey.shade100,
                    spreadRadius: 2,
                    blurRadius: 2,
                  ),
              ],
            )
            : widget.activeDecoration ??
            BoxDecoration(
              color:
              widget.inversTheme
                  ? Colors.white
                  : (widget.color ?? Const.primeColor),
              borderRadius:
              widget.borderRadius ?? BorderRadius.circular(2),
              boxShadow: [
                if (widget.inversTheme)
                  BoxShadow(
                    color: Colors.grey.shade100,
                    spreadRadius: 2,
                    blurRadius: 2,
                  ),
              ],
            ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (loding)
              SizedBox(
                height: SC.from_width(20),
                width: SC.from_width(20),
                child: CircularProgressIndicator(
                  color:
                  widget.inversTheme
                      ? (widget.color ?? Const.primeColor)
                      : widget.foregroundColor??Colors.white,
                  strokeWidth: 3,
                ),
              ),

            if (widget.child != null && loding == false) widget.child!,

            //
            if (widget.lable != null)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: SC.from_width(8)),
                child: Text(
                  "${widget.lable}",
                  style:widget.lableStyle??TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: SC.from_width(16),
                    color:
                    widget.inversTheme
                        ? (widget.color ?? Const.primeColor)
                        : widget.foregroundColor??Colors.white,
                  ),
                ),
              ),

            if (widget.trailingIcon != null)
              Theme(
                data: ThemeData(
                  iconTheme: IconThemeData(
                    color:
                    widget.inversTheme
                        ? (widget.color ?? Const.primeColor)
                        : Colors.white,
                  ),
                ),
                child: widget.trailingIcon!,
              ),
          ],
        ),
      ),
    );
  }
}
