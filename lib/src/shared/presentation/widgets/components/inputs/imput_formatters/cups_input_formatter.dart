import 'package:flutter/services.dart';

class CUPSInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Eliminar espacios y convertir a mayúsculas
    final cleanText = newValue.text.replaceAll(' ', '').toUpperCase();

    // Construir el formato "ES 0000 000000000000 XX YY"
    final formattedText = StringBuffer();

    for (int i = 0; i < cleanText.length; i++) {
      if (i == 2 || i == 6 || i == 18 || i == 20) {
        formattedText.write(
          ' ',
        ); // Agregar espacio en las posiciones específicas
      }
      formattedText.write(cleanText[i]);
    }

    return TextEditingValue(
      text: formattedText.toString(),
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}
