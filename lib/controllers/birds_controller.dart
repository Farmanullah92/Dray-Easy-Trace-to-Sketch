import 'package:camera/camera.dart';
import 'package:draw_easy/views/screens/camera/photo_preview_screen.dart';
import 'package:get/get.dart';

class BirdsController extends GetxController {
  late List<CameraDescription> cameras;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _initializeCameras();
  }

  Future<void> _initializeCameras() async {
    try {
      isLoading(true);
      cameras = await availableCameras();
    } catch (e) {
      Get.snackbar("Error", "Error initializing cameras: $e");
    } finally {
      isLoading(false);
    }
  }

  void navigateToPhotoPreview(String imagePath) {
    if (cameras.isEmpty) {
      Get.snackbar("Error", "No cameras available");
      return;
    }

    Get.to(
      () => PhotoPreviewScreen(
        imagePath: imagePath,
        cameras: cameras,
        isAssetImage: true,
      ),
    );
  }
}
