import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final languageProvider = StateNotifierProvider<LanguageProvider, String>(
  (ref) => LanguageProvider(),
);

class LanguageProvider extends StateNotifier<String> {
  LanguageProvider() : super('Español');

  void setLanguage(String language) {
    state = language;
  }
}
