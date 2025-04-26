import 'package:draw_easy/views/screens/camera/photo_preview_screen.dart';
import 'package:draw_easy/widgets/app_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:draw_easy/controllers/vegetable_controller.dart';

class VegetableScreen extends StatelessWidget {
  VegetableScreen({super.key});

  final VegetableController controller = Get.put(VegetableController());

  Future<void> _showShapeSelectedDialog(
    BuildContext context,
    String imagePath,
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

    if (controller.cameras.isNotEmpty) {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop(); // Close the dialog
      Navigator.push(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(
          builder:
              (context) => PhotoPreviewScreen(
                imagePath: imagePath,
                cameras: controller.cameras,
                isAssetImage: true,
              ),
        ),
      );
    } else {
      // ignore: avoid_print
      print("No cameras available");
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop(); // Close the dialog
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      body: GetBuilder<VegetableController>(
        builder: (_) {
          return SingleChildScrollView(
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
                          onTap:
                              () => _showShapeSelectedDialog(
                                context,
                                controller.shapeImagePaths[index],
                              ),
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
          );
        },
      ),
    );
  }
}
