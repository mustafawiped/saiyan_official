import 'package:flutter/services.dart';

class DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String text =
        newValue.text.replaceAll(RegExp(r'[^0-9]'), ''); // Sadece rakam al
    String formattedText = '';

    if (text.length > 2) {
      formattedText += '${text.substring(0, 2)}.';
      if (text.length > 4) {
        formattedText += '${text.substring(2, 4)}.';
        if (text.length > 8) {
          formattedText += text.substring(4, 8);
        } else {
          formattedText += text.substring(4);
        }
      } else {
        formattedText += text.substring(2);
      }
    } else {
      formattedText = text;
    }

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}
