import 'dart:io';
import 'dart:ui';

import 'package:attach/const/app_constante.dart';
import 'package:attach/modles/usertype.dart';
import 'package:attach/myfile/screen_dimension.dart';
import 'package:attach/providers/profileProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ProfileAvtar extends StatelessWidget {
  final  String? image;
  final ImageType? imageType;
  final String? gender;
  const ProfileAvtar({
    required this.imageType,
    this.gender,
    required this.image,super.key});

  @override
  Widget build(BuildContext context) {

    Widget? imageWidget;
    switch(imageType)
    {
      case ImageType.file:
        imageWidget = Image.file(File(image??''),fit: BoxFit.cover,);
        break;

      case ImageType.asset:
        imageWidget = Image.asset(image??'',fit: BoxFit.cover,);
        break;

      case ImageType.network:
        imageWidget = Image.network(image??'',fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {

            return Consumer<ProfileProvider>(
              builder: (context, p, child) {

                return ColorFiltered(
                  colorFilter: ColorFilter.mode(Const.primeColor,BlendMode.overlay),child:
                ((gender??p.user?.gender)==UserGander.male)?
                // (false)?
                Image.asset("assets/avtars/maleFix.jpg",fit: BoxFit.cover,):
                Image.asset("assets/avtars/femaleFix.jpg",fit: BoxFit.cover,)
                  ,
                );
              },
            );

          },);
        break;

      default:
        imageWidget = Image.asset("assets/static/sempleProfile.jpg",fit: BoxFit.cover,);
        break;
    }

    return  Container(
      height: SC.from_width(92),
      width: SC.from_width(92),

      child: Container(
        margin: EdgeInsets.all(3),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,

        ),
        child: Container(
          margin: EdgeInsets.all(3),
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
              shape: BoxShape.circle
          ),
          child: imageWidget,
        ),
      ),
    );
  }
}


enum ImageType
{
  file,
  network,
  asset,
}
