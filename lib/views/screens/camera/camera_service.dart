import 'package:camera/camera.dart';

class CameraService {
  List<CameraDescription>? cameras;
  CameraController? controller;
  bool isFlashOn = false;
  bool isRearCameraSelected = true;

  Future<void> initializeCamera() async {
    cameras = await availableCameras();
    if (cameras == null || cameras!.isEmpty) {
      throw Exception('No cameras available');
    }

    await startCamera(
      cameras!.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.back,
        orElse: () => cameras!.first,
      ),
    );
  }

  Future<void> startCamera(CameraDescription cameraDescription) async {
    if (controller != null) {
      await controller!.dispose();
    }
    controller = CameraController(
      cameraDescription,
      ResolutionPreset.high,
      enableAudio: false,
    );
    await controller!.initialize();
  }

  Future<void> toggleFlash() async {
    if (controller == null || !controller!.value.isInitialized) return;
    isFlashOn = !isFlashOn;
    await controller!.setFlashMode(isFlashOn ? FlashMode.torch : FlashMode.off);
  }

  Future<void> switchCamera() async {
    if (cameras == null || cameras!.length < 2) return;
    isRearCameraSelected = !isRearCameraSelected;
    final newCamera = cameras!.firstWhere(
      (camera) =>
          isRearCameraSelected
              ? camera.lensDirection == CameraLensDirection.back
              : camera.lensDirection == CameraLensDirection.front,
      orElse: () => cameras!.first,
    );
    await startCamera(newCamera);
  }

  Future<XFile> capturePhoto() async {
    if (controller == null || !controller!.value.isInitialized) {
      throw Exception('Camera is not initialized');
    }
    return await controller!.takePicture();
  }

  void dispose() {
    controller?.dispose();
  }
}
