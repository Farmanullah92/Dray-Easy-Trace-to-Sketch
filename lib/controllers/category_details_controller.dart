import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../views/screens/draw_objects/animals_screen.dart';
import '../views/screens/draw_objects/birds_screen.dart';
import '../views/screens/draw_objects/cafe_screen.dart';
import '../views/screens/draw_objects/flower_screen.dart';
import '../views/screens/draw_objects/fruits_screen.dart';
import '../views/screens/draw_objects/holiday_screen.dart';
import '../views/screens/draw_objects/shape_screen.dart';
import '../views/screens/draw_objects/vegetable_screen.dart';

// Controller for state management
// ignore: deprecated_member_use
class CategoryDetailsController extends GetxController
        // ignore: deprecated_member_use
        with
        // ignore: deprecated_member_use
        SingleGetTickerProviderMixin {
  final List<Map<String, dynamic>> categories =
      [
        {
          'title': 'Shape',
          'icon': Icons.auto_awesome_mosaic,
          'color': Colors.indigo,
        },
        {'title': 'Fruits', 'icon': Icons.apple, 'color': Colors.redAccent},
        {'title': 'Cafe', 'icon': Icons.local_cafe, 'color': Colors.brown},
        {'title': 'Holiday', 'icon': Icons.beach_access, 'color': Colors.teal},
        {'title': 'Vegetable', 'icon': Icons.grass, 'color': Colors.green},
        {'title': 'Animals', 'icon': Icons.pets, 'color': Colors.orange},
        {'title': 'Flower', 'icon': Icons.local_florist, 'color': Colors.pink},
        {'title': 'Birds', 'icon': Icons.filter_hdr, 'color': Colors.blue},
      ].obs;

  late TabController tabController;
  final ScrollController scrollController = ScrollController();
  final RxDouble scrollOffset = 0.0.obs;
  final String initialCategory;

  CategoryDetailsController(this.initialCategory);

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(
      length: categories.length,
      vsync: this,
      initialIndex: getInitialTabIndex(initialCategory),
    );
    scrollController.addListener(_handleScroll);
  }

  @override
  void onClose() {
    tabController.dispose();
    scrollController.removeListener(_handleScroll);
    scrollController.dispose();
    super.onClose();
  }

  void _handleScroll() {
    scrollOffset.value = scrollController.offset;
  }

  void scrollToTop() {
    scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  int getInitialTabIndex(String category) {
    return categories.indexWhere((cat) => cat['title'] == category);
  }

  Widget getCategoryScreen(String title) {
    switch (title) {
      case 'Shape':
        return ShapeScreen();
      case 'Fruits':
        return FruitsScreen();
      case 'Cafe':
        return CafeScreen();
      case 'Holiday':
        return HolidayScreen();
      case 'Vegetable':
        return VegetableScreen();
      case 'Animals':
        return AnimalsScreen();
      case 'Flower':
        return FlowerScreen();
      case 'Birds':
        return BirdsScreen();
      default:
        return Center(
          child: Text('$title Content', style: const TextStyle(fontSize: 24)),
        );
    }
  }
}
