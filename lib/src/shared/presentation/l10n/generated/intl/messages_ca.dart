// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ca locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'ca';

  static String m0(minLength) =>
      "Ha de contenir almenys ${minLength} caràcters";

  static String m1(value) => "${value} dies";

  static String m2(value) => "${value} hores";

  static String m3(value) => "${value} minuts";

  static String m4(value) => "${value} mesos";

  static String m5(value) => "${value} anys";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "addressNotReferencedCatastral": MessageLookupByLibrary.simpleMessage(
      "Revisa l\'adreça, no està referenciada cadastralment",
    ),
    "alreadyRegisteredInDatadis": MessageLookupByLibrary.simpleMessage(
      "Ja estàs registrat a Datadis",
    ),
    "cancel": MessageLookupByLibrary.simpleMessage("Cancel·lar"),
    "cancelledByUser": MessageLookupByLibrary.simpleMessage(
      "Cancel·lat per l\'usuari",
    ),
    "contractIsBlocked": MessageLookupByLibrary.simpleMessage(
      "El contracte està bloquejat i no pot ser modificat",
    ),
    "cupsNotContratable": MessageLookupByLibrary.simpleMessage(
      "El CUPS no és contractable",
    ),
    "cupsNotInfo": MessageLookupByLibrary.simpleMessage(
      "No s\'ha trobat informació del CUPS",
    ),
    "cupsNotValid": MessageLookupByLibrary.simpleMessage("El CUPS no és vàlid"),
    "differentCredentials": MessageLookupByLibrary.simpleMessage(
      "Les credencials són diferents",
    ),
    "emailAlreadyInUser": MessageLookupByLibrary.simpleMessage(
      "El correu electrònic ja està en ús",
    ),
    "emailOrPasswordInvalid": MessageLookupByLibrary.simpleMessage(
      "El correu electrònic o la contrasenya són invàlids",
    ),
    "empty": MessageLookupByLibrary.simpleMessage("Buit"),
    "errorAltaDatadis": MessageLookupByLibrary.simpleMessage(
      "Error en donar d\'alta a Datadis",
    ),
    "errorUploadFileOCR": MessageLookupByLibrary.simpleMessage(
      "Error en carregar l\'arxiu, torna-ho a intentar",
    ),
    "extensions": MessageLookupByLibrary.simpleMessage(
      "--------Extensions--------",
    ),
    "extras_section": MessageLookupByLibrary.simpleMessage(
      "---------Extres---------",
    ),
    "fileNotFound": MessageLookupByLibrary.simpleMessage(
      "L\'arxiu no existeix",
    ),
    "getDocumentError": MessageLookupByLibrary.simpleMessage(
      "No s\'ha pogut obtenir el document, intenta-ho de nou més tard",
    ),
    "ibanInvalid": MessageLookupByLibrary.simpleMessage("L\'IBAN no és vàlid"),
    "ibanTooLong": MessageLookupByLibrary.simpleMessage(
      "L\'IBAN és massa llarg",
    ),
    "ibanTooShort": MessageLookupByLibrary.simpleMessage(
      "L\'IBAN és massa curt",
    ),
    "includeDigit": MessageLookupByLibrary.simpleMessage(
      "Ha d\'incloure almenys un caràcter especial",
    ),
    "includeLowercase": MessageLookupByLibrary.simpleMessage(
      "Ha d\'incloure almenys una lletra minúscula",
    ),
    "includeUppercase": MessageLookupByLibrary.simpleMessage(
      "Ha d\'incloure almenys una lletra majúscula",
    ),
    "internalError": MessageLookupByLibrary.simpleMessage("Error intern"),
    "invalidCredentials": MessageLookupByLibrary.simpleMessage(
      "Credencials invàlides",
    ),
    "invalidCups": MessageLookupByLibrary.simpleMessage("CUPS invàlid"),
    "invalidEmail": MessageLookupByLibrary.simpleMessage(
      "Correu electrònic invàlid",
    ),
    "invalidName": MessageLookupByLibrary.simpleMessage("Nom invàlid"),
    "invalidPhone": MessageLookupByLibrary.simpleMessage("Telèfon invàlid"),
    "minLength": m0,
    "minutes": MessageLookupByLibrary.simpleMessage("minuts"),
    "mismatchedEmail": MessageLookupByLibrary.simpleMessage(
      "Els correus electrònics no coincideixen",
    ),
    "mismatchedPasswords": MessageLookupByLibrary.simpleMessage(
      "Les contrasenyes no coincideixen",
    ),
    "needFieldsRequired": MessageLookupByLibrary.simpleMessage(
      "Falten camps requerits",
    ),
    "nieInvalid": MessageLookupByLibrary.simpleMessage("El NIE no és vàlid"),
    "nifInvalid": MessageLookupByLibrary.simpleMessage("El NIF no és vàlid"),
    "nonExistentUserAndPassword": MessageLookupByLibrary.simpleMessage(
      "No existeix cap usuari registrat amb aquest correu electrònic.",
    ),
    "notSupported": MessageLookupByLibrary.simpleMessage("No compatible"),
    "operationNotAllowed": MessageLookupByLibrary.simpleMessage(
      "Operació no permesa",
    ),
    "pageAppStatus": MessageLookupByLibrary.simpleMessage(
      "---------Estat de l\'aplicació---------",
    ),
    "pageAppStatus_descClose": MessageLookupByLibrary.simpleMessage(
      "Estem treballant per tornar a obrir l’aplicació tan aviat com sigui possible.",
    ),
    "pageAppStatus_descMaintenance": MessageLookupByLibrary.simpleMessage(
      "Estem resolent problemes tècnics. Tornarem a obrir l’aplicació tan aviat com sigui possible.",
    ),
    "pageAppStatus_titleClose": MessageLookupByLibrary.simpleMessage(
      "App tancada temporalment",
    ),
    "pageAppStatus_titleMaintenance": MessageLookupByLibrary.simpleMessage(
      "En manteniment",
    ),
    "pageNotConnection": MessageLookupByLibrary.simpleMessage(
      "---------Pàgina Sense Connexió---------",
    ),
    "pageNotConnection_desc": MessageLookupByLibrary.simpleMessage(
      "Si us plau, revisa la teva connexió a internet i torna-ho a intentar",
    ),
    "pageNotConnection_title": MessageLookupByLibrary.simpleMessage(
      "No tens connexió a internet",
    ),
    "pageSplash": MessageLookupByLibrary.simpleMessage(
      "---------Pàgina de càrrega---------",
    ),
    "pageSplashReload": MessageLookupByLibrary.simpleMessage(
      "Tornar a carregar",
    ),
    "pageSplashUpdate": MessageLookupByLibrary.simpleMessage("Actualitzar"),
    "pageSplashUpdateAvailable": MessageLookupByLibrary.simpleMessage(
      "Actualització disponible",
    ),
    "pageSplashUpdateAvailableDesc": MessageLookupByLibrary.simpleMessage(
      "Hi ha una nova versió de l\'aplicació disponible. Actualitza per gaudir de les últimes funcions i millores.",
    ),
    "pageSplash_progress1": MessageLookupByLibrary.simpleMessage(
      "Comprovant actualitzacions",
    ),
    "pageSplash_progress2": MessageLookupByLibrary.simpleMessage(
      "Comprovant connexió",
    ),
    "pageSplash_progress3": MessageLookupByLibrary.simpleMessage(
      "Carregant dades",
    ),
    "pageSplash_progress4": MessageLookupByLibrary.simpleMessage(
      "Preparant l\'entorn",
    ),
    "pages": MessageLookupByLibrary.simpleMessage(
      "---------==========PÀGINES=========---------",
    ),
    "passwordRequired": MessageLookupByLibrary.simpleMessage(
      "La contrasenya ha de tenir almenys un número i almenys una lletra majúscula i una minúscula.",
    ),
    "powerIsLess": MessageLookupByLibrary.simpleMessage(
      "El valor és inferior al mínim permès",
    ),
    "powerIsMore": MessageLookupByLibrary.simpleMessage(
      "El valor és superior al màxim permès",
    ),
    "powerIsNotValid": MessageLookupByLibrary.simpleMessage(
      "El valor no és vàlid",
    ),
    "problemWithSaveFile": MessageLookupByLibrary.simpleMessage(
      "Hi ha hagut un problema en desar l\'arxiu",
    ),
    "requiredProduct": MessageLookupByLibrary.simpleMessage(
      "Producte requerit",
    ),
    "serverError": MessageLookupByLibrary.simpleMessage("Error del servidor"),
    "sesionExpired": MessageLookupByLibrary.simpleMessage("Sessió caducada"),
    "signupError": MessageLookupByLibrary.simpleMessage(
      "No s\'ha pogut completar el registre. Si ja tens un compte, intenta iniciar sessió.",
    ),
    "time": MessageLookupByLibrary.simpleMessage(
      "-----------==========TIME=========-----------",
    ),
    "time_days": m1,
    "time_hours": m2,
    "time_lessThanOneMinute": MessageLookupByLibrary.simpleMessage(
      "Menys d’un minut",
    ),
    "time_minutes": m3,
    "time_months": m4,
    "time_oneDay": MessageLookupByLibrary.simpleMessage("1 dia"),
    "time_oneHour": MessageLookupByLibrary.simpleMessage("1 hora"),
    "time_oneMinute": MessageLookupByLibrary.simpleMessage("1 minut"),
    "time_oneMonth": MessageLookupByLibrary.simpleMessage("1 mes"),
    "time_oneYear": MessageLookupByLibrary.simpleMessage("1 any"),
    "time_years": m5,
    "tooLong": MessageLookupByLibrary.simpleMessage("Massa llarg"),
    "tooShort": MessageLookupByLibrary.simpleMessage("Massa curt"),
    "unauthorized": MessageLookupByLibrary.simpleMessage("No autoritzat"),
    "unknownError": MessageLookupByLibrary.simpleMessage("Error desconegut"),
    "weakPassword": MessageLookupByLibrary.simpleMessage("Contrasenya feble"),
  };
}
