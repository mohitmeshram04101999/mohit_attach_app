import 'dart:convert';

import 'package:attach/api/apiPath.dart';
import 'package:attach/api/authAPi.dart';
import 'package:attach/api/local_db.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';


class BankApi{


  Future<http.Response> addBank({
    String? fullName,
    String? bankName,
    String? ifscCode,
    String? type,
    String? accountNumber,
    String? upiId,
})async
  {

    var uri  = '${PathApi.baseUri}${PathApi.addBank}';
    var head =  await DB().getRowHeader();

    var d = {
      "fullName":fullName,
      "bankName":bankName,
      "ifscCode":ifscCode,
      "type":type, // choose one - "BANK", "UPI"
      "accountNumber":accountNumber,
       "upiId":upiId,
      "userId":DB.curruntUser?.id
    };

    var fData = {};

    d.forEach((key, value) {
      fData[key] = value;
    },);

    Logger().i(d);



    var resp =  await http.post(Uri.parse(uri),
    body: jsonEncode(fData),
    headers: head );

    respPrinter(uri, resp);

    return resp;

  }


  getBankDetail()
  {

  }


  getBankAccounts() async
  {
    String uri = PathApi.baseUri+PathApi.getAllBank(DB.curruntUser?.id??'');
    var head = await DB().getFormHeader();
    var resp = await http.get(Uri.parse(uri),headers: head);
    respPrinter(uri, resp);
    return resp;
  }

  deleteAccount()
  {}


  updateAccount()
  {

  }



}