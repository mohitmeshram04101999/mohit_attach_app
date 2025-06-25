import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:attach/api/apiPath.dart';
import 'package:attach/api/authAPi.dart';
import 'package:attach/api/local_db.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class StoryApi
{

  Future<http.Response> uploadStory({
    required String filePath,
    required bool video,
    required void Function(double progress)? onProgress,

})
  async {

    String uri = PathApi.baseUri+PathApi.createStory;

    var head = await DB().getFormHeader();





    var file = File(filePath);
    final length = await file.length();
    int bytesSent = 0;

    final  stream = http.ByteStream(file.openRead().transform(
      StreamTransformer.fromHandlers(
        handleData: (data, sink) {
          bytesSent += data.length;
          if(onProgress!=null) {
              onProgress(bytesSent / length);

          }
          sink.add(data);
        },
      ),
    ));

    var req = http.MultipartRequest("POST",Uri.parse(uri));

    req.headers.addAll(head);

    req.fields.addAll({'listenerId':DB.curruntUser?.id??''});


    final multipartFile = http.MultipartFile(
      (video)?'video':'image',
      stream,
      length,
      filename: file.path.split("/").last,
    );
    req.files.add(await multipartFile);




      var sResp = await req.send();

      var resp = http.Response(await sResp.stream.bytesToString(),sResp.statusCode);
      respPrinter(uri, resp);

      return resp;
  }



  Future<http.Response> uploadStoryImageBytes({
    required Uint8List imageBite,
    // required void Function(double progress)? onProgress,

  })
  async {

    String uri = PathApi.baseUri+PathApi.createStory;

    var head = await DB().getFormHeader();




    var req = http.MultipartRequest("POST",Uri.parse(uri));

    req.headers.addAll(head);

    req.fields.addAll({'listenerId':DB.curruntUser?.id??''});

    req.files.add(http.MultipartFile.fromBytes(
      'image', // Your API field name
      imageBite,
      filename: 'captured_image.png',
      contentType: MediaType('image', 'png'), // Use MediaType here
    ));

    var sResp = await req.send();

    var resp = http.Response(await sResp.stream.bytesToString(),sResp.statusCode);
    respPrinter(uri, resp);

    return resp;
  }






  Future<http.Response> seenStory({
    required String storyId,
     bool isLike =false
}) async
  {

    String uri = PathApi.baseUri+PathApi.seenStory;
    
    
    var resp = await http.post(Uri.parse(uri),
      headers: await DB().getRowHeader(),
      body: jsonEncode({
        "storyId":storyId,
        "userId":DB.curruntUser?.id??'',
        "like":isLike
      }),
    );
    respPrinter(uri, resp);
    return resp;

  }


  Future<http.Response> replyStory({
    required String storyId,
    required String listenerId,
    required String message,
  }) async
  {

    String uri = PathApi.baseUri+PathApi.seenStory;


    var resp = await http.post(Uri.parse(uri),
      headers: await DB().getRowHeader(),
      body: jsonEncode({
        "userId":DB.curruntUser?.id??'',
        "listenerId":listenerId,
        "storyId":storyId,
        "message":message
      }),
    );
    respPrinter(uri, resp);
    return resp;

  }


  Future<http.Response> deleteStory({
    required String storyId,
  }) async
  {

    String uri = PathApi.baseUri+PathApi.deleteStory(storyId);


    var resp = await http.delete(Uri.parse(uri),
      headers: await DB().getRowHeader(),);
    respPrinter(uri, resp);
    return resp;
  }


}