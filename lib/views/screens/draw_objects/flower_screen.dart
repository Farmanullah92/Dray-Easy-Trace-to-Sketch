import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:camera/camera.dart';
import 'package:draw_easy/controllers/flower_controller.dart';
import 'package:draw_easy/views/screens/camera/photo_preview_screen.dart';
import 'package:draw_easy/widgets/app_dialog.dart';

class FlowerScreen extends StatelessWidget {
  const FlowerScreen({super.key});

  Future<void> _showShapeSelectedDialog(
    BuildContext context,
    String imagePath,
    List<CameraDescription> cameras,
  ) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AppDialog(
          title: 'Please wait...',
          imagePath: 'assets/images/hind.png',
          imageHeight: 200,
        );
      },
    );

    await Future.delayed(const Duration(seconds: 2));

    if (context.mounted) {
      Navigator.of(context).pop(); // Close dialog
      if (cameras.isNotEmpty) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) => PhotoPreviewScreen(
                  imagePath: imagePath,
                  cameras: cameras,
                  isAssetImage: true,
                ),
          ),
        );
      } else {
        // ignore: avoid_print
        print("No cameras available");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FlowerController>(
      init: FlowerController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.black54,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Column(
                children: [
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(16.0),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 8.0,
                          mainAxisSpacing: 8.0,
                        ),
                    itemCount: controller.shapeImagePaths.length,
                    itemBuilder: (context, index) {
                      return Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(width: 2),
                          color: Colors.white,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            _showShapeSelectedDialog(
                              context,
                              controller.shapeImagePaths[index],
                              controller.cameras,
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              controller.shapeImagePaths[index],
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
