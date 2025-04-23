import 'package:draw_easy/views/screens/home_screen.dart';
import 'package:draw_easy/views/language/select_your_language.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends GetxController {
  var savedImagePath = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _loadSavedImagePath();
    _navigateToNextScreen();
  }

  Future<void> _loadSavedImagePath() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    savedImagePath.value = prefs.getString('splash_image_path') ?? '';
  }

  Future<void> _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 5));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool hasSeenOnboarding = prefs.getBool('hasSeenOnboarding') ?? false;

    if (hasSeenOnboarding) {
      Get.off(() => const HomeScreen());
    } else {
      await prefs.setBool('hasSeenOnboarding', true);
      Get.off(() => SelectYourLanguage());
    }
  }
}
