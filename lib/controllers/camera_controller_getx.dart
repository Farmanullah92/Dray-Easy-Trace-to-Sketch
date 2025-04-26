import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:draw_easy/widgets/app_dialog.dart';
import 'package:draw_easy/views/screens/camera/photo_preview_screen.dart';
import 'package:draw_easy/views/screens/camera/camera_service.dart';

class CameraControllerGetX extends GetxController {
  final CameraService _cameraService = CameraService();

  var isLoading = false.obs;
  var isCameraInitialized = false.obs;

  CameraController? get controller => _cameraService.controller;
  bool get isFlashOn => _cameraService.isFlashOn;
  List<CameraDescription>? get cameras => _cameraService.cameras;

  @override
  void onInit() {
    super.onInit();
    initializeCamera();
  }

  Future<void> initializeCamera() async {
    try {
      await _cameraService.initializeCamera();
      isCameraInitialized.value = true;
    } catch (e) {
      debugPrint('Camera initialization error: $e');
      Get.snackbar(
        'Error',
        'Camera error: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> toggleFlash() async {
    await _cameraService.toggleFlash();
    update(); // To update the flash icon
  }

  Future<void> switchCamera() async {
    await _cameraService.switchCamera();
    update(); // To update the UI
  }

  Future<void> capturePhoto(BuildContext context) async {
    isLoading.value = true;

    try {
      Get.dialog(
        AppDialog(
          title: 'Please wait...',
          imagePath: 'assets/images/hind.png',
          imageHeight: 200,
        ),
        barrierDismissible: false,
      );

      await Future.delayed(const Duration(seconds: 3));

      if (Get.isDialogOpen ?? false) Get.back(); // Close the dialog

      final XFile photo = await _cameraService.capturePhoto();

      Get.to(
        () => PhotoPreviewScreen(
          imagePath: photo.path,
          cameras: _cameraService.cameras!,
        ),
      );
    } catch (e) {
      debugPrint('Capture error: $e');
      Get.snackbar(
        'Error',
        'Failed to capture photo',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    _cameraService.dispose();
    super.onClose();
  }
}
