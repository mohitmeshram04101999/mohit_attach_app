
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';




Future<Uint8List?> captureAndSave({required GlobalKey key}) async {
  try {
    print("StaRT");
    RenderRepaintBoundary? boundary = key.currentContext!.findRenderObject() as RenderRepaintBoundary?;
    print(boundary);
    if (boundary != null) {
      print("1");
      ui.Image image = await boundary.toImage();
      print("2");
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      print("3");
      if (byteData != null) {
        print("4");
        Uint8List pngBytes = byteData.buffer.asUint8List();
        print("5");
        return pngBytes;
      }
    }
  } catch (e) {
    print('Error capturing and saving image: $e');
  }
}



Future<Uint8List> getImageBytes(String imagePath) async {
  final byteData = await rootBundle.load(imagePath);
  return byteData.buffer.asUint8List();
}