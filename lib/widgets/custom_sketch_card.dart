import 'package:flutter/material.dart';

class CustomImageCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final VoidCallback? onTap;

  const CustomImageCard({
    super.key,
    required this.imagePath,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF4F7FA),
            borderRadius: BorderRadius.circular(20),
          ),
          height: isPortrait ? screenHeight * 0.12 : screenHeight * 0.20,
          width: isPortrait ? screenWidth * 0.40 : screenWidth * 0.30,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          child: Row(
            children: [
              Image.asset(
                imagePath,
                height: isPortrait ? screenHeight * 0.07 : screenHeight * 0.1,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: isPortrait
                        ? screenWidth * 0.040
                        : screenHeight * 0.025,
                    fontWeight: FontWeight.bold,
                  ),
                  softWrap: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
