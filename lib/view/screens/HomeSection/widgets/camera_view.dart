import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mimicon/core/constant/image_constants.dart';

class CameraView extends StatelessWidget {
  const CameraView({
    super.key,
    required this.controller,
    required this.cameraTap,
    required this.galleryTap,
    required this.rotateTap,
  });

  final CameraController controller;
  final GestureTapCallback cameraTap;
  final GestureTapCallback galleryTap;
  final GestureTapCallback rotateTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.sizeOf(context).height * .6,
          width: double.maxFinite,
          child: CameraPreview(controller),
        ),
        SizedBox(height: MediaQuery.sizeOf(context).height * .03),
        InkWell(
          onTap: cameraTap,
          borderRadius: BorderRadius.circular(200),
          child: SvgPicture.asset(ImageConstant.camera).marginAll(8),
        ),
        SizedBox(height: MediaQuery.sizeOf(context).height * .08),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: galleryTap,
              borderRadius: BorderRadius.circular(20),
              child: SvgPicture.asset(ImageConstant.gallery).marginAll(5),
            ),
            InkWell(
              onTap: rotateTap,
              borderRadius: BorderRadius.circular(20),
              child: SvgPicture.asset(ImageConstant.rotate).marginAll(5),
            ),
          ],
        ).paddingSymmetric(horizontal: 19),
      ],
    );
  }
}
