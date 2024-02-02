import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mimicon/core/constant/color_constant.dart';
import 'package:mimicon/view/screens/HomeSection/widgets/camera_view.dart';
import 'package:mimicon/view/screens/HomeSection/home_controller.dart';
import 'package:mimicon/view/screens/PickedImageSection/picked_image_controller.dart';
import 'package:mimicon/view/screens/PickedImageSection/picked_image_screen.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: ColorConstant.black,
          appBar: AppBar(
            backgroundColor: ColorConstant.black,
            leading: IconButton(
              icon: const Icon(
                Icons.close,
                color: ColorConstant.white,
              ),
              onPressed: () {
                if (controller.capturedImage != null) {
                  controller.capturedImage = null;
                  controller.update();
                }
                Get.find<PickedImageController>().loader.value = false;
                Get.find<PickedImageController>().isImageSaved.value = false;
                Get.find<PickedImageController>().highlightEye.value = false;
                Get.find<PickedImageController>().highlightMouth.value = false;
              },
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.more_vert_rounded,
                  color: ColorConstant.white,
                ),
              ),
            ],
          ),
          body: controller.capturedImage != null
              ? PickedImageScreen(
                  leftEye: controller.leftEye,
                  captureImage: controller.capturedImage,
                  rightEye: controller.rightEye,
                  rightMouth: controller.rightMouth,
                  onBackTap: () {
                    if (controller.capturedImage != null) {
                      controller.capturedImage = null;
                      controller.update();
                    }
                  },
                )
              : CameraView(
                  controller: controller.cameraController,
                  cameraTap: controller.captureImage,
                  galleryTap: controller.getImageFromGallery,
                  rotateTap: () {
                    controller.cameraIndex.value = controller.cameraIndex.value == 1 ? 0 : 1;
                    controller.update();
                    controller.initCamera();
                  },
                ),
        );
      },
    );
  }
}
