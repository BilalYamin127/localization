import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:localization/app_theme.dart';
import 'package:localization/home_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:localization/language_change.dart';

import 'package:localization/providers/theme_provider.dart';

import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences sp = await SharedPreferences.getInstance();
  final String languageCode = sp.getString('language_code') ?? '';

  runApp(ProviderScope(
    child: MyApp(
      locale: languageCode,
    ),
  ));
}

class MyApp extends ConsumerStatefulWidget {
  final String locale;
  const MyApp({super.key, required this.locale});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) {
    final locale = widget.locale;

    final themeMode = ref.watch(themeModeProvider);
    final localefromprovider = ref.watch(languagechangeProvider).appLocale;
    if (locale.isNotEmpty && localefromprovider == null) {
      ref.read(languagechangeProvider.notifier).changelanguage(Locale(locale));
    }
    return MaterialApp(
      theme: themeMode == ThemeMode.light
          ? AppTheme.lightThemeCopy
          : AppTheme.darkTheme,
      darkTheme: AppTheme.darkTheme,
      title: 'Simple App',
      locale: localefromprovider ?? const Locale('en'),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('es'),
      ],
      home: const HomeScreen(),
    );
  }
}
