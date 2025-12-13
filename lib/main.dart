import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:saiyan_official/saiyan.dart';

void main() {
  FlutterError.onError = (FlutterErrorDetails details) {
    if (kDebugMode) {
      print('Flutter Hatası: ${details.exception}');
    }
  };

  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      // await MobileAds.instance.initialize();
      await initializeDateFormatting('tr_TR', null);
      await EasyLocalization.ensureInitialized();
      runApp(
        EasyLocalization(
          supportedLocales: [
            Locale('tr'),
            Locale('en'),
            Locale('de'),
            Locale("fr"),
          ],
          path: 'assets/languages',
          fallbackLocale: Locale('en', 'US'),
          child: SaiyanApp(),
        ),
      );
    },
    (error, stack) {
      if (kDebugMode) {
        print("zoned hatası: $error");
      }
    },
  );
}
