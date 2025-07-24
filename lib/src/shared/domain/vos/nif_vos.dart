import '../../../shared/helpers/either.dart';
import '../../../shared/helpers/value_object.dart';
import '../failures/nif_failure.dart';

class NifVos extends ValueObject<NifFailure, String> {
  @override
  final Either<NifFailure, String> value;

  factory NifVos(String input) {
    return NifVos._(
      _validate(input.trim()),
    );
  }
  const NifVos._(this.value);

  // Tabla de letras para el módulo 23
  static const List<String> _dniLetters = [
    'T',
    'R',
    'W',
    'A',
    'G',
    'M',
    'Y',
    'F',
    'P',
    'D',
    'X',
    'B',
    'N',
    'J',
    'Z',
    'S',
    'Q',
    'V',
    'H',
    'L',
    'C',
    'I',
    'E',
  ];

  static Either<NifFailure, String> _validate(String input) {
    // Validar longitud (debe ser exactamente 9 caracteres: 8 dígitos + 1 letra)
    if (input.length > 9) {
      return left(NifFailure.tooLong);
    }

    if (input.length < 9) {
      return left(NifFailure.tooShort);
    }

    // Validar formato (8 dígitos seguidos de una letra mayúscula)
    const regex = r'^[0-9]{8}[A-Z]$';
    if (!RegExp(regex).hasMatch(input)) {
      return left(NifFailure.invalidFormat);
    }

    // Extraer el número (primeros 8 caracteres) y la letra (último carácter)
    final numberStr = input.substring(0, 8);
    final letter = input.substring(8);

    // Convertir el número a entero
    final number = int.tryParse(numberStr);
    if (number == null) {
      return left(NifFailure.invalidFormat);
    }

    // Calcular la letra esperada usando el módulo 23
    final remainder = number % 23;
    final expectedLetter = _dniLetters[remainder];

    // Comparar la letra proporcionada con la esperada
    if (letter != expectedLetter) {
      return left(NifFailure.invalidFormat);
    }

    // Si todas las validaciones pasan, devolver el DNI
    return right(input);
  }
}
