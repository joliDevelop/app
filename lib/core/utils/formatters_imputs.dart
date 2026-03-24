// FORMATOS EN TIEMPO REAL PARA LOS INPUTS

import 'package:flutter/services.dart';

// Formato para que la primera letra escrita se coloque automaticamente en mayuscula 
// y el resto en minuscula. 
class CapitalizeFirstLetterFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text;

    if (text.isEmpty) return newValue;

    final formatted = text[0].toUpperCase() + text.substring(1).toLowerCase();

    return newValue.copyWith(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}