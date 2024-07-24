import 'package:flutter/services.dart';

class PhoneNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final newTextLength = newValue.text.length;
    int selectionIndex = newValue.selection.end;

    if (newTextLength >= oldValue.text.length) {
      if (newTextLength == 3) {
        return TextEditingValue(
          text: '${newValue.text}-',
          selection: TextSelection.collapsed(offset: selectionIndex + 1),
        );
      } else if (newTextLength == 8) {
        return TextEditingValue(
          text: '${newValue.text}-',
          selection: TextSelection.collapsed(offset: selectionIndex + 1),
        );
      }
    }

    return newValue;
  }
}
