import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../images/appImages.dart';

class MapServices {
  static Future<Uint8List> getMarkerImage(BuildContext context) async {
    ByteData byteData =
        await DefaultAssetBundle.of(context).load(AppImages.userMarkerIcon);
    return byteData.buffer.asUint8List();
  }
 static Future<Uint8List> getMarkerWithSizeandWithoutContedt(int width) async {
    ByteData data = await rootBundle.load(AppImages.userMarkerIcon);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }


  static Future<Uint8List> getMarkerWithSize(int width) async {
    ByteData data = await rootBundle.load(AppImages.parkingMarkerIcon);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  static Future<Uint8List> getMarkerWithSize1(int width) async {
    ByteData data = await rootBundle.load(AppImages.userMarkerIcon);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  static Future<Uint8List> getMarkerWithSize2(int width) async {
    ByteData data = await rootBundle.load("assets/images/b.png");
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }
}
