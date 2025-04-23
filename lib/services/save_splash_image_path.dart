import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveSplashImagePath(String path) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('splash_image_path', path);
}
