import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:get/get.dart';
import 'package:draw_easy/services/localization_service.dart';

class AppController extends GetxController {
  var isDarkMode = false.obs;

  var currentLocale = const Locale('en').obs;

  @override
  void onInit() {
    super.onInit();
    configureLocalization();
  }

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
  }

  void changeLanguage(Locale locale) {
    currentLocale.value = locale;
    FlutterLocalization.instance.translate(locale.languageCode);
  }

  void configureLocalization() {
    FlutterLocalization.instance.init(
      mapLocales: LOCALES,
      initLanguageCode: "en",
    );
    FlutterLocalization.instance.onTranslatedLanguage = onTranslatedLanguage;
  }

  void onTranslatedLanguage(Locale? locale) {
    if (locale != null) {
      currentLocale.value = locale;
    }
  }
}
