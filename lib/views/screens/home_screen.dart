import 'package:draw_easy/views/draw/subscription.dart';
import 'package:draw_easy/views/screens/camera/camera_screen.dart';
import 'package:draw_easy/views/screens/draw_objects.dart';
import 'package:draw_easy/views/screens/gallery_screen.dart';
import 'package:draw_easy/views/onboarding/onboarding_screen.dart';
import 'package:draw_easy/views/screens/my_sketch.dart';
import 'package:draw_easy/widgets/custom_button.dart';
import 'package:draw_easy/views/draw/custom_drawer.dart';
import 'package:draw_easy/widgets/custom_sketch_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF4F7FA),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          // Help Button
          CustomElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => OnboardingScreen()),
              );
            },
            backgroundColor: const Color(0xFFF4F7FA),
            padding: const EdgeInsets.all(8),
            child: const Icon(
              Icons.help_outline,
              color: Colors.black,
              size: 24,
            ),
          ),
          const SizedBox(width: 10),

          // Notifications Button
          CustomElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Notifications will appear here')),
              );
            },
            backgroundColor: Colors.white,
            padding: const EdgeInsets.all(8),
            child: const Icon(
              Icons.notifications_none,
              color: Colors.black,
              size: 24,
            ),
          ),
          const SizedBox(width: 10),

          // Profile Button
          CustomElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Subscription()),
              );
            },
            backgroundColor: Colors.white,
            padding: const EdgeInsets.all(8),
            child: Image.asset('assets/icon/crowno.png', height: 30),
          ),
          const SizedBox(width: 16),
        ],
      ),
      backgroundColor: const Color(0xFFF4F7FA),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Top decorative image
              Align(
                alignment: Alignment.topRight,
                child: Image.asset(
                  'assets/images/hind.png',
                  height: isPortrait ? screenHeight * 0.15 : screenHeight * 0.2,
                  fit: BoxFit.contain,
                ),
              ),

              // Title
              Text(
                'Trace & Sketch',
                style: GoogleFonts.tradeWinds(
                  fontSize:
                      isPortrait ? screenWidth * 0.10 : screenHeight * 0.08,
                ),
              ),

              // First row of cards
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.08,
                  vertical:
                      isPortrait ? screenHeight * 0.02 : screenHeight * 0.05,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Flexible(
                      child: CustomImageCard(
                        imagePath: 'assets/images/gallery.png',
                        title: 'Gallery',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const GalleryScreen(),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.01),
                    Flexible(
                      child: CustomImageCard(
                        imagePath: 'assets/images/camera.png',
                        title: 'Camera',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CameraScreen(),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),

              // Second row of cards
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.08,
                  vertical:
                      isPortrait ? screenHeight * 0.01 : screenHeight * 0.05,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Flexible(
                      child: CustomImageCard(
                        imagePath: 'assets/images/draw_object.png',
                        title: 'Draw\nObjects',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DrawObjects(),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.01),
                    Flexible(
                      child: CustomImageCard(
                        imagePath: 'assets/images/mysketch.png',
                        title: 'My\nSketch',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MySketch()),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),

              // Add some bottom padding
              SizedBox(height: isPortrait ? screenHeight * 0.05 : 0),
            ],
          ),
        ),
      ),
    );
  }
}
