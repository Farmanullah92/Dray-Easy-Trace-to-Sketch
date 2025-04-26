import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/draw_objects_controller.dart';

class DrawObjects extends StatelessWidget {
  DrawObjects({super.key});

  final DrawObjectsController controller = Get.put(DrawObjectsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF4F7FA),
        elevation: 0,
        title: const Text(
          'Trace Book Category',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Obx(() => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Row(
            children: controller.categories.map((category) {
              return Padding(
                padding: const EdgeInsets.only(right: 20),
                child: GestureDetector(
                  onTap: () => controller.navigateToCategoryDetails(
                      category['title'],
                      category['color']
                  ),
                  child: Container(
                    height: 280,
                    width: 320,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: category['color'], width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: category['color'].withOpacity(0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 190,
                            width: 250,
                            decoration: BoxDecoration(
                              color: category['color'].withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Icon(
                              category['icon'],
                              size: 80,
                              color: category['color'],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            category['title'],
                            style: TextStyle(
                              fontSize: 18,
                              color: category['color'],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      )),
    );
  }
}
