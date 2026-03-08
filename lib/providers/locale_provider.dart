import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>(
  (_) => throw UnimplementedError(),
);

final localeProvider = StateNotifierProvider<LocaleNotifier, Locale>((ref) {
  final prefs = ref.read(sharedPreferencesProvider);
  final code = prefs.getString('app_locale') ?? 'ko';
  return LocaleNotifier(prefs, Locale(code));
});

class LocaleNotifier extends StateNotifier<Locale> {
  LocaleNotifier(this._prefs, Locale initial) : super(initial);

  final SharedPreferences _prefs;

  void toggle() {
    final next = state.languageCode == 'ko'
        ? const Locale('en')
        : const Locale('ko');
    state = next;
    _prefs.setString('app_locale', next.languageCode);
  }
}
