import 'package:draw_easy/views/screens/category/cafe_screen.dart';
import 'package:flutter/material.dart';
import 'package:draw_easy/views/screens/category/animals_screen.dart';
import 'package:draw_easy/views/screens/category/birds_screen.dart';
import 'package:draw_easy/views/screens/category/flower_screen.dart';
import 'package:draw_easy/views/screens/category/fruits_screen.dart';
import 'package:draw_easy/views/screens/category/holiday_screen.dart';
import 'package:draw_easy/views/screens/category/shape_screen.dart';
import 'package:draw_easy/views/screens/category/vegetable_screen.dart';

class CategoryDetailsScreen extends StatefulWidget {
  final String category;
  final Color color;

  const CategoryDetailsScreen({
    super.key,
    required this.category,
    required this.color,
  });

  @override
  State<CategoryDetailsScreen> createState() => _CategoryDetailsScreenState();
}

class _CategoryDetailsScreenState extends State<CategoryDetailsScreen>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late TabController _tabController;
  final ScrollController _scrollController = ScrollController();
  double _scrollOffset = 0.0;

  final List<Map<String, dynamic>> categories = [
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
  ];

  @override
  bool get wantKeepAlive => true;

  int getInitialTabIndex() {
    return categories.indexWhere((cat) => cat['title'] == widget.category);
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: categories.length,
      vsync: this,
      initialIndex: getInitialTabIndex(),
    );
    _scrollController.addListener(() {
      setState(() {
        _scrollOffset = _scrollController.offset;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final screenHeight = MediaQuery.of(context).size.height;
    final appBarHeight = screenHeight * 0.2;

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: CustomScrollView(
        controller: _scrollController,
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
                    colors: [
                      widget.color.withOpacity(0.8),
                      widget.color.withOpacity(0.4),
                    ],
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
                          widget.category,
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
                          'Explore ${widget.category} drawings',
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
                  controller: _tabController,
                  isScrollable: true,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      colors: [
                        widget.color.withOpacity(0.8),
                        widget.color.withOpacity(0.4),
                      ],
                    ),
                  ),
                  labelColor: Colors.white,
                  unselectedLabelColor: widget.color.withOpacity(0.6),
                  tabs:
                      categories.map((cat) {
                        return Tab(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
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
              controller: _tabController,
              children:
                  categories.map((cat) {
                    return _buildCategoryContent(cat['title']);
                  }).toList(),
            ),
          ),
        ],
      ),
      floatingActionButton:
          _scrollOffset > 100
              ? FloatingActionButton(
                backgroundColor: widget.color,
                child: const Icon(Icons.arrow_upward, color: Colors.white),
                onPressed: () {
                  _scrollController.animateTo(
                    0,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                },
              )
              : null,
    );
  }

  Widget _buildCategoryContent(String category) {
    switch (category) {
      case 'Shape':
        return ShapeScreen();
      case 'Fruits':
        return const FruitsScreen();
      case 'Cafe':
        return CafeScreen();
      case 'Holiday':
        return const HolidayScreen();
      case 'Vegetable':
        return const VegetableScreen();
      case 'Animals':
        return const AnimalsScreen();
      case 'Flower':
        return const FlowerScreen();
      case 'Birds':
        return const BirdsScreen();
      default:
        return Center(
          child: Text(
            '$category Content',
            style: const TextStyle(fontSize: 24),
          ),
        );
    }
  }
}
