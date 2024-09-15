import 'package:flutter_riverpod/flutter_riverpod.dart';

final languageProvider = StateNotifierProvider<LanguageProvider, String>(
  (ref) => LanguageProvider(),
);

class LanguageProvider extends StateNotifier<String> {
  LanguageProvider()
      : super('Español'); // Puedes establecer el idioma inicial aquí

  void setLanguage(String language) {
    state = language;
  }
}
