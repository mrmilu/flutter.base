import 'package:flutter/services.dart';

class IbanInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Eliminar espacios y convertir a mayúsculas
    final cleanText = newValue.text.replaceAll(' ', '').toUpperCase();

    // Construir el formato "ES00 0000 0000 00 0000000000"
    final formattedText = StringBuffer();
    for (int i = 0; i < cleanText.length; i++) {
      if (i == 4 || i == 8 || i == 12 || i == 14) {
        formattedText.write(' '); // Agregar espacio cada 4 caracteres
      }
      formattedText.write(cleanText[i]);
    }

    return TextEditingValue(
      text: formattedText.toString(),
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}
