import '../../presentation/helpers/either.dart';
import '../../presentation/helpers/value_object.dart';
import '../failures/iban_failure.dart';

class IbanVos extends ValueObject<IbanFailure, String> {
  @override
  final Either<IbanFailure, String> value;

  factory IbanVos(String input) {
    return IbanVos._(
      _validate(input.trim()),
    );
  }
  const IbanVos._(this.value);

  static Either<IbanFailure, String> _validate(String input) {
    const ibanRegex = r'^[A-Z]{2}[0-9]{2}[A-Z0-9]{1,30}$';

    if (input.length > 24) {
      return left(IbanFailure.tooLong(length: input.length));
    }

    if (input.length < 24) {
      return left(IbanFailure.tooShort(length: input.length));
    }

    if (!RegExp(ibanRegex).hasMatch(input)) {
      return left(const IbanFailure.invalidFormat());
    }

    // Validate IBAN checksum using mod-97 algorithm
    if (!_isValidIbanChecksum(input)) {
      return left(const IbanFailure.invalidChecksum());
    }

    // For Spanish IBANs, also validate national control digits
    if (input.startsWith('ES') && !_isValidSpanishControlDigits(input)) {
      return left(const IbanFailure.invalidChecksum());
    }

    return right(input);
  }

  /// Validates IBAN checksum using mod-97 algorithm
  static bool _isValidIbanChecksum(String iban) {
    if (iban.isEmpty) return false;

    // Clean and convert to uppercase
    final cleaned = iban.replaceAll(RegExp(r'\s+'), '').toUpperCase();

    // Basic format check
    if (!RegExp(r'^[A-Z]{2}[0-9]{2}[A-Z0-9]{1,30}$').hasMatch(cleaned)) {
      return false;
    }

    // Rearrange: move first 4 characters to end
    final rearranged = cleaned.substring(4) + cleaned.substring(0, 4);

    // Convert letters to numbers (A=10, B=11, ..., Z=35)
    final numeric = rearranged
        .split('')
        .map(
          (ch) => RegExp(r'[A-Z]').hasMatch(ch)
              ? (ch.codeUnitAt(0) - 55).toString()
              : ch,
        )
        .join('');

    // Calculate mod 97 in chunks to handle large numbers
    String remainder = '';
    for (int i = 0; i < numeric.length; i += 9) {
      final chunk = numeric.substring(
        i,
        (i + 9 < numeric.length) ? i + 9 : numeric.length,
      );
      remainder = (int.parse(remainder + chunk) % 97).toString();
    }

    return int.parse(remainder) == 1;
  }

  /// Validates Spanish national control digits (positions 8-9 in IBAN)
  /// Spanish IBAN format: ES69 2100 0418 45 3524919564
  /// Where: ES=country, 69=IBAN check, 2100=bank, 0418=branch, 45=control digits, 3524919564=account
  static bool _isValidSpanishControlDigits(String iban) {
    if (!iban.startsWith('ES') || iban.length != 24) return false;

    // Extract components
    final bankCode = iban.substring(4, 8); // 2100
    final branchCode = iban.substring(8, 12); // 0418
    final controlDigits = iban.substring(12, 14); // 45
    final accountNumber = iban.substring(14, 24); // 3524919564

    // Calculate DC1 (first control digit) - for bank + branch
    final dc1Expected = _calculateSpanishControlDigit('00$bankCode$branchCode');

    // Calculate DC2 (second control digit) - for account number
    final dc2Expected = _calculateSpanishControlDigit(accountNumber);

    final expectedControlDigits = '$dc1Expected$dc2Expected';

    return controlDigits == expectedControlDigits;
  }

  /// Calculates Spanish control digit using the algorithm used in Spain
  /// Based on weights: 1,2,4,8,5,10,9,7,3,6
  static int _calculateSpanishControlDigit(String digits) {
    const weights = [1, 2, 4, 8, 5, 10, 9, 7, 3, 6];

    // Pad with zeros to make it 10 digits
    final paddedDigits = digits.padLeft(10, '0');

    int sum = 0;
    for (int i = 0; i < 10; i++) {
      sum += int.parse(paddedDigits[i]) * weights[i];
    }

    final remainder = sum % 11;

    // Spanish control digit rules
    if (remainder < 2) {
      return remainder;
    } else {
      return 11 - remainder;
    }
  }
}
