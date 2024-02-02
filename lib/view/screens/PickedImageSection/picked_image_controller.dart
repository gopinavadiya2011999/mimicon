import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:mimicon/core/constant/app_constants.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:mimicon/core/utils/utils.dart';
import 'package:path_provider/path_provider.dart';

class PickedImageController extends GetxController {
  RxBool highlightEye = false.obs;
  RxBool highlightMouth = false.obs;
  RxBool loader = false.obs;
  RxBool isImageSaved = false.obs;
  Rx<GlobalKey> imageGlobalKey = GlobalKey().obs;

  saveImage() async {
    loader.value = true;

    RenderRepaintBoundary boundary = imageGlobalKey.value.currentContext!
        .findRenderObject() as RenderRepaintBoundary;

    ui.Image image = await boundary.toImage(pixelRatio: 6);

    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);

    var pngBytes = byteData!.buffer.asUint8List();

    var bs64 = base64Encode(pngBytes);

    await createImage(base64: bs64);
  }

  createImage({required String base64}) async {
    final encodedStr = base64;
    Uint8List bytes = base64Decode(encodedStr);

    String path = "";

    if (Platform.isIOS) {
      Directory dir = await getApplicationSupportDirectory();
      path = dir.path;
    } else if (Platform.isAndroid) {
      Directory dir = await getTemporaryDirectory();

      path = dir.path;
    }

    File file = File("$path/${DateTime.now().millisecondsSinceEpoch}.png");

    await file.writeAsBytes(bytes);
    await ImageGallerySaver.saveImage(file.readAsBytesSync(), quality: 100, name: "${DateTime.now().millisecondsSinceEpoch}.png");
    if (file.path.isNotEmpty) {
      loader.value = false;
      isImageSaved.value = true;

      showFlushbar(
        text: AppConstant.imageSavedTxt,
        context: Get.context,
      );
    }
  }
}
