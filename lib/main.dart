import 'dart:async';

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
      runApp(const SaiyanApp());
    },
    (error, stack) {
      if (kDebugMode) {
        print("zoned hatası: $error");
      }
    },
  );
}
