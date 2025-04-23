import 'package:flutter/material.dart';

class DrawObjects extends StatefulWidget {
  const DrawObjects({super.key});

  @override
  State<DrawObjects> createState() => _DrawObjectsState();
}

class _DrawObjectsState extends State<DrawObjects> {
  final List<Map<String, dynamic>> books = [
    {'title': 'Shape', 'icon': Icons.category},
    {'title': 'Fruits', 'icon': Icons.apple},
    {'title': 'Cafe', 'icon': Icons.local_cafe},
    {'title': 'Holiday', 'icon': Icons.beach_access},
    {'title': 'Vegetable', 'icon': Icons.rice_bowl},
    {'title': 'Animals', 'icon': Icons.pets},
    {'title': 'Flower', 'icon': Icons.local_florist},
    {'title': 'Birds', 'icon': Icons.filter_hdr},
  ];

  void handleTap(String title) {
    // Navigator.push(context, MaterialPageRoute(builder: (context) => ,));
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
                      onTap: () => handleTap(book['title']),
                      child: Container(
                        height: 280,
                        width: 320,
                        decoration: BoxDecoration(
                          color: Colors.blueGrey,
                          borderRadius: BorderRadius.circular(20),
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
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Icon(
                                  book['icon'],
                                  size: 80,
                                  color: Colors.blueGrey,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                book['title'],
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
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
