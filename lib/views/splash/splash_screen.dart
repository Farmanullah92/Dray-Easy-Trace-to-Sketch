import 'dart:io';
import 'package:draw_easy/controllers/splash_controller.dart';
import 'package:draw_easy/services/localization_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  final SplashController splashController = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xEAF4F7FA),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Obx(() {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 160,
                  width: 160,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                    color: Colors.black12,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(32),
                    child:
                        splashController.savedImagePath.value.isNotEmpty
                            ? Image.file(
                              File(splashController.savedImagePath.value),
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                  "assets/images/draweasy.png",
                                  fit: BoxFit.cover,
                                );
                              },
                            )
                            : Image.asset(
                              "assets/images/draweasy.png",
                              fit: BoxFit.cover,
                            ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  LocaleData.splashTitle.getString(context),
                  style: GoogleFonts.gabarito(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
                Text(
                  LocaleData.splashSubtitle.getString(context),
                  style: GoogleFonts.gabarito(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 200,
                  child: Lottie.asset(
                    'assets/lottie/draweasy.json',
                    height: 150,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
