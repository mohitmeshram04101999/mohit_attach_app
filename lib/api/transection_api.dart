import 'dart:convert';
import 'dart:ui';

import 'package:attach/api/apiPath.dart';
import 'package:attach/api/authAPi.dart';
import 'package:attach/api/local_db.dart';
import 'package:http/http.dart' as http;

class TransectionApi{

  Future<http.Response> getAllTransection(int page) async
  {

    var uri = PathApi.getAllTransection(DB.curruntUser?.id??'');
    var head = await DB().getFormHeader();
    var resp = await http.get(Uri.parse(uri),headers: head);

    respPrinter(uri,resp);

    return resp;

  }



  Future<http.Response> createTransection({
    required int amount,
    required String type,
    String? debitToUserId,
    String? bankId,
}) async
  {

    var uri = PathApi.baseUri+PathApi.createTransection;
    var head = await DB().getRowHeader();
    var resp = await http.post(Uri.parse(uri),headers: head,
    body: jsonEncode({
      "userId":DB.curruntUser?.id,
      "amount":amount ,
      "Type":type, // choose one - "DEBIT", "CREDIT"
      "debitToUserId":"68242da7ffe8498ac0eb8edd", // if type is debit debit user id is required
      "bankId":"68272c556b21210b23ebb3f0" // this field only for DEBIT TYPE (if you select Type: DEBIT then this field is required)
    }));

    respPrinter(uri,resp);

    return resp;

  }





 }