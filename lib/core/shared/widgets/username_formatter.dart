import 'package:flutter/services.dart';

class UsernameFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final filteredText =
        newValue.text.toLowerCase().replaceAll(RegExp(r'[^a-z0-9_]'), '');
    return TextEditingValue(
      text: filteredText,
      selection: newValue.selection.copyWith(
        baseOffset: filteredText.length,
        extentOffset: filteredText.length,
      ),
    );
  }
}
