import 'dart:convert';

import 'package:attach/api/authAPi.dart';
import 'package:attach/api/local_db.dart';
import 'package:attach/componant/profile_aVTAR.dart';
import 'package:attach/providers/my_hleper.dart';
import 'package:attach/providers/profileProvider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:provider/provider.dart';



class SelectAvtarScreen extends StatefulWidget {
  const SelectAvtarScreen({super.key});

  @override
  State<SelectAvtarScreen> createState() => _SelectAvtarScreenState();
}

class _SelectAvtarScreenState extends State<SelectAvtarScreen> {






  _getProfileAvtar() async
  {
    var resp = await AuthApi().getAvtar();

    switch(resp.statusCode)
    {
      case 200:
        var data = jsonDecode(resp.body);
        List list = data['data'];

        avtars.clear();
        list.forEach((element) {
          if(DB.curruntUser?.gender==element['type'])
            {
              avtars.add(element['image']);
            }
        });



        break;


        case 400:
          MyHelper.snakeBar(context, title: 'Something went wrong', message: '${jsonDecode(resp.body)['message']}', type: SnakeBarType.error);
        break;

        case 500:
          MyHelper.serverError(context, resp.body);
        break;

        case 401:
          MyHelper.tokenExp(context);
        break;

        case 403:
        break;

        case 404:
          MyHelper.snakeBar(context, title: 'Not Found', message: '${jsonDecode(resp.body)['message']}', type: SnakeBarType.error);
        break;



        default:
          MyHelper.serverError(context, '${resp.statusCode} \n ${resp.body}');
          break;
    }
  }




  List<String> avtars  = [];



  @override
  Widget build(BuildContext context) {
    return Scaffold(

      floatingActionButton: (kDebugMode)?FloatingActionButton(onPressed: _getProfileAvtar,):null,

      appBar: AppBar(
        title: Text("Select Avtar"),
      ),

      body: FutureBuilder(
          future: _getProfileAvtar(),
          builder: (context, snapshot){
            return GridView(
              padding: EdgeInsets.symmetric(horizontal: 14),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(  crossAxisCount: 3,),
              children: List.generate(avtars.length, (index) {
                return GestureDetector(
                  onTap: () async {
                    Provider.of<ProfileProvider>(context,listen: false).setAvtar(avtars[index]);
                    Navigator.pop(context);
                  },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ProfileAvtar(
                        image: avtars[index],imageType: ImageType.network,),
                    ),
                );
              }
            ));
      }),

    );
  }
}
