import 'package:flutter_riverpod/flutter_riverpod.dart';

final languageProvider = StateNotifierProvider<LanguageProvider, String>(
  (StateNotifierProviderRef<LanguageProvider, String> ref) =>
      LanguageProvider(),
);

class LanguageProvider extends StateNotifier<String> {
  LanguageProvider() : super('Español');

  void setLanguage(String language) {
    state = language;
  }
}
