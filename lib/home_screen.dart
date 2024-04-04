import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:localization/language_change.dart';

enum Language { english, spanish }

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

@override
class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(languagechangeProvider);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            PopupMenuButton(
              onSelected: (Language item) {
                if (Language.english == item) {
                  ref
                      .read(languagechangeProvider.notifier)
                      .changelanguage(const Locale('en'));
                } else {
                  ref
                      .read(languagechangeProvider.notifier)
                      .changelanguage(const Locale('es'));
                }
              },
              itemBuilder: (context) => <PopupMenuEntry<Language>>[
                const PopupMenuItem(
                    value: Language.english, child: Text('English')),
                const PopupMenuItem(
                    value: Language.spanish, child: Text('spanish')),
              ],
            )
          ],
          title: Center(child: Text(AppLocalizations.of(context)!.helloWorld)),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppLocalizations.of(context)!.welcome,
                style: TextStyle(color: Colors.amber),
              ),
              Text(AppLocalizations.of(context)!.pressButton),
              Text(AppLocalizations.of(context)!.currentDate(DateTime.now())),
              Text(AppLocalizations.of(context)!.currencyDemo(1234567)),
              Text(AppLocalizations.of(context)!.createdBy('Lokalise')),
            ],
          ),
        ));
  }
}
