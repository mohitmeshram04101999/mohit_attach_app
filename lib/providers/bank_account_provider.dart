import 'dart:convert';
import 'dart:developer';

import 'package:attach/api/bankpai/bankeApi.dart';
import 'package:attach/modles/get_All_Bank.dart';
import 'package:attach/providers/my_hleper.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';




class BankProvider with ChangeNotifier
{

  var _typs = ["BANK", "UPI"];

  final TextEditingController _holderName = TextEditingController();
  final TextEditingController _bankName = TextEditingController();
  final TextEditingController _ifscCode = TextEditingController();
  final TextEditingController _upiId = TextEditingController();
  final TextEditingController _bankAccountNumber = TextEditingController();
  String _accountType = 'BANK';
  List<TransectionAccount> _account =[];
  bool _loading = true;

  TransectionAccount? _selectedAccount;


  TransectionAccount? get selectedAccount => _selectedAccount;



   TextEditingController  get holderName => _holderName;
   TextEditingController  get bankName => _bankName;
   TextEditingController  get ifscCode => _ifscCode;
   TextEditingController  get upiId => _upiId;
  TextEditingController get bankAccountNumber => _bankAccountNumber;
  String get accountType => _accountType;
  bool get loading => _loading;
  List<TransectionAccount> get account=>_account;



  setBank(TransectionAccount account)
  {
    _selectedAccount = account;
    notifyListeners();
  }


  clear()
  {
    _accountType = 'BANK';
    _holderName.clear();
    _bankName.clear();
    _ifscCode.clear();
    _bankAccountNumber.clear();
    _upiId.clear();
  }


  setAccountType(String type)
  {
    _accountType = type;
    notifyListeners();
  }


  addAccount(BuildContext context) async
  {

    Response resp;

    if(_accountType=='BANK')
      {
        if(_holderName.text.trim().isEmpty||_bankAccountNumber.text.trim().isEmpty||_ifscCode.text.trim().isEmpty||_bankName.text.trim().isEmpty)
          {
            MyHelper.snakeBar(context, title: 'Incomplete Bank Detail', message: 'Provide Your Bank Detail');
            return ;
          }
      }
    else
      {
        if(_upiId.text.trim().isEmpty)
          {
            MyHelper.snakeBar(context, title: 'UPI', message: 'Enter Your Upi Id');
            return;
          }
      }

    if(_accountType=='BANK')
      {

        resp =  await BankApi().addBank(
          bankName: _bankName.text.trim(),
          fullName: _holderName.text.trim(),
          accountNumber: _bankAccountNumber.text.trim(),
          ifscCode: _ifscCode.text.trim(),
          type: accountType
        );
      }
    else
      {
        resp =  await BankApi().addBank(
          upiId: _upiId.text.trim(),
            type: accountType,
        );
      }



    switch(resp.statusCode)
    {
      case 201:
        clear();
        var d = jsonDecode(resp.body);
        var account  =  TransectionAccount.fromJson(d['data']);
        _account.insert(0,account);
        notifyListeners();
        Navigator.pop(context);
        break;

      case 400:
        MyHelper.snakeBar(context,title: 'Verify Otp',message: '${jsonDecode(resp.body)['message']}',type: SnakeBarType.error);
        break;

      case 403:
        MyHelper.snakeBar(context,title: 'Verify Otp',message: '${jsonDecode(resp.body)['message']}',type: SnakeBarType.error);
        break;


      case 409:
        MyHelper.snakeBar(context,title: 'Bank Can not Add  ',message: '${jsonDecode(resp.body)['message']}',type: SnakeBarType.error);
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

  }

  getAllAccount(BuildContext context) async
  {
    log("Calling for get Account");

    Response resp = await BankApi().getBankAccounts();

    switch(resp.statusCode)
    {
      case 200:
        var d = jsonDecode(resp.body);
        GetAllBankResponceModel data = GetAllBankResponceModel.fromJson(d);
        if(data.data!=null&&data.data!.isNotEmpty)
          {
            _account = data.data??[];
            _selectedAccount ??= _account[0];
          }

        break;

      case 400:
        MyHelper.snakeBar(context,title: 'Problem',message: '${jsonDecode(resp.body)['message']}',type: SnakeBarType.error);
        break;

      case 403:
        MyHelper.snakeBar(context,title: 'Problem',message: '${jsonDecode(resp.body)['message']}',type: SnakeBarType.error);
        break;


      case 409:
        MyHelper.snakeBar(context,title: 'Bank Can not Add  ',message: '${jsonDecode(resp.body)['message']}',type: SnakeBarType.error);
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