import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:attach/api/bankpai/other_api.dart';
import 'package:attach/componant/coustom_text_field.dart';
import 'package:attach/componant/custome_action_button.dart';
import 'package:attach/const/app_constante.dart';
import 'package:attach/myfile/screen_dimension.dart';
import 'package:attach/path_configuration/navigation_paths.dart';
import 'package:attach/providers/anylistics_provider.dart';
import 'package:attach/providers/my_hleper.dart';
import 'package:attach/providers/profileProvider.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';


class KycScreen extends StatefulWidget {
  const KycScreen({super.key});

  @override
  State<KycScreen> createState() => _KycScreenState();
}

class _KycScreenState extends State<KycScreen> {



  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _adharNumberController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String? _adhartFront;
  String? _adhartBack;

  bool _uploading = false;

  Future<void> pickFrontImage() async {
    final ImagePicker picker = ImagePicker();

    try {
      final XFile? pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80, // compresses image (0-100)
      );

      if (pickedFile != null) {
        _adhartFront = pickedFile.path;
        setState(() {

        });
        return ;
      } else {

        return null;
      }
    } catch (e) {
      Logger().e("Image pick error: $e");
      return null;
    }
  }

  Future<void> pickBackImage() async {
    final ImagePicker picker = ImagePicker();

    try {
      final XFile? pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80, // compresses image (0-100)
      );

      if (pickedFile != null) {
        _adhartBack = pickedFile.path;
        setState(() {

        });
        return ;
      } else {

        return null;
      }
    } catch (e) {
      Logger().e("Image pick error: $e");
      return null;
    }
  }


  Future<void> pickDateOfBirth() async
  {

    var _theme = Theme.of(context).datePickerTheme;
    DateTime? _d = await showDatePicker(
      barrierColor: Colors.transparent,

      builder: (context, child) => Theme(data: ThemeData(
        colorScheme: ColorScheme.dark(primary: Const.yellow,
          onPrimary: Colors.white

        ),

        datePickerTheme: _theme
      ), child: child!),

      context: context, firstDate:  DateTime(1000), lastDate: DateTime.now(),
    );
    if(_d!=null)
      {
        _dobController.text = "${_d.year}-${_d.month}-${_d.day}";
      }
  }



  submitKYC()async
  {

    if(_adhartFront==null&&_adhartBack==null)
      {
        MyHelper.snakeBar(context, title: "Incomplete detail", message: "Submit You Aadhar Image of front and back");
      }

    if(formKey.currentState!.validate()&&(_adhartFront!=null&&_adhartBack!=null))
    {
      _uploading = true;

      await Future.delayed(Duration(seconds: 2));

      var resp = await OtherApi().createKyc(context,
        aadharFrontImage: _adhartFront??'',
        aadharBackImage: _adhartBack??'',
        aadharDOB: _dobController.text.trim(),
        aadharNumber: _adharNumberController.text.trim(),
        aadharName: _nameController.text.trim(),
        onProgressFront: (d)async{

          await AwesomeNotifications().createNotification(

            content: NotificationContent(
              id: 1002, // keep same ID to update
              channelKey: 'UPLOAD_FILE',
              title: 'Uploading Aadhar front...',
              body: '${(d*100).toString().split(".").first}% uploaded',
              notificationLayout: NotificationLayout.ProgressBar,
              progress: d * 100,
              locked: true,
              autoDismissible: false,
            ),


          );

        },
        onProgressBack: (d) async{

          await AwesomeNotifications().createNotification(
            content: NotificationContent(
              id: 1003,
              channelKey: 'UPLOAD_FILE',
              title: 'Uploading Aadhar back...',
              body: '${(d*100).toString().split(".").first}% uploaded',
              notificationLayout: NotificationLayout.ProgressBar,
              progress: d * 100,
              locked: true,
              autoDismissible: false,
            ),
          );
        },
      );



      AwesomeNotifications().dismiss(1002);
      AwesomeNotifications().dismiss(1003);
      _uploading = false;

      switch (resp.statusCode) {
        case 201:
          MyHelper.snakeBar(
            context,
            title: "Kyc Update",
            message: "Detail Submitted",
            type: SnakeBarType.success,
          );

          await Provider.of<ProfileProvider>(context,listen: false).getUser(context);

          Navigator.pop(context);
          break;

        case 400:
          MyHelper.snakeBar(
            context,
            title: 'Can not Update',
            message: '${jsonDecode(resp.body)['message']}',
            type: SnakeBarType.error,
          );
          break;

        case 403:
          MyHelper.snakeBar(
            context,
            title: 'Restrict Server',
            message: '${jsonDecode(resp.body)['message']}',
            type: SnakeBarType.error,
          );
          break;

        case 401:
          MyHelper.tokenExp(context);
          break;

        case 500:
          MyHelper.serverError(context, resp.body);
          break;

        default:
          MyHelper.serverError(
            context,
            '${resp.statusCode}\n${resp.body}',
            title: 'Exception',
          );
          break;
      }

      _uploading = false;


    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    createEvent(eventName: AnilisticsEvent.navigation, componentName: Screens.kycScreen);
  }




  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{

        if(_uploading)
          {
            return false;
          }
        else
          {
            return true;
          }

      },
      child: Scaffold(
        appBar: AppBar(),


        body: Form(
          key: formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 14),
            children: [

              Text("Aadhaar KYC Verification",style: Const.font_900_20(context),),
              SizedBox(height: SC.from_width(5),),
              Text("To become a Listener, you must complete Aadhaar verification.",style: Const.font_400_12(context),),

              SizedBox(height: SC.from_width(29),),

              CustomTextField(
                controller: _adharNumberController,
                label: 'Adhaar Number',
                keyTyp: TextInputType.number,
                formatters: [
                  FilteringTextInputFormatter.digitsOnly
                ],
                filled: true,
                hintText: 'Enter your aadhaar number',
                validator: (d){
                  if(d!.isEmpty)
                    {
                      return 'Enter Aadhar Number';
                    }
                },
              ),
              SizedBox(height: SC.from_width(20),),

              CustomTextField(
                controller: _nameController,
                label: 'Full name ( as per Aadhaar number )',
                filled: true,
                hintText: 'Enter your Aadhaar name',
                  validator: (d){
                    if(d!.isEmpty)
                    {
                      return 'Enter Aadhar name';
                    }
                  }
              ),
              SizedBox(height: SC.from_width(20),),


              CustomTextField(
                controller: _dobController,
                readOnly: true,
                label: 'DOB',
                onTap: pickDateOfBirth,

                filled: true,
                hintText: 'Enter your DOB',
                  validator: (d){
                    if(d==null||d.isEmpty)
                    {
                      return 'Enter Aadhar Date Of Birth';
                    } 
                  }
              ),
              SizedBox(height: SC.from_width(40),),

              Text("Upload Adhaar documents ",style: Const.font_400_14(context),),
              SizedBox(height: SC.from_width(12),),

              SizedBox(
              child: Row(children: [

                Expanded(child: GestureDetector(
                  onTap: ()=>pickFrontImage(),
                  child: Card(
                    clipBehavior: Clip.hardEdge,
                    child: DottedBorder(
                      borderType: BorderType.RRect,
                      radius: Radius.circular(8),
                      color: Colors.white,
                      dashPattern: [8,8],
                      child: (_adhartFront!=null)?
                          Image.file(File(_adhartFront!)):
                      Padding(
                        padding:  EdgeInsets.symmetric(horizontal: SC.from_width(24),vertical: SC.from_width(16)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            //
                            Image.asset("assets/icons/camera.png",width: SC.from_width(24),),
                            SizedBox(height: SC.from_width(4),),
                            //
                            Text("Upload your front adhaar image",
                              textAlign: TextAlign.center,
                              style: Const.font_400_12(context),)
                          ],
                        ),
                      ),
                    ),
                  ),
                )),
                SizedBox(height: SC.from_width(19),),

                Expanded(child: GestureDetector(
                  onTap: ()=>pickBackImage(),
                  child: Card(
                    clipBehavior: Clip.hardEdge,
                    child: DottedBorder(

                      borderType: BorderType.RRect,
                      radius: Radius.circular(8),
                      color: Colors.white,
                      dashPattern: [10,10],
                      child: (_adhartBack!=null)?
                          Image.file(File(_adhartBack!))
                          : Padding(
                          padding:  EdgeInsets.symmetric(horizontal: SC.from_width(24),vertical: SC.from_width(16)),
                            child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                            //
                            Image.asset("assets/icons/camera.png",width: SC.from_width(24),),
                            SizedBox(height: SC.from_width(4),),
                            //
                            Text("Upload your back adhaar image",
                              textAlign: TextAlign.center,
                              style: Const.font_400_12(context),),

                                                    ],
                                                  ),
                          ),
                    ),
                  ),
                )),

              ],),),



              SizedBox(height: SC.from_width(50),),

              CustomActionButton(action: ()=>submitKYC(),lable: 'Submit for verification',),
              SizedBox(height: SC.from_width(20),),




            ],
          ),
        ),
      ),
    );
  }
}
