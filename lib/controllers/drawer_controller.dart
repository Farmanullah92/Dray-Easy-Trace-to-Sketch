import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';

class DrawerController extends GetxController {
  // Share app function
  void shareApp() {
    const String message =
        '🎨 Check out this amazing app "Draw Easy: Trace to Sketch"! \n\nDownload now from the Play Store:\nhttps://play.google.com/store/apps/details?id=com.example.draweasy';
    Share.share(message);
  }

  // Launch Play Store function
  Future<void> launchPlayStore() async {
    const url =
        'https://play.google.com/store/apps/details?id=com.example.draweasy';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      Get.snackbar(
        "Error",
        "Could not launch Play Store.",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
