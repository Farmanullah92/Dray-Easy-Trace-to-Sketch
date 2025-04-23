import 'package:draw_easy/views/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:get/get.dart';
import 'package:draw_easy/controllers/app_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterLocalization.instance.ensureInitialized();
  Get.put(AppController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appController = Get.find<AppController>();
    return Obx(
      () => GetMaterialApp(
        title: 'Draw Easy',
        theme:
            appController.isDarkMode.value
                ? ThemeData.dark().copyWith(
                  colorScheme: ColorScheme.dark(
                    primary: Colors.deepPurple,
                    secondary: Colors.deepPurpleAccent,
                  ),
                )
                : ThemeData.light().copyWith(
                  colorScheme: ColorScheme.light(
                    primary: Colors.deepPurple,
                    secondary: Colors.deepPurpleAccent,
                  ),
                ),
        supportedLocales: FlutterLocalization.instance.supportedLocales,
        localizationsDelegates:
            FlutterLocalization.instance.localizationsDelegates,
        locale: appController.currentLocale.value,
        home: SplashScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
