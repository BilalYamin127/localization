// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageChangeState {
  Locale? appLocale;
  bool? isLoading;
  LanguageChangeState({
    this.appLocale,
    this.isLoading,
  });
  Locale? get appLocales => appLocale;

  LanguageChangeState copyWith({
    Locale? appLocale,
    bool? isLoading,
  }) {
    return LanguageChangeState(
      appLocale: appLocale ?? this.appLocale,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  String toString() =>
      'LanguageChangeState(appLocale: $appLocale, isLoading: $isLoading)';
}

class LanguageNotifier extends Notifier<LanguageChangeState> {
  @override
  build() {
    return LanguageChangeState(isLoading: false);
  }

  Future<void> changelanguage(Locale type) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    state = LanguageChangeState(appLocale: type);

    if (type == const Locale('en')) {
      await sp.setString('language_code', 'en');
    } else {
      await sp.setString('language_code', 'es');
    }
  }
}

final languagechangeProvider =
    NotifierProvider<LanguageNotifier, LanguageChangeState>(
        LanguageNotifier.new);
