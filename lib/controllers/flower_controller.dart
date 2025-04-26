import 'package:get/get.dart';
import 'package:camera/camera.dart';

class FlowerController extends GetxController {
  List<CameraDescription> cameras = [];
  final List<String> shapeImagePaths = const [
    'assets/icon/abstract.png',
    'assets/icon/abstract1.png',
    'assets/icon/badge.png',
    'assets/icon/bookmark.png',
    'assets/icon/crownb0.png',
    'assets/icon/diamond.png',
    'assets/icon/education.png',
    'assets/icon/geometrical.png',
    'assets/icon/heart.png',
    'assets/icon/shapes.png',
    'assets/icon/star.png',
    // Add more if needed...
  ];

  @override
  void onInit() {
    super.onInit();
    _initializeCameras();
  }

  Future<void> _initializeCameras() async {
    try {
      cameras = await availableCameras();
      update();
    } catch (e) {
      print("Error initializing cameras: $e");
    }
  }
}
