import 'package:flutter/services.dart';

class PhoneInputFormatter extends TextInputFormatter {
  final String mask;

  PhoneInputFormatter(this.mask);

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Eliminar espacios y otros caracteres no numéricos
    final cleanText = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    // Construir el texto formateado usando la máscara
    final formattedText = StringBuffer();
    int cleanTextIndex = 0;
    int maskIndex = 0;

    while (cleanTextIndex < cleanText.length && maskIndex < mask.length) {
      if (mask[maskIndex] == '0') {
        if (cleanTextIndex < cleanText.length) {
          formattedText.write(cleanText[cleanTextIndex]);
          cleanTextIndex++;
        }
      } else {
        // Añadir el separador (como espacio) si está en la máscara
        formattedText.write(mask[maskIndex]);
      }
      maskIndex++;
    }

    // Asegurarse de no exceder la longitud máxima de la máscara
    final maxLength = mask.replaceAll(RegExp(r'[^0]'), '').length;
    if (cleanTextIndex > maxLength) {
      cleanTextIndex = maxLength;
    }

    return TextEditingValue(
      text: formattedText.toString(),
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}
