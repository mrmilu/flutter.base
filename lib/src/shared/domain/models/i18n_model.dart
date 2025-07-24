class I18nModel {
  final String es;
  final String en;
  I18nModel({
    required this.es,
    required this.en,
  });

  I18nModel copyWith({
    String? es,
    String? en,
  }) {
    return I18nModel(
      es: es ?? this.es,
      en: en ?? this.en,
    );
  }

  @override
  String toString() => 'I18nModel(es: $es, en: $en)';

  @override
  bool operator ==(covariant I18nModel other) {
    if (identical(this, other)) return true;

    return other.es == es && other.en == en;
  }

  @override
  int get hashCode => es.hashCode ^ en.hashCode;

  String getCurrentLanguage(String currentLanguage) {
    if (currentLanguage == 'es') {
      return es;
    } else {
      return en;
    }
  }
}
