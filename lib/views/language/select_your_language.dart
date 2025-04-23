import 'package:draw_easy/views/onboarding/onboarding_screen.dart';
import 'package:draw_easy/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import '../../services/localization_service.dart';

class SelectYourLanguage extends StatefulWidget {
  const SelectYourLanguage({super.key});

  @override
  State<SelectYourLanguage> createState() => _SelectYourLanguageState();
}

class _SelectYourLanguageState extends State<SelectYourLanguage> {
  String? selectedLanguage;
  late FlutterLocalization _localization;

  final List<Map<String, String>> languages = [
    {'code': 'en', 'name': 'English', 'flag': '🇬🇧'},
    {'code': 'fr', 'name': 'Français', 'flag': '🇫🇷'},
    {'code': 'pt', 'name': 'Português', 'flag': '🇵🇹'},
    {'code': 'de', 'name': 'Deutsch', 'flag': '🇩🇪'},
    {'code': 'ko', 'name': '한국어', 'flag': '🇰🇷'},
    {'code': 'ja', 'name': '日本語', 'flag': '🇯🇵'},
    {'code': 'es', 'name': 'Español', 'flag': '🇪🇸'},
    {'code': 'vi', 'name': 'Tiếng Việt', 'flag': '🇻🇳'},
  ];

  @override
  void initState() {
    super.initState();
    _localization = FlutterLocalization.instance;
    selectedLanguage = _localization.currentLocale?.languageCode ?? 'en';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF4F7FA),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black54),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          LocaleData.selectLanguage.getString(context),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.black87,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: CustomElevatedButton(
              onPressed: _handleDonePressed,
              borderRadius: 10,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                LocaleData.done.getString(context),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: languages.length,
        itemBuilder: (context, index) {
          final language = languages[index];
          final isSelected = selectedLanguage == language['code'];

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () => setState(() => selectedLanguage = language['code']),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected ? Colors.blue : Colors.transparent,
                    width: 1.5,
                  ),
                ),
                child: ListTile(
                  leading: Text(
                    language['flag']!,
                    style: const TextStyle(fontSize: 24),
                  ),
                  title: Text(
                    language['name']!,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  trailing:
                      isSelected
                          ? const Icon(Icons.check_circle, color: Colors.blue)
                          : null,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _handleDonePressed() async {
    try {
      if (selectedLanguage != null) {
        _localization.translate(selectedLanguage!);
        if (!mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => OnboardingScreen()),
        );
      } else {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select a language')),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error changing language: $e')));
    }
  }
}
