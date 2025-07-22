import 'dart:async';
import 'dart:io';

import 'package:attach/api/apiPath.dart';
import 'package:attach/api/authAPi.dart';
import 'package:attach/api/local_db.dart';
import 'package:http/http.dart'as http;


class MediaApi{
  
  
  
   Future<http.Response>sendMediaInMessage(
       String filePath,Function(double) onProgress) async
  {
    String uri = PathApi.baseUri+'createMessageImage';

    final file = File(filePath);
    final fileLength = await file.length();

    int bytesSent = 0;

    final stream = http.ByteStream(file.openRead().transform(
      StreamTransformer.fromHandlers(
        handleData: (data, sink) {
          bytesSent += data.length;
          onProgress(bytesSent / fileLength);
          sink.add(data);
        },
      ),
    ));
    
    var req = http.MultipartRequest('POST',Uri.parse(uri));

    req.headers.addAll(await DB().getFormHeader());
    
    req.files.add(http.MultipartFile(
      'media',
      stream,
      fileLength,
      filename: filePath.split('/').last
    ));

    var Sresp = await req.send();

    var resp = http.Response(await Sresp.stream.bytesToString(),Sresp.statusCode);

    respPrinter(uri, resp);

    return resp;
    
  }




  
}