import 'dart:convert';

import 'package:attach/api/authAPi.dart';
import 'package:attach/api/listners_Api.dart';
import 'package:attach/api/local_db.dart';
import 'package:attach/bd/bd_call_event_handler.dart';
import 'package:attach/bd/bg_main.dart';
import 'package:attach/componant/logOutDialog.dart';
import 'package:attach/modles/otp_responce.dart';
import 'package:attach/modles/usertype.dart';
import 'package:attach/myfile/animated%20dilog.dart';
import 'package:attach/myfile/myast%20dart%20file.dart';
import 'package:attach/providers/auth_provider.dart';
import 'package:attach/providers/home_provider.dart';
import 'package:attach/providers/language_provider.dart';
import 'package:attach/providers/my_hleper.dart';
import 'package:attach/providers/story_provider.dart';
import 'package:attach/providers/transection_history_provider.dart';
import 'package:attach/screens/dash_board_screen/dash_board_screen.dart';
import 'package:attach/screens/on_bord_screen/login/log_in_screen.dart';
import 'package:attach/screens/on_bord_screen/on_board_main.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class ProfileProvider with ChangeNotifier {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _mail = TextEditingController();
  final TextEditingController _bio = TextEditingController();
  String? _gender;
  User? _user;
  String? _selectedProfileImage;

  String? get gender => _gender;
  String? get selectedProfile => _selectedProfileImage;
  TextEditingController get nameController => _name;
  TextEditingController get mailController => _mail;
  TextEditingController get bioController => _bio;
  User? get user => _user;

  setUser(User user) {
    _user = user;
    notifyListeners();
  }

  clearEdit(BuildContext context) {
    _selectedProfileImage = null;
    _mail.clear();
    _name.clear();
    _gender = null;
    Provider.of<LanguageProvider>(context, listen: false).clear();
    debugPrint("clear Done");
  }

  onEditMode(BuildContext context) async {
    _name.text = _user!.name!;
    _mail.text = _user!.email!;
    _gender = _user?.gender;
    _bio.text = _user?.bio ?? '';
    notifyListeners();

    var p = Provider.of<LanguageProvider>(context, listen: false);
    await p.getAllLanguage(context);
    debugPrint("this is user language ${_user?.languages}");
    debugPrint("this is selected language ${p?.selectedLanguage}");
    _user?.languages?.forEach((element) {
      debugPrint("setting language ${element.toJson()}");
      p.selectLanguage(element);
    });

    debugPrint("data is set fro language ${p.selectedLanguage}");
    notifyListeners();
  }

  goOnlineOrOffline(BuildContext context) async {


    debugPrint("adfd");

    OpenDailogWithAnimation(context,
        barriarDissmesible: false,
        animation: dailogAnimation.scale,
        dailog:(animation, secondryAnimation) => Center(child: CircularProgressIndicator(),));

    print("Dialod is Opne");




    var resp = await AuthApi().goOnlineOfOffline();

    switch (resp.statusCode) {
      case 200:
        var d = jsonDecode(resp.body);
        _user = User.fromJson(d['data']);
        if(_user?.online==true&&user?.userType==UserType.listener)
          {
            await initBgService();
          }
        else
          {
            service.invoke("stop");
          }
        break;
      case 400:
        MyHelper.snakeBar(
          context,
          title: "Bad Request",
          message: '${jsonDecode(resp.body)['message']}',
        );
        break;
      case 403:
        MyHelper.snakeBar(
          context,
          title: "Restrict Request",
          message: '${jsonDecode(resp.body)['message']}',
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
    Navigator.pop(context);
    notifyListeners();
  }

  setAudioVideoAv(BuildContext context, {required bool video}) async {
    debugPrint("adfd");
    var resp = await AuthApi().setAudioVideoOff(video: video);

    switch (resp.statusCode) {
      case 200:
        MyHelper.snakeBar(
          context,
          title: "Status Changed",
          message: '${jsonDecode(resp.body)['message']}',
          type: SnakeBarType.success,
        );
        var d = jsonDecode(resp.body);
        _user = User.fromJson(d['data']);
        break;
      case 400:
        MyHelper.snakeBar(
          context,
          title: "Bad Request",
          message: '${jsonDecode(resp.body)['message']}',
        );
        break;
      case 403:
        MyHelper.snakeBar(
          context,
          title: "Restrict Request",
          message: '${jsonDecode(resp.body)['message']}',
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
    notifyListeners();
  }

  selectProfileImage(BuildContext context) async {
    var d = await Permission.storage.request();
    var v = await Permission.mediaLibrary.request();

    var result = await ImagePicker().pickImage(source: ImageSource.gallery);
    debugPrint("selected image ${result?.path} $d $v");
    if (result != null) {
      _selectedProfileImage = result.path;
      notifyListeners();
    }
  }

  clear() {
    _mail.clear();
    _name.clear();
    _gender = null;
  }

  setGender(String gender) {
    _gender = gender;
    notifyListeners();
  }

  createProfile(BuildContext context) async {
    var auth = Provider.of<AuthProvider>(context, listen: false);
    var languageProvider = Provider.of<LanguageProvider>(
      context,
      listen: false,
    );

    if (languageProvider.selectedLanguage.isEmpty) {
      MyHelper.snakeBar(context, title: "Language", message: "Select Language");
      return;
    }

    var resp = await AuthApi().createProfile(
      mobileNumber: auth.phoneNumberController.text.trim(),
      fullName: _name.text.trim(),
      mail: _mail.text.trim(),
      gender: gender!,
      language:
          languageProvider.selectedLanguage
              .map((e) => e.id.toString())
              .toList(),
    );

    switch (resp.statusCode) {
      case 200:
        var d = jsonDecode(resp.body);
        VerifyOtpResponceModel model = VerifyOtpResponceModel.fromJson(d);
        _user = model.data;
        MyHelper.snakeBar(
          context,
          title: 'Profile has been created',
          message: "Welcome ${_user?.name ?? ''}",
          type: SnakeBarType.success,
        );
        await saveUser();
        auth.clear();
        languageProvider.clear();
        _name.clear();
        _mail.clear();
        _gender = null;
        ReplaceAll(context, child: (p0, p1) => DashBoardScreen());
        break;
      case 400:
        MyHelper.snakeBar(
          context,
          title: "Bad Request",
          message: '${jsonDecode(resp.body)['message']}',
        );
        break;
      case 403:
        MyHelper.snakeBar(
          context,
          title: "Restrict Request",
          message: '${jsonDecode(resp.body)['message']}',
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
  }

  logOut(BuildContext context) async {
    var p = await OpenDailogWithAnimation(
      context,
      barriarDissmesible: false,
      duration: const Duration(milliseconds: 300),
      dailog:
          (animation, secondryAnimation) => WillPopScope(
            onWillPop: () async => false,
            child: const LogOutDialog(),
          ),
    );

    if (p == true) {
      try {
        var resp = await AuthApi().logOut(userId: DB.curruntUser?.id ?? '');

        switch (resp.statusCode) {
          case 200:




            service.invoke('stop');

            // Then clear data and navigate
            await DB().clear();
            Provider.of<Socket_Provider>(
              context,
              listen: false,
            ).disconnectSocket(context);
            Provider.of<StoryProvider>(context, listen: false).clear();
            Provider.of<TransectionHistoryProvider>(
              context,
              listen: false,
            ).clear();
            ReplaceAll(context, child: (p0, p1) => const LogInScreen());

            MyHelper.snakeBar(
              context,
              title: "Logout",
              message: "Logout Successfully",
              type: SnakeBarType.success,
            );
            break;
          case 400:
            MyHelper.snakeBar(
              context,
              title: "Bad Request",
              message: '${jsonDecode(resp.body)['message']}',
            );
            break;
          case 403:
            MyHelper.snakeBar(
              context,
              title: "Restrict Request",
              message: '${jsonDecode(resp.body)['message']}',
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
      } catch (e) {
        Logger().e("Error during logout: $e");
        MyHelper.snakeBar(
          context,
          title: "Error",
          message: "Failed to logout properly",
          type: SnakeBarType.error,
        );
      }
    }
  }

  _getProfileDetail(BuildContext context, String userId) async {
    var resp = await AuthApi().getUser();

    switch (resp.statusCode) {
      case 200:
        var d = jsonDecode(resp.body);
        var _d = User.fromJson(d['data']);
        _user = _d;
        break;
      case 400:
        MyHelper.snakeBar(
          context,
          title: 'Bad Request',
          message: '${jsonDecode(resp.body)['message']}',
          type: SnakeBarType.error,
        );
        break;
      case 403:
        MyHelper.snakeBar(
          context,
          title: 'Denied',
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
    notifyListeners();
  }

  getUser(BuildContext context) async {
    var u = await DB().getUser();
    if (u != null) {
      await _getProfileDetail(context, u.id ?? '');
      notifyListeners();
    }
  }

  checkUserLogIn(BuildContext context, ReceivedAction? action) async {
    if (await DB().isFirstTimer()) {
      ReplaceTo(context, child: (p0, p1) => const OnBoardMain());
      return;
    }
    await getUser(context);
    if (_user == null) {
      ReplaceTo(context, child: (p0, p1) => const LogInScreen());
    } else {
      ReplaceTo(context, child: (p0, p1) => DashBoardScreen(action: action));
    }
  }

  setAndSaveUser(User user) {
    _user = user;
    saveUser();
  }

  saveUser() async {
    if (_user != null) {
      await DB().saveUser(user!);
    }
  }

  updateProfile(BuildContext context) async {
    if (_name.text.trim().isEmpty) {
      MyHelper.snakeBar(
        context,
        title: "Name Is Required",
        message: "Provide Name",
        type: SnakeBarType.error,
      );
      return;
    }
    var lang = Provider.of<LanguageProvider>(context, listen: false);

    var resp = await AuthApi().updateUser(
      user?.id ?? '',
      name: _name.text.trim(),
      bio: _bio.text.trim(),
      languages:
          lang.selectedLanguage.isEmpty
              ? null
              : lang.selectedLanguage.map((e) => e.id ?? '').toList(),
      gender: _gender,
      profileImage: _selectedProfileImage,
    );

    print('this is responcse from update api ${resp.statusCode}');

    switch (resp.statusCode) {
      case 200:
        String t = DB.curruntUser?.token ?? '';
        await _getProfileDetail(context, _user?.id ?? '');
        Map<String, dynamic> userMap = _user?.toJson() ?? {};
        userMap['token'] = t;
        _user = User.fromJson(userMap);
        await saveUser();
        notifyListeners();
        Navigator.of(context).pop();
        clearEdit(context);
        break;

      case 400:
        MyHelper.snakeBar(
          context,
          title: "Bad Request",
          message: '${jsonDecode(resp.body)['message']}',
        );
        break;
      case 403:
        MyHelper.snakeBar(
          context,
          title: "Restrict Request",
          message: '${jsonDecode(resp.body)['message']}',
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
  }

  getProfile(BuildContext context) async {
    var resp = await AuthApi().getUser();

    switch (resp.statusCode) {
      case 200:
        var d = jsonDecode(await resp.body);
        _user = User.fromJson(d['data']);
        break;
      case 400:
        MyHelper.snakeBar(
          context,
          title: "Bad Request",
          message: '${jsonDecode(resp.body)['message']}',
        );
        break;
      case 403:
        MyHelper.snakeBar(
          context,
          title: "Restrict Request",
          message: '${jsonDecode(resp.body)['message']}',
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
    notifyListeners();
  }
}
