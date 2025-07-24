class PhoneFormatterUtils {
  /// Formatea un número de teléfono sin espacios usando una máscara específica.
  /// Ejemplo: formatPhoneNumber('123456789', '000 000 000') → '123 456 789'
  static String formatPhoneNumber(String phoneNumber, String mask) {
    // Eliminar caracteres no numéricos del número de teléfono
    final cleanPhone = phoneNumber.replaceAll(RegExp(r'[^0-9]'), '');

    // Verificar que el número no sea vacío y que la máscara sea válida
    if (cleanPhone.isEmpty || mask.isEmpty) return cleanPhone;

    final formattedText = StringBuffer();
    int phoneIndex = 0;

    for (int i = 0; i < mask.length && phoneIndex < cleanPhone.length; i++) {
      if (mask[i] == '0') {
        if (phoneIndex < cleanPhone.length) {
          formattedText.write(cleanPhone[phoneIndex]);
          phoneIndex++;
        }
      } else {
        // Añadir el separador (como espacio) si está en la máscara
        formattedText.write(mask[i]);
      }
    }

    // Limitar al máximo de dígitos permitidos por la máscara
    final maxDigits = mask.replaceAll(RegExp(r'[^0]'), '').length;
    if (phoneIndex > maxDigits) {
      return formattedText.toString().substring(
        0,
        formattedText.length - (phoneIndex - maxDigits),
      );
    }

    return formattedText.toString();
  }

  /// Limpia un número de teléfono eliminando todos los espacios y caracteres no numéricos.
  /// Ejemplo: cleanPhoneNumber('123 456 789') → '123456789'
  static String cleanPhoneNumber(String phoneNumber) {
    return phoneNumber.replaceAll(RegExp(r'[^0-9]'), '');
  }
}
