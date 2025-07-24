import 'dart:convert';

import 'i18n_model.dart';

class IconModel {
  final I18nModel name;
  final String icon;

  IconModel({
    required this.name,
    required this.icon,
  });

  IconModel copyWith({
    I18nModel? name,
    String? icon,
  }) {
    return IconModel(
      name: name ?? this.name,
      icon: icon ?? this.icon,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'icon': icon,
    };
  }

  factory IconModel.fromMap(Map<String, dynamic> map) {
    return IconModel(
      name: map['name'] ?? '',
      icon: map['icon'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory IconModel.fromJson(String source) =>
      IconModel.fromMap(json.decode(source));

  @override
  String toString() => 'IconModel(name: $name, icon: $icon)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is IconModel && other.name == name && other.icon == icon;
  }

  @override
  int get hashCode => name.hashCode ^ icon.hashCode;

  String getName(String languageCode) {
    if (languageCode == 'en') {
      return name.en;
    } else if (languageCode == 'es') {
      return name.es;
    } else {
      return name.en;
    }
  }
}
