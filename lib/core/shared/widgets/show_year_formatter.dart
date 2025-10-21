import 'package:flutter/services.dart';

class ShowYearInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final filteredText = newValue.text.replaceAll(RegExp(r'[^0-9-]'), '');
    return newValue.copyWith(text: filteredText);
  }
}
