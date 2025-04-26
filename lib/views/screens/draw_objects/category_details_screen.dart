// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/category_details_controller.dart';

class CategoryDetailsScreen extends StatelessWidget {
  final String category;
  final Color color;

  const CategoryDetailsScreen({
    super.key,
    required this.category,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoryDetailsController(category));
    final screenHeight = MediaQuery.of(context).size.height;
    final appBarHeight = screenHeight * 0.2;

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Obx(
        () => CustomScrollView(
          controller: controller.scrollController,
          slivers: [
            SliverAppBar(
              expandedHeight: appBarHeight,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.parallax,
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [color.withOpacity(0.8), color.withOpacity(0.4)],
                    ),
                  ),
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            category,
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  blurRadius: 10.0,
                                  color: Colors.black45,
                                  offset: Offset(2.0, 2.0),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Explore $category drawings',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white.withOpacity(0.9),
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(60),
                child: Container(
                  color: Colors.white,
                  child: TabBar(
                    controller: controller.tabController,
                    isScrollable: true,
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        colors: [
                          color.withOpacity(0.8),
                          color.withOpacity(0.4),
                        ],
                      ),
                    ),
                    labelColor: Colors.white,
                    unselectedLabelColor: color.withOpacity(0.6),
                    tabs:
                        controller.categories.map((cat) {
                          return Tab(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(cat['icon'], size: 20),
                                  const SizedBox(width: 8),
                                  Text(cat['title']),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                  ),
                ),
              ),
            ),
            SliverFillRemaining(
              child: TabBarView(
                controller: controller.tabController,
                children:
                    controller.categories.map((cat) {
                      return controller.getCategoryScreen(cat['title']);
                    }).toList(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton:
          controller.scrollOffset.value > 100
              ? FloatingActionButton(
                backgroundColor: color,
                onPressed: controller.scrollToTop,
                child: const Icon(Icons.arrow_upward, color: Colors.white),
              )
              : null,
    );
  }
}
