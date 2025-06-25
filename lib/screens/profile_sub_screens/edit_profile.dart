import 'package:attach/componant/BackButton.dart';
import 'package:attach/componant/coustom_text_field.dart';
import 'package:attach/componant/custom_check_box.dart';
import 'package:attach/componant/custome_action_button.dart';
import 'package:attach/componant/laguage_grid_tile.dart';
import 'package:attach/componant/profile_aVTAR.dart';
import 'package:attach/const/app_constante.dart';
import 'package:attach/modles/all_language_responce_model.dart';
import 'package:attach/myfile/screen_dimension.dart';
import 'package:attach/providers/language_provider.dart';
import 'package:attach/providers/profileProvider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ProfileProvider>(context, listen: false).onEditMode(context);
    });

  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder:
          (context, p, child) => WillPopScope(
            onWillPop: () async {
              p.clearEdit(context);
              return true;
            },
            child: Scaffold(
              appBar: AppBar(title: Text('Edit Profile')),

              body: ListView(
                padding: EdgeInsets.symmetric(horizontal: 14, vertical: 20),
                children: [

                  if(kDebugMode)
                    Column(
                      children: [
                        for(Language i in p.user?.languages??[])
                          Text("${i.toJson()}")
                      ],
                    ),

                  Center(
                    child: GestureDetector(
                      onTap: () {
                        p.selectProfileImage(context);
                      },
                      child: ProfileAvtar(
                        image: p.selectedProfile ?? p.user?.image,
                        imageType:
                            (p.selectedProfile != null)
                                ? ImageType.file
                                : ImageType.network,
                      ),
                    ),
                  ),
                  SizedBox(height: SC.from_width(10)),

                  Center(
                    child: Text(
                      "Change profile picture",
                      style: Const.font_700_16(context, color: Const.yellow),
                    ),
                  ),
                  SizedBox(height: SC.from_width(10)),

                  //
                  CustomTextField(
                    controller: p.nameController,
                    label: 'Full Name',
                  ),
                  SizedBox(height: SC.from_width(20)),

                  //
                  Text("Gender", style: TextStyle()),
                  SizedBox(height: SC.from_width(10)),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.white),
                    ),
                    child: Column(
                      children: [
                        //male
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 14),
                          title: Text('Male'),
                          trailing: CustomCheckBox(
                            borderColor: Colors.transparent,
                            value: p.gender == 'MALE',
                            onChange: (d) {
                              p.setGender('MALE');
                            },
                          ),

                          onTap: () {
                            p.setGender("MALE");
                          },
                        ),
                        Divider(endIndent: 8, indent: 8, height: 0),

                        //female
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 14),
                          title: Text('Female'),
                          trailing: CustomCheckBox(
                            borderColor: Colors.transparent,
                            value: p.gender == 'FEMALE',
                            onChange: (d) {
                              p.setGender("FEMALE");
                            },
                          ),
                          onTap: () {
                            p.setGender("FEMALE");
                          },
                        ),
                        Divider(endIndent: 8, indent: 8, height: 0),

                        //other
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 14),
                          title: Text('Other'),
                          trailing: CustomCheckBox(
                            borderColor: Colors.transparent,
                            value: p.gender == 'OTHER',
                            onChange: (d) {
                              p.setGender("OTHER");
                            },
                          ),
                          onTap: () {
                            p.setGender('OTHER');
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: SC.from_width(20)),

                  Text("Languages", style: Const.font_400_14(context)),
                  SizedBox(height: SC.from_width(10)),
                  //
                  Consumer<LanguageProvider>(
                    builder: (context, p, child) {
                      if (p.loading) {
                        return AspectRatio(
                          aspectRatio: 1,
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }
                      


                      return Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: List.generate(
                          p.allLanguage.length,
                              (index) => SizedBox(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                // color: p.isSelected(p.allLanguage[index])?Const.yellow:Colors.white,
                                border: Border.all(
                                  color:
                                  p.isSelected(p.allLanguage[index])
                                      ? Const.yellow
                                      : Colors.white,
                                ),
                              ),
                              child: InkWell(
                                onTap: () {
                                  p.selectLanguage(p.allLanguage[index]);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 14,
                                    vertical: 8,
                                  ),
                                  child: Text(
                                    p.allLanguage[index].name ?? '',
                                    style: Const.font_500_14(
                                      context,
                                      color:
                                      p.isSelected(p.allLanguage[index])
                                          ? Const.yellow
                                          : Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: SC.from_width(20)),

                  //
                  CustomTextField(
                      controller: p.bioController,
                      maxLine: 8, label: 'Enter your bio'),
                  SizedBox(height: SC.from_width(20)),

                  CustomActionButton(
                    action: () async {
                      await p.updateProfile(context);

                    },
                    lable: 'Save',
                  ),
                  
                  
                  // if(kDebugMode)
                  //   Text("${p.user?.toJson()}")
                  
                ],
              ),
            ),
          ),
    );
  }
}
