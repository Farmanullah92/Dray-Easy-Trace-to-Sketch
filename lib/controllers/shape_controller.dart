import 'package:camera/camera.dart';
import 'package:get/get.dart';

class ShapeController extends GetxController {
  List<CameraDescription> cameras = [];
  RxBool isLoading = false.obs;

  final List<String> shapeImagePaths = [
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
  ];

  @override
  void onInit() {
    super.onInit();
    _initializeCameras();
  }

  Future<void> _initializeCameras() async {
    try {
      cameras = await availableCameras();
      update(); // Update UI if needed
    } catch (e) {
      // ignore: avoid_print
      print("Error initializing cameras: $e");
    }
  }

  Future<void> processShapeSelection({
    required String imagePath,
    required Function onNavigate,
  }) async {
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 2));
    isLoading.value = false;

    if (cameras.isNotEmpty) {
      onNavigate(cameras, imagePath);
    } else {
      // ignore: avoid_print
      print("No cameras available");
    }
  }
}
