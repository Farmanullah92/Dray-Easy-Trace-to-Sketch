import 'package:draw_easy/views/screens/camera/photo_preview_screen.dart';
import 'package:draw_easy/widgets/app_dialog.dart';
import 'package:camera/camera.dart';
import 'package:get/get.dart';

class HolidayController extends GetxController {
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
  ];

  final RxList<CameraDescription> cameras = <CameraDescription>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _initializeCameras();
  }

  Future<void> _initializeCameras() async {
    try {
      isLoading(true);
      final detectedCameras = await availableCameras();
      cameras.assignAll(detectedCameras);
    } catch (e) {
      Get.snackbar('Error', 'Failed to initialize cameras: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> selectShape(String imagePath) async {
    isLoading(true);

    // Show processing dialog
    Get.dialog(
      AppDialog(
        title: 'Please wait...',
        imagePath: 'assets/images/hind.png',
        imageHeight: 200,
      ),
      barrierDismissible: false,
    );

    await Future.delayed(const Duration(seconds: 2));

    if (cameras.isNotEmpty) {
      Get.back(); // Close the dialog
      Get.to(
        () => PhotoPreviewScreen(
          imagePath: imagePath,
          cameras: cameras,
          isAssetImage: true,
        ),
      );
    } else {
      Get.back(); // Close the dialog
      Get.snackbar('Error', 'No cameras available');
    }

    isLoading(false);
  }
}
