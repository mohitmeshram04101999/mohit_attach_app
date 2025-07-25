import 'package:attach/api/local_db.dart';
import 'package:attach/myfile/screen_dimension.dart';
import 'package:flutter/material.dart';




class OnlineUserImageWidget extends StatelessWidget {
  final String image;
  final bool online;
  final bool busy;
  final bool asset;
  final String? gender;
  const OnlineUserImageWidget({this.gender,this.busy = false,this.asset = false,this.online= true,required this.image,super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SC.from_width(48),
      width: SC.from_width(48),
      child: Stack(
        children: [

          Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              shape: BoxShape.circle,

            ),
            child: asset?
            Image.asset(
              image,
              errorBuilder: (context, error, stackTrace) => Icon(Icons.person),
              fit: BoxFit.cover,) :
            Image.network(
              image,
              height: double.infinity,
              width: double.infinity,
              errorBuilder: (context, error, stackTrace)=>Container(
                color: Color.fromRGBO(97, 97, 97, .58),
              ),
              fit: BoxFit.cover,),
          ),

          if(online)
            Positioned(
              bottom: 0,right: 0,
              child: Container(
                height: SC.from_width(14),
                width: SC.from_width(14),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:busy?Colors.orange: Colors.green,
                    border: Border.all(color: Colors.white,width: 2)
                ),
              ),
            )

        ],
      ),
    );
  }
}
