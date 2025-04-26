import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../views/draw/subscription.dart';
import '../views/onboarding/onboarding_screen.dart';
import '../widgets/rate_app_dialog.dart';

class HomeController extends GetxController {
  void showRatingDialog(BuildContext context) {
    showDialog(context: context, builder: (_) => const RateAppDialog());
  }

  void goToOnboardingScreen() {
    Get.offAll(() => OnboardingScreen());
  }

  void goToSubscription() {
    Get.to(() => Subscription());
  }
}
