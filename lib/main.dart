import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mimicon/view/screens/HomeSection/home_controller.dart';
import 'package:mimicon/view/screens/HomeSection/home_screen.dart';
import 'package:mimicon/view/screens/PickedImageSection/picked_image_controller.dart';

late List<CameraDescription> cameras;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  cameras = await availableCameras();
  initController();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

void initController(){
  Get.lazyPut(() => HomeController());
  Get.lazyPut(() => PickedImageController());
}
