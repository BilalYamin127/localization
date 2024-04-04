import 'package:flutter/material.dart';
import 'package:localization/home_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:localization/language_change.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences sp = await SharedPreferences.getInstance();
  final String languagecode = sp.getString('language_code') ?? '';
  print(languagecode);
  runApp(MyApp(
    locale: languagecode,
  ));
}

class MyApp extends StatelessWidget {
  final String locale;
  MyApp({super.key, required this.locale});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => LanguageChangeNotifier())
        ],
        child: Consumer<LanguageChangeNotifier>(
          builder: (context, provider, child) {
            if (locale.isNotEmpty && provider.appLocale == null) {
              print('Setting appLocale to $locale');
              provider.changeLanguage(Locale(locale));
            }
            return MaterialApp(
              title: 'Simple App',
              locale: provider.appLocale ?? const Locale('en'),
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate
              ],
              supportedLocales: const [
                Locale('en'),
                Locale('es'),
              ],
              home: const HomeScreen(),
            );
          },
        ));
  }
}
