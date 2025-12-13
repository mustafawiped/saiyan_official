import 'package:bot_toast/bot_toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:saiyan_official/router/router.dart';

class SaiyanApp extends StatefulWidget {
  const SaiyanApp({super.key});

  @override
  State<SaiyanApp> createState() => _SaiyanAppState();
}

class _SaiyanAppState extends State<SaiyanApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      builder: BotToastInit(),
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      themeMode: ThemeMode.system,
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color(0xFFF8FDFF),
        colorScheme: const ColorScheme.light(
          primary: Color(0xFF007BFF),
          secondary: Color(0xFF005da3),
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF262626),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF006bae),
          secondary: Color(0xFF9ad8ff),
        ),
      ),
      routerConfig: router.config(
        navigatorObservers: () => [BotToastNavigatorObserver()],
      ),
    );
  }
}
