import 'package:flutter/material.dart';




class  SC{
  static double Screen_height =0;
static double Screen_width = 0;

static getScreen(BuildContext context)
{

Screen_height = MediaQuery.of(context).size.height;
Screen_width = MediaQuery.of(context).size.width;

}

static double from_width(double n)
{
double fgh = 375;
double pr = (n*100)/fgh;
double ans = (Screen_width/100)*pr;

return ans;
}


  static double from_height(double n)
{
double fgw = 812;
double pr = (n*100)/fgw;
double ans = (Screen_height/100)*pr;
return ans;
}
}