import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../views/screens/draw_objects/category_details_screen.dart';

// Controller for state management
class DrawObjectsController extends GetxController {
  final List<Map<String, dynamic>> categories = [
    {'title': 'Shape', 'icon': Icons.category, 'color': Colors.blue},
    {'title': 'Fruits', 'icon': Icons.apple, 'color': Colors.red},
    {'title': 'Cafe', 'icon': Icons.local_cafe, 'color': Colors.brown},
    {'title': 'Holiday', 'icon': Icons.beach_access, 'color': Colors.teal},
    {'title': 'Vegetable', 'icon': Icons.rice_bowl, 'color': Colors.green},
    {'title': 'Animals', 'icon': Icons.pets, 'color': Colors.orange},
    {'title': 'Flower', 'icon': Icons.local_florist, 'color': Colors.pink},
    {'title': 'Birds', 'icon': Icons.filter_hdr, 'color': Colors.purple},
  ].obs;

  void navigateToCategoryDetails(String title, Color color) {
    Get.to(() => CategoryDetailsScreen(category: title, color: color));
  }
}