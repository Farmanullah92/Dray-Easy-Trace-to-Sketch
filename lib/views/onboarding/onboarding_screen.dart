import 'package:draw_easy/controllers/onboarding_controller.dart';
import 'package:draw_easy/model/onboarding_model.dart';
import 'package:draw_easy/services/localization_service.dart';
import 'package:draw_easy/views/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({super.key});

  final OnboardingController controller = Get.put(OnboardingController());

  final PageController _pageController = PageController();

  void _finishOnboarding() {
    Get.offAll(() => HomeScreen());
  }

  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    final List<OnboardingPage> _pages = [
      OnboardingPage(
        image: 'assets/lottie/capture.json',
        title: LocaleData.onboardingTitle1.getString(context),
        description: LocaleData.onboardingSubtitle1.getString(context),
      ),
      OnboardingPage(
        image: 'assets/lottie/draw.json',
        title: LocaleData.onboardingTitle2.getString(context),
        description: LocaleData.onboardingSubtitle2.getString(context),
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.blueGrey[600],
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextButton(
                  onPressed: () {
                    controller.skipOnboarding();
                    _pageController.jumpToPage(controller.totalPages - 1);
                  },
                  child: Text(
                    LocaleData.skip.getString(context),
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _pages.length,
                onPageChanged: (int page) {
                  controller.currentPage.value = page;
                },
                itemBuilder: (context, index) {
                  return SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(32.0),
                          child: Lottie.asset(
                            _pages[index].image,
                            height: 250,
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(height: 32),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32.0),
                          child: Text(
                            _pages[index].title,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32.0),
                          child: Text(
                            _pages[index].description,
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    controller.currentPage.value > 0
                        ? TextButton(
                          onPressed: () {
                            controller.previousPage();
                            _pageController.previousPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeIn,
                            );
                          },
                          child: Text(
                            LocaleData.previous.getString(context),
                            style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),
                        )
                        : const SizedBox(width: 80),
                    Row(
                      children: List.generate(
                        _pages.length,
                        (index) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color:
                                  controller.currentPage.value == index
                                      ? Colors.black54
                                      : Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        if (controller.isLastPage) {
                          _finishOnboarding();
                        } else {
                          controller.nextPage();
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn,
                          );
                        }
                      },
                      child: Text(
                        controller.isLastPage
                            ? LocaleData.finish.getString(context)
                            : LocaleData.next.getString(context),
                        style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
