import 'package:draw_easy/controllers/cafe_controller.dart';
import 'package:draw_easy/widgets/app_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BirdsScreen extends StatelessWidget {
  BirdsScreen({super.key});

  final CafeController controller = Get.put(CafeController());

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

  Future<void> _showShapeSelectedDialog(String imagePath) async {
    Get.dialog(
      const AppDialog(
        title: 'Please wait...',
        imagePath: 'assets/images/hind.png',
        imageHeight: 200,
      ),
      barrierDismissible: false,
    );

    await Future.delayed(const Duration(seconds: 2));

    if (Get.isDialogOpen!) Get.back(); // Close the dialog
    controller.navigateToPhotoPreview(imagePath);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Column(
              children: [
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(16.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                  ),
                  itemCount: shapeImagePaths.length,
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
                              shapeImagePaths[index],
                            ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            shapeImagePaths[index],
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
      }),
    );
  }
}
