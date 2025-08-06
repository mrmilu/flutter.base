import 'package:flutter/services.dart';

class PowerInputFormatter extends TextInputFormatter {
  final double min;
  final double max;

  PowerInputFormatter({required this.min, required this.max});

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String cleanText = newValue.text.replaceAll(' ', '').replaceAll(',', '.');

    // Si el usuario introduce solo un punto o una coma al principio, anteponer un 0
    if (cleanText == '.' || cleanText == ',') {
      cleanText = '0.';
    } else if (cleanText.startsWith('.') || cleanText.startsWith(',')) {
      cleanText = '0${cleanText.replaceFirst(',', '.')}';
    }

    // Permitir solo un punto decimal
    if ('.'.allMatches(cleanText).length > 1) {
      return oldValue;
    }

    // Permitir solo números y un punto decimal
    if (!RegExp(r'^\d*\.?\d*$').hasMatch(cleanText)) {
      return oldValue;
    }

    // Permitir solo un decimal después del punto
    if (cleanText.contains('.')) {
      final parts = cleanText.split('.');
      if (parts.length > 1 && parts[1].length > 1) {
        return oldValue;
      }
    }

    // Permitir vacío o solo punto
    if (cleanText.isEmpty || cleanText == '.') {
      return TextEditingValue(
        text: cleanText.replaceAll('.', ','),
        selection: TextSelection.collapsed(offset: cleanText.length),
      );
    }

    // Solo validar rango si el valor es decimal completo (no termina en '.')
    if (!cleanText.endsWith('.')) {
      final value = double.tryParse(cleanText);
      if (value == null || value > max) {
        return oldValue;
      }
      // Bloquear valores menores al mínimo, excepto cuando está escribiendo
      // Permite "0" temporal pero no "0.0" completo
      if (value < min && cleanText != '0') {
        return oldValue;
      }
    }

    return TextEditingValue(
      text: cleanText.replaceAll('.', ','),
      selection: TextSelection.collapsed(offset: cleanText.length),
    );
  }
}
