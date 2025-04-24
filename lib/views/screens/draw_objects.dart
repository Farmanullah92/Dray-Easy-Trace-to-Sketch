import 'package:draw_easy/views/screens/category/category_details_screen.dart';
import 'package:flutter/material.dart';

class DrawObjects extends StatefulWidget {
  const DrawObjects({super.key});

  @override
  State<DrawObjects> createState() => _DrawObjectsState();
}

class _DrawObjectsState extends State<DrawObjects> {
  final List<Map<String, dynamic>> books = [
    {'title': 'Shape', 'icon': Icons.category, 'color': Colors.blue},
    {'title': 'Fruits', 'icon': Icons.apple, 'color': Colors.red},
    {'title': 'Cafe', 'icon': Icons.local_cafe, 'color': Colors.brown},
    {'title': 'Holiday', 'icon': Icons.beach_access, 'color': Colors.teal},
    {'title': 'Vegetable', 'icon': Icons.rice_bowl, 'color': Colors.green},
    {'title': 'Animals', 'icon': Icons.pets, 'color': Colors.orange},
    {'title': 'Flower', 'icon': Icons.local_florist, 'color': Colors.pink},
    {'title': 'Birds', 'icon': Icons.filter_hdr, 'color': Colors.purple},
  ];

  void handleTap(String title, Color color) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => CategoryDetailsScreen(category: title, color: color),
      ),
    );
  }

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
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Row(
            children:
                books.map((book) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: GestureDetector(
                      onTap: () => handleTap(book['title'], book['color']),
                      child: Container(
                        height: 280,
                        width: 320,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: book['color'], width: 2),
                          boxShadow: [
                            BoxShadow(
                              color: book['color'].withOpacity(0.3),
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
                                  color: book['color'].withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Icon(
                                  book['icon'],
                                  size: 80,
                                  color: book['color'],
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                book['title'],
                                style: TextStyle(
                                  fontSize: 18,
                                  color: book['color'],
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
      ),
    );
  }
}
