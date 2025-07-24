import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class CustomLocalization {
  final Map<String, dynamic> _localizedStrings;

  CustomLocalization(this._localizedStrings);

  /// Traduce una clave a su texto correspondiente.
  ///
  /// [key] es la clave de la traducción.
  /// [args] son los argumentos opcionales para interpolar valores en el texto.
  ///
  /// Ejemplo:
  /// - 'pages.mainHome.title', {'name': 'Daniel'} → 'Bienvenido, Daniel!'
  /// - 'pages.mainInvoices.title' → 'Facturas'
  dynamic translate(String key, [Map<String, dynamic>? args]) {
    List<String> keys = key.split('.');
    dynamic value = _localizedStrings;

    for (String k in keys) {
      if (value is Map && value.containsKey(k)) {
        value = value[k];
      } else {
        return key;
      }
    }

    if (value is String) {
      if (args != null) {
        args.forEach((argKey, argValue) {
          value = value.replaceAll('{$argKey}', argValue.toString());
        });
      }
      return value;
    } else if (value is Map) {
      return key;
    } else {
      return key;
    }
  }

  dynamic translateToLength(String key) {
    List<String> keys = key.split('.');
    dynamic value = _localizedStrings;
    for (String k in keys) {
      if (value is Map && value.containsKey(k)) {
        value = value[k];
      } else {
        return key;
      }
    }
    if (value is String) {
      return value;
    } else if (value is Map) {
      return value;
    } else {
      return key;
    }
  }

  int getLength(String key) {
    dynamic value = translateToLength(key);
    if (value is Map) {
      return value.length;
    }
    return 0;
  }

  static Future<CustomLocalization> load(String locale) async {
    try {
      // final response =
      //     await Dio().get('https://example.com/translations/intl_$locale.arb');

      // if (response.statusCode == 200) {
      //   final Map<String, dynamic> jsonMap = jsonDecode(response.data);
      //   final Map<String, String> localizedStrings =
      //       jsonMap.map((key, value) => MapEntry(key, value.toString()));
      //   return CustomLocalization(localizedStrings);
      // } else {
      //   return CustomLocalization(defaultJsonES);
      // }
      return _getLocalization(locale);
    } catch (e) {
      return _getLocalization(locale);
    }
  }

  static CustomLocalization of(BuildContext context) {
    return Localizations.of<CustomLocalization>(context, CustomLocalization)!;
  }
}

class CustomLocalizationDelegate
    extends LocalizationsDelegate<CustomLocalization> {
  final String locale;

  CustomLocalizationDelegate(this.locale);

  @override
  bool isSupported(Locale locale) => true;

  @override
  Future<CustomLocalization> load(Locale locale) =>
      CustomLocalization.load(this.locale);

  @override
  bool shouldReload(LocalizationsDelegate<CustomLocalization> old) => false;
}

Future<CustomLocalization> _getLocalization(String locale) async {
  debugPrint('Locale: $locale');

  late String assetPath;
  late String countryAssetPath;
  switch (locale) {
    case 'es':
      assetPath = 'assets/lang/es.json';
      countryAssetPath = 'assets/lang/countries/countries_es.json';
      break;
    case 'en':
      assetPath = 'assets/lang/en.json';
      countryAssetPath = 'assets/lang/countries/countries_en.json';
      break;
    case 'ca':
      assetPath = 'assets/lang/ca.json';
      countryAssetPath = 'assets/lang/countries/countries_ca.json';
      break;
    case 'eu':
      assetPath = 'assets/lang/eu.json';
      countryAssetPath = 'assets/lang/countries/countries_eu.json';
      break;
    case 'gl':
      assetPath = 'assets/lang/gl.json';
      countryAssetPath = 'assets/lang/countries/countries_gl.json';
      break;
    default:
      assetPath = 'assets/lang/es.json';
      countryAssetPath = 'assets/lang/countries/countries_es.json';
  }
  final jsonString = await rootBundle.loadString(assetPath);
  final Map<String, dynamic> jsonMap = json.decode(jsonString);

  final countryJsonString = await rootBundle.loadString(countryAssetPath);
  final Map<String, dynamic> countryJsonMap = json.decode(countryJsonString);

  final Map<String, dynamic> countries = jsonMap['countries'] ?? {};
  countries.addAll(countryJsonMap);
  jsonMap['countries'] = countries;
  return CustomLocalization(jsonMap);
}
