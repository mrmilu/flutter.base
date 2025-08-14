enum DocumentType {
  nif,
  nie;

  const DocumentType();

  R map<R>({
    required R Function() nie,
    required R Function() nif,
  }) {
    switch (this) {
      case DocumentType.nie:
        return nie();
      case DocumentType.nif:
        return nif();
    }
  }

  @override
  String toString() {
    switch (this) {
      case DocumentType.nie:
        return 'NIE';
      case DocumentType.nif:
        return 'NIF';
    }
  }

  static DocumentType fromString(String status) {
    switch (status) {
      case 'NIE':
        return DocumentType.nie;
      case 'NIF':
        return DocumentType.nif;
      default:
        return DocumentType.nif;
    }
  }
}
