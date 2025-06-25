import 'dart:convert';

import 'package:attach/api/authAPi.dart';
import 'package:attach/modles/all_language_responce_model.dart';
import 'package:attach/providers/my_hleper.dart';
import 'package:flutter/cupertino.dart';

class LanguageProvider with ChangeNotifier
{

  List<Language> _allLanguage = [];
  List<Language> _selectedLanguage = [];
  bool _loading = true;

  bool get loading =>_loading;

  List<Language> get allLanguage => _allLanguage;
  List<Language> get selectedLanguage => _selectedLanguage;



  clear()
  {
    _loading = true;
    _allLanguage = [];
    _selectedLanguage = [];
  }

  bool isSelected(Language l)
  {
    bool selected = false;
    _selectedLanguage.forEach((d){
      if(d.id==l.id)
        {
          selected = true;
        }
    });
    return selected;
  }

  selectLanguage(Language language)
  {
    if(isSelected(language))
      {
        print("the language is already selected");
        _selectedLanguage.removeWhere((element) => element.id==language.id,);
      }
    else
      {
        print("the language is not selected so add it");
        _selectedLanguage.add(language);
      }
    notifyListeners();
  }

  getAllLanguage(BuildContext context) async
  {

    var resp = await AuthApi().getAllLanguage();

    switch(resp.statusCode)
    {

      case 200:
        var d = jsonDecode(resp.body);
        AllLanguageResponceModel allLanguageResponceModel = AllLanguageResponceModel.fromJson(d);
        if(allLanguageResponceModel.data!.isNotEmpty)
          {
            _allLanguage = allLanguageResponceModel.data??[];
          }
        break;

      case 400:
        MyHelper.snakeBar(context, title: "Bad Request", message: '${jsonDecode(resp.body)['message']}');
        break;

      case 403:
        MyHelper.snakeBar(context, title: "Restrict from Server", message: '${jsonDecode(resp.body)['message']}');
        break;

      case 401:
        MyHelper.tokenExp(context);
        break;

      case 500:
        MyHelper.serverError(context, resp.body);
        break;

      default:
        MyHelper.serverError(context, '${resp.statusCode}\n${resp.body}',title: 'Exception');
        break;


    }
    _loading = false;
    notifyListeners();

  }



}