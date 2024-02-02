import 'dart:io';

import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mimicon/core/constant/app_constants.dart';
import 'package:mimicon/core/utils/utils.dart';
import 'package:mimicon/main.dart';

class HomeController extends GetxController{
  late CameraController cameraController;

  FaceLandmark? rightEye;
  FaceLandmark? leftEye;
  FaceLandmark? rightMouth;
  FaceLandmark? leftMouth;
  FaceLandmark? bottomMouth;
  RxList<Face> faceDataList = <Face>[].obs;
  RxInt cameraIndex = 1.obs;
  final imagePicker = ImagePicker();
  File? capturedImage;


  void initCamera() {
    cameraController = CameraController(cameras[cameraIndex.value], ResolutionPreset.max);
    cameraController.initialize().then((_) {
      update();
    });
  }

  captureImage() async{
    rightEye = null;
    leftEye = null;
    rightMouth = null;
    leftMouth = null;
    bottomMouth = null;

    final image = await cameraController.takePicture();

    capturedImage = File(image.path);
    update();
    faceDetection(capturedImage!.path);
  }

  getImageFromGallery() async {
    XFile? image = await imagePicker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      capturedImage = File(image.path);
      update();
      faceDetection(capturedImage!.path);
    }
  }


  void faceDetection(String filePath) async{
    final inputImage = InputImage.fromFilePath(filePath);
    final options = FaceDetectorOptions(
      enableContours: true,
      enableLandmarks: true,
    );
    final faceDetector = FaceDetector(options: options);

    faceDataList.value = await faceDetector.processImage(inputImage);
    if(faceDataList.length < 2){
      for (Face face in faceDataList) {
        rightEye = face.landmarks[FaceLandmarkType.rightEye];
        leftEye = face.landmarks[FaceLandmarkType.leftEye];
        rightMouth = face.landmarks[FaceLandmarkType.rightMouth];
        leftMouth = face.landmarks[FaceLandmarkType.leftMouth];
        bottomMouth = face.landmarks[FaceLandmarkType.bottomMouth];

        update();

      }
    }else{
      showFlushbar(text: AppConstant.twoOrMoreTxt, context: Get.context);
    }
  }


  @override
  void onInit() {
    super.onInit();
    initCamera();
  }

  @override
  void onClose() {
    cameraController.dispose();
    super.onClose();
  }

}