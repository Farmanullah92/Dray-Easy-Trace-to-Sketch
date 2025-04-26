import 'package:draw_easy/controllers/camera_controller_getx.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:camera/camera.dart';

class CameraScreen extends StatelessWidget {
  const CameraScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CameraControllerGetX cameraController = Get.put(
      CameraControllerGetX(),
    );

    return Scaffold(
      backgroundColor: Colors.black,
      body: Obx(() {
        if (!cameraController.isCameraInitialized.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return Stack(
          children: [
            CameraPreview(cameraController.controller!),

            // Flash Button
            Positioned(
              bottom: 30,
              left: 30,
              child: IconButton(
                onPressed: () async {
                  await cameraController.toggleFlash();
                },
                icon: GetBuilder<CameraControllerGetX>(
                  builder:
                      (_) => Icon(
                        cameraController.isFlashOn
                            ? Icons.flash_on
                            : Icons.flash_off,
                        color: Colors.white,
                        size: 30,
                      ),
                ),
              ),
            ),

            // Switch Camera Button
            Positioned(
              bottom: 30,
              right: 30,
              child: IconButton(
                onPressed: () async {
                  await cameraController.switchCamera();
                },
                icon: const Icon(
                  Icons.cameraswitch,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),

            // Capture Button
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Obx(
                  () => FloatingActionButton(
                    onPressed:
                        cameraController.isLoading.value
                            ? null
                            : () => cameraController.capturePhoto(context),
                    backgroundColor: Colors.white,
                    child:
                        cameraController.isLoading.value
                            ? const CircularProgressIndicator(
                              color: Colors.black,
                            )
                            : const Icon(Icons.camera, color: Colors.black),
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
