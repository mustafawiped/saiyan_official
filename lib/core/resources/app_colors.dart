import 'package:flutter/material.dart';

class AppColors {
  // Temalar
  static const _dark = _DarkColors();
  static const _light = _LightColors();

  // Aktif tema seçimi
  static _ColorScheme _current(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? _dark : _light;

  // Renk getter'ları
  static Color primary(BuildContext c) => _current(c).primary;
  static Color onPrimary(BuildContext c) => _current(c).onPrimary;
  static Color secondary(BuildContext c) => _current(c).secondary;
  static Color backgroundDark(BuildContext c) => _current(c).backgroundDark;
  static Color background(BuildContext c) => _current(c).background;
  static Color surfaceDim(BuildContext c) => _current(c).surfaceDim;
  static Color surfaceCenter(BuildContext c) => _current(c).surfaceCenter;
  static Color surfaceLight(BuildContext c) => _current(c).surfaceLight;
  static Color success(BuildContext c) => _current(c).success;
  static Color error(BuildContext c) => _current(c).error;
  static Color textPrimary(BuildContext c) => _current(c).textPrimary;
  static Color textSecondary(BuildContext c) => _current(c).textSecondary;
  static Color accentPurple(BuildContext c) => _current(c).accentPurple;
  static Color accentYellow(BuildContext c) => _current(c).accentYellow;
  static Color accentGreen(BuildContext c) => _current(c).accentGreen;
  static Color accentBlue(BuildContext c) => _current(c).accentBlue;
  static Color grayDark(BuildContext c) => _current(c).grayDark;
  static Color grayLight(BuildContext c) => _current(c).grayLight;
  static Color grayOpen(BuildContext c) => _current(c).grayOpen;
}

//--------------------------------------------------------------------
// Base Color Scheme
//--------------------------------------------------------------------

abstract class _ColorScheme {
  Color get primary;
  Color get onPrimary;
  Color get secondary;
  Color get backgroundDark;
  Color get background;
  Color get surfaceDim;
  Color get surfaceCenter;
  Color get surfaceLight;
  Color get success;
  Color get error;
  Color get textPrimary;
  Color get textSecondary;
  Color get accentPurple;
  Color get accentYellow;
  Color get accentGreen;
  Color get accentBlue;
  Color get grayDark;
  Color get grayLight;
  Color get grayOpen;
}

//--------------------------------------------------------------------
// DARK THEME COLORS
//--------------------------------------------------------------------

class _DarkColors implements _ColorScheme {
  const _DarkColors();

  @override
  Color get primary => const Color(0xFF006BAE);
  @override
  Color get onPrimary => const Color(0xFFF8FDFF);
  @override
  Color get secondary => const Color(0xFF9AD8FF);
  @override
  Color get backgroundDark => const Color(0xFF141414);
  @override
  Color get background => const Color(0xFF262626);
  @override
  Color get surfaceDim => const Color(0xFF1A1D21);
  @override
  Color get surfaceCenter => const Color(0xFF404040);
  @override
  Color get surfaceLight => const Color(0xFFE0E0E0);
  @override
  Color get success => Colors.green.shade400;
  @override
  Color get error => Colors.red.shade400;
  @override
  Color get textPrimary => Colors.white;
  @override
  Color get textSecondary => Colors.grey.shade400;
  @override
  Color get accentPurple => const Color(0xFF7D3498);
  @override
  Color get accentYellow => Colors.yellow;
  @override
  Color get accentGreen => const Color(0xFF15803D);
  @override
  Color get accentBlue => const Color(0xFF005DA3);
  @override
  Color get grayDark => Colors.grey.shade700;
  @override
  Color get grayLight => Colors.grey.shade500;
  @override
  Color get grayOpen => Colors.grey.shade200;
}

//--------------------------------------------------------------------
// LIGHT THEME COLORS
//--------------------------------------------------------------------

class _LightColors implements _ColorScheme {
  const _LightColors();

  @override
  Color get primary => const Color(0xFF007BFF);
  @override
  Color get onPrimary => const Color(0xFFF8FDFF);
  @override
  Color get secondary => const Color(0xFFC5BAFF);
  @override
  Color get backgroundDark => const Color(0xFFFBFBFB);
  @override
  Color get background => const Color(0xFFFFFFFF);
  @override
  Color get surfaceDim => const Color(0xFFEAEAEA);
  @override
  Color get surfaceCenter => const Color(0xFFDDDDDD);
  @override
  Color get surfaceLight => const Color(0xFFF5F5F5);
  @override
  Color get success => Colors.green.shade700;
  @override
  Color get error => Colors.red.shade700;
  @override
  Color get textPrimary => Colors.black;
  @override
  Color get textSecondary => Colors.grey.shade700;
  @override
  Color get accentPurple => const Color(0xFF8E44AD);
  @override
  Color get accentYellow => Colors.amber;
  @override
  Color get accentGreen => const Color(0xFF0F7C2E);
  @override
  Color get accentBlue => const Color(0xFF004080);
  @override
  Color get grayDark => const Color(0xFFE8F9FF);
  @override
  Color get grayLight => const Color(0xFFC4D9FF);
  @override
  Color get grayOpen => Colors.grey.shade100;
}
