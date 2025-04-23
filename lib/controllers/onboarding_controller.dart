import 'package:get/get.dart';

class OnboardingController extends GetxController {
  final RxInt currentPage = 0.obs;
  final int totalPages = 2;

  void nextPage() {
    if (currentPage.value < totalPages - 1) {
      currentPage.value++;
    }
  }

  void previousPage() {
    if (currentPage.value > 0) {
      currentPage.value--;
    }
  }

  void skipOnboarding() {
    currentPage.value = totalPages - 1;
  }

  bool get isLastPage => currentPage.value == totalPages - 1;
}
