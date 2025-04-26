import 'package:draw_easy/controllers/holiday_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HolidayScreen extends StatelessWidget {
  HolidayScreen({super.key});

  final HolidayController controller = Get.put(HolidayController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      body: Obx(() {
        if (controller.isLoading.value && controller.cameras.isEmpty) {
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
                            () => controller.selectShape(
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
      }),
    );
  }
}
