import 'package:draw_easy/views/screens/camera/photo_preview_screen.dart';
import 'package:draw_easy/widgets/app_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:draw_easy/controllers/shape_controller.dart';

class ShapeScreen extends StatelessWidget {
  const ShapeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShapeController>(
      init: ShapeController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.black54,
          body: Obx(() {
            return Stack(
              children: [
                SingleChildScrollView(
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
                                  showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) {
                                      return const AppDialog(
                                        title: 'Please wait...',
                                        imagePath: 'assets/images/hind.png',
                                        imageHeight: 200,
                                      );
                                    },
                                  );

                                  controller.processShapeSelection(
                                    imagePath:
                                        controller.shapeImagePaths[index],
                                    onNavigate: (cameras, imagePath) {
                                      Navigator.of(
                                        context,
                                      ).pop(); // close dialog
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
                                    },
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
                if (controller.isLoading.value)
                  const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  ),
              ],
            );
          }),
        );
      },
    );
  }
}
