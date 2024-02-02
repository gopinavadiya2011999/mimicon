// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:mimicon/core/constant/app_constants.dart';
import 'package:mimicon/core/constant/color_constant.dart';
import 'package:mimicon/core/constant/image_constants.dart';
import 'package:mimicon/view/screens/PickedImageSection/picked_image_controller.dart';
import 'package:mimicon/view/screens/PickedImageSection/widgets/custom_painter.dart';

class PickedImageScreen extends GetView<PickedImageController> {
  const PickedImageScreen({
    super.key,
    required this.captureImage,
    required this.rightEye,
    required this.leftEye,
    required this.rightMouth,
    required this.onBackTap,
  });

  final File? captureImage;
  final FaceLandmark? rightEye;
  final FaceLandmark? leftEye;
  final FaceLandmark? rightMouth;
  final GestureTapCallback onBackTap;

  @override
  Widget build(BuildContext context) {
    return captureImage != null
        ? Obx(
            () => Column(
              children: [
                RepaintBoundary(
                  key: controller.imageGlobalKey.value,
                  child: Stack(
                    children: [
                      Image.file(
                        captureImage!,
                        fit: BoxFit.fill,
                        height: MediaQuery.sizeOf(context).height * .6,
                        width: double.infinity,
                      ),
                      if (rightEye != null && controller.highlightEye.value)
                        CustomPaint(
                          painter: EyePainter(
                            point: Point((rightEye!.position.x / 4).ceil() + 55,
                                (rightEye!.position.y / 4).ceil() - 10),
                            radius: 20,
                            color: Colors.green.withOpacity(0.5),
                          ),
                        ),
                      if (leftEye != null && controller.highlightEye.value)
                        CustomPaint(
                          painter: EyePainter(
                            point: Point((leftEye!.position.x / 4).ceil() + 35,
                                (leftEye!.position.y / 4).ceil() - 10),
                            radius: 20,
                            color: Colors.green.withOpacity(0.5),
                          ),
                        ),
                      if (rightMouth != null && controller.highlightMouth.value)
                        CustomPaint(
                          painter: MouthPainter(
                            point: Point(
                                (rightMouth!.position.x / 4).ceil() + 20,
                                (rightMouth!.position.y / 4).ceil() - 15),
                            radius: 20,
                            color: Colors.green.withOpacity(0.5),
                          ),
                        ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: onBackTap,
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 5,
                      ),
                      SvgPicture.asset(ImageConstant.backButton),
                      const SizedBox(
                        width: 5,
                      ),
                      const Text(
                        AppConstant.backTxt,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: ColorConstant.white,
                        ),
                      )
                    ],
                  ),
                ).paddingSymmetric(
                  vertical: MediaQuery.of(context).size.height * 0.028,
                  horizontal: 16,
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        controller.highlightEye.value = true;
                        controller.highlightMouth.value = false;
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.071,
                        width: 60,
                        decoration: BoxDecoration(
                          color: ColorConstant.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Center(
                          child: Text(
                            AppConstant.eyesTxt,
                            style: TextStyle(
                              color: ColorConstant.black,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    GestureDetector(
                      onTap: () {
                        controller.highlightMouth.value = true;
                        controller.highlightEye.value = false;
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.071,
                        width: 60,
                        decoration: BoxDecoration(
                          color: ColorConstant.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Center(
                          child: Text(
                            AppConstant.mouthTxt,
                            style: TextStyle(
                              color: ColorConstant.black,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ).paddingSymmetric(horizontal: 16),
                GestureDetector(
                  onTap:
                      !controller.loader.value && !controller.isImageSaved.value
                          ? () => controller.saveImage()
                          : () {},
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.047,
                    margin: const EdgeInsets.all(16),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: !controller.isImageSaved.value
                          ? ColorConstant.purple
                          : ColorConstant.grey,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: !controller.loader.value
                        ? const Text(
                            AppConstant.saveTxt,
                            style: TextStyle(
                              color: ColorConstant.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          )
                        : SizedBox(
                            height: MediaQuery.of(context).size.height * 0.04,
                            width: MediaQuery.of(context).size.height * 0.04,
                            child: const CircularProgressIndicator(
                              color: ColorConstant.white,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          )
        : Container();
  }
}
