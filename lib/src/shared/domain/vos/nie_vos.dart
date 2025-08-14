import '../../../shared/helpers/either.dart';
import '../../../shared/helpers/value_object.dart';
import '../failures/nie_failure.dart';

class NieVos extends ValueObject<NieFailure, String> {
  @override
  final Either<NieFailure, String> value;

  factory NieVos(String input) {
    return NieVos._(
      _validate(input.trim()),
    );
  }

  const NieVos._(this.value);

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

  static Either<NieFailure, String> _validate(String input) {
    // Validar longitud (debe ser exactamente 9 caracteres: 8 dígitos + 1 letra para DNI, o 1 letra + 7 dígitos + 1 letra para NIE)
    if (input.length > 9) {
      return left(const NieFailure.tooLong(length: 9));
    }

    // Validar formato (DNI: 8 dígitos + 1 letra mayúscula; NIE: letra [X/Y/Z] + 7 dígitos + 1 letra mayúscula)
    const nieRegex = r'^[XYZ][0-9]{7}[A-Z]$';

    final isNie = RegExp(nieRegex).hasMatch(input);
    if (!isNie) {
      return left(const NieFailure.invalid());
    }

    // Extraer el número y la letra
    String numberStr;
    final letter = input.substring(8);

    // Para NIE: reemplazar la primera letra (X, Y, Z) por 0, 1, 2 y tomar los siguientes 7 dígitos
    final prefix = input[0];
    final prefixValue = prefix == 'X'
        ? '0'
        : prefix == 'Y'
        ? '1'
        : '2';
    numberStr = prefixValue + input.substring(1, 8);

    // Convertir el número a entero
    final number = int.parse(numberStr);

    // Calcular la letra esperada usando el módulo 23
    final remainder = number % 23;
    final expectedLetter = _dniLetters[remainder];

    // Comparar la letra proporcionada con la esperada
    if (letter != expectedLetter) {
      return left(const NieFailure.invalid());
    }

    return right(input);
  }
}
