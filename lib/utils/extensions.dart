import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// sizedbox extension
extension SizedBoxExtension on num {
  SizedBox get h => SizedBox(
        height: toDouble(),
      );

  SizedBox get w => SizedBox(
        width: toDouble(),
      );
}

// font extension
extension FontExtension on TextStyle {
  TextStyle get headerFont => GoogleFonts.spaceGrotesk(
        textStyle: this,
      );

  TextStyle get textFont => GoogleFonts.beVietnamPro(
        textStyle: this,
      );

  TextStyle get widgetFont => GoogleFonts.ibmPlexSans(
        textStyle: this,
      );
}
