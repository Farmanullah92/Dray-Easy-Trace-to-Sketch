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
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controllers/home_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF4F7FA),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black, size: 25),
        actions: [
          CustomElevatedButton(
            onPressed: () {
              Get.offAll(() => OnboardingScreen());
            },
            backgroundColor: const Color(0xFFF4F7FA),
            padding: const EdgeInsets.all(8),
            child: const Icon(Icons.help_outline, color: Colors.black, size: 25),
          ),
          const SizedBox(width: 10),
          CustomElevatedButton(
            onPressed: () {
              controller.showRatingDialog(context);
            },
            backgroundColor: Colors.white,
            padding: const EdgeInsets.all(8),
            child: const Icon(Icons.star, color: Colors.black, size: 25),
          ),
          const SizedBox(width: 10),
          CustomElevatedButton(
            onPressed: () {
              Get.to(() => Subscription());
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
        child: LayoutBuilder(
          builder: (context, constraints) {
            double padding = screenWidth * 0.08;
            double spacing = screenWidth * 0.02;
            double imageHeight = isPortrait ? screenHeight * 0.15 : screenHeight * 0.25;

            return SingleChildScrollView(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Image.asset(
                      'assets/images/hind.png',
                      height: imageHeight,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      'Trace & Sketch',
                      style: GoogleFonts.tradeWinds(
                        fontSize: isPortrait ? screenWidth * 0.08 : screenHeight * 0.08,
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: padding),
                    child: Row(
                      children: [
                        Expanded(
                          child: CustomImageCard(
                            imagePath: 'assets/images/gallery.png',
                            title: 'Gallery',
                            onTap: () {
                              Get.to(() => GalleryScreen());
                            },
                          ),
                        ),
                        SizedBox(width: spacing),
                        Expanded(
                          child: CustomImageCard(
                            imagePath: 'assets/images/camera.png',
                            title: 'Camera',
                            onTap: () {
                              Get.to(() => CameraScreen());
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: padding),
                    child: Row(
                      children: [
                        Expanded(
                          child: CustomImageCard(
                            imagePath: 'assets/images/draw_object.png',
                            title: 'Draw\nObjects',
                            onTap: () {
                              Get.to(() => DrawObjects());
                            },
                          ),
                        ),
                        SizedBox(width: spacing),
                        Expanded(
                          child: CustomImageCard(
                            imagePath: 'assets/images/mysketch.png',
                            title: 'My\nSketch',
                            onTap: () {
                              Get.to(() => MySketch());
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.05),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
