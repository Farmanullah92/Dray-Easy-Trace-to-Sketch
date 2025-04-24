import 'package:draw_easy/services/localization_service.dart';
import 'package:draw_easy/views/draw/license_and_credits.dart';
import 'package:draw_easy/views/draw/privacy_policy.dart';
import 'package:draw_easy/views/language/select_your_language.dart';
import 'package:draw_easy/widgets/app_dialog.dart';
import 'package:draw_easy/widgets/rate_app_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'subscription.dart';
import '../../controllers/drawer_controller.dart' as drawer_controller;

class CustomDrawer extends StatelessWidget {
  CustomDrawer({super.key});

  final drawerController = Get.put(drawer_controller.DrawerController());

  void _showRatingDialog(BuildContext context) {
    showDialog(context: context, builder: (_) => const RateAppDialog());
  }

  void _showUpdateDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AppDialog(
            title: "Draw Easy : Trace to Sketch",
            message:
                "Would you like to check if an update is available on the Play Store?",
            buttonText: "Check Now",
            onPressed: () => drawerController.launchPlayStore(),
            imagePath: "assets/images/hind.png",
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: const Color(0xFFF4F7FA),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // Header
            Container(
              height: 170,
              decoration: const BoxDecoration(color: Colors.black54),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/hind.png', height: 75),
                  const SizedBox(height: 8),
                  Text(
                    LocaleData.drawEasyTraceToSketch.getString(context),
                    style: GoogleFonts.abel(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            // Language
            ListTile(
              leading: const Icon(Icons.language),
              title: Text(LocaleData.selectLanguage.getString(context)),
              onTap: () {
                Get.to(() => SelectYourLanguage());
              },
            ),

            const Divider(color: Colors.black, thickness: 1),

            // Subscription
            ListTile(
              leading: const Icon(Icons.card_membership),
              title: Text(LocaleData.subscription.getString(context)),
              onTap: () {
                Get.to(() => Subscription());
              },
            ),

            // Rate App
            ListTile(
              leading: const Icon(Icons.star),
              title: Text(LocaleData.rateThisApp.getString(context)),
              onTap: () {
                Get.back();
                _showRatingDialog(context);
              },
            ),

            // Share App
            ListTile(
              leading: const Icon(Icons.share),
              title: Text(LocaleData.shareApp.getString(context)),
              onTap: () {
                Get.back();
                drawerController.shareApp();
              },
            ),

            const Divider(color: Colors.black, thickness: 1),

            // Privacy Policy
            ListTile(
              leading: const Icon(Icons.privacy_tip),
              title: Text(LocaleData.privacyPolicy.getString(context)),
              onTap: () {
                Get.to(() => const PrivacyPolicy());
              },
            ),

            // License and Credits
            ListTile(
              leading: const Icon(Icons.credit_card),
              title: Text(LocaleData.licenseAndCredits.getString(context)),
              onTap: () {
                Get.to(() => const LicenseAndCredits());
              },
            ),

            // Update App
            ListTile(
              leading: const Icon(Icons.system_update),
              title: Text(LocaleData.checkAndUpdate.getString(context)),
              onTap: () {
                Navigator.pop(context);
                _showUpdateDialog(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
