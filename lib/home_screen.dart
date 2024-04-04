import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:localization/language_change.dart';
import 'package:provider/provider.dart';

enum language { english, spanish }

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Consumer<LanguageChangeNotifier>(
            builder: (context, provider, child) {
              return PopupMenuButton(
                onSelected: (language item) {
                  if (language.english.name == (item.name)) {
                    provider.changeLanguage(const Locale('en'));
                  } else {
                    provider.changeLanguage(const Locale('es'));
                  }
                },
                itemBuilder: (context) => <PopupMenuEntry<language>>[
                  const PopupMenuItem(
                      value: language.english, child: Text('English')),
                  const PopupMenuItem(
                      value: language.spanish, child: Text('spanish')),
                ],
              );
            },
          )
        ],
        title: Center(child: Text(AppLocalizations.of(context)!.helloWorld)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(AppLocalizations.of(context)!.welcome),
            Text(AppLocalizations.of(context)!.pressButton),
            Text(AppLocalizations.of(context)!.currentDate(DateTime.now())),
            Text(AppLocalizations.of(context)!.currencyDemo(1234567)),
            Text(AppLocalizations.of(context)!.createdBy('Lokalise')),
          ],
        ),
      ),
    );
  }
}
