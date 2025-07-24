// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a gl locale. All the
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
  String get localeName => 'gl';

  static String m0(minLength) => "Debe ter polo menos ${minLength} caracteres";

  static String m1(value) => "${value} días";

  static String m2(value) => "${value} horas";

  static String m3(value) => "${value} minutos";

  static String m4(value) => "${value} meses";

  static String m5(value) => "${value} anos";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "addressNotReferencedCatastral": MessageLookupByLibrary.simpleMessage(
      "Revisa o enderezo, non está referenciado catastralmente",
    ),
    "alreadyRegisteredInDatadis": MessageLookupByLibrary.simpleMessage(
      "Xa estás rexistrado en Datadis",
    ),
    "cancel": MessageLookupByLibrary.simpleMessage("Cancelar"),
    "cancelledByUser": MessageLookupByLibrary.simpleMessage(
      "Cancelado polo usuario",
    ),
    "contractIsBlocked": MessageLookupByLibrary.simpleMessage(
      "O contrato está bloqueado e non pode ser modificado",
    ),
    "cupsNotContratable": MessageLookupByLibrary.simpleMessage(
      "O CUPS non é contratable",
    ),
    "cupsNotInfo": MessageLookupByLibrary.simpleMessage(
      "Non se atopou información do CUPS",
    ),
    "cupsNotValid": MessageLookupByLibrary.simpleMessage("O CUPS non é válido"),
    "differentCredentials": MessageLookupByLibrary.simpleMessage(
      "As credenciais son diferentes",
    ),
    "emailAlreadyInUser": MessageLookupByLibrary.simpleMessage(
      "O correo electrónico xa está en uso",
    ),
    "emailOrPasswordInvalid": MessageLookupByLibrary.simpleMessage(
      "O correo electrónico ou o contrasinal son incorrectos",
    ),
    "empty": MessageLookupByLibrary.simpleMessage("Baleiro"),
    "errorAltaDatadis": MessageLookupByLibrary.simpleMessage(
      "Erro ao dar de alta en Datadis",
    ),
    "errorUploadFileOCR": MessageLookupByLibrary.simpleMessage(
      "Erro ao cargar o ficheiro, ténteo de novo",
    ),
    "extensions": MessageLookupByLibrary.simpleMessage(
      "--------Extensións--------",
    ),
    "extras_section": MessageLookupByLibrary.simpleMessage(
      "---------Extras---------",
    ),
    "fileNotFound": MessageLookupByLibrary.simpleMessage(
      "O ficheiro non existe",
    ),
    "getDocumentError": MessageLookupByLibrary.simpleMessage(
      "Non se puido obter o documento, inténtao de novo máis tarde",
    ),
    "ibanInvalid": MessageLookupByLibrary.simpleMessage("O IBAN non é válido"),
    "ibanTooLong": MessageLookupByLibrary.simpleMessage(
      "O IBAN é demasiado longo",
    ),
    "ibanTooShort": MessageLookupByLibrary.simpleMessage(
      "O IBAN é demasiado curto",
    ),
    "includeDigit": MessageLookupByLibrary.simpleMessage(
      "Debe incluír polo menos un carácter especial",
    ),
    "includeLowercase": MessageLookupByLibrary.simpleMessage(
      "Debe incluír polo menos unha minúscula",
    ),
    "includeUppercase": MessageLookupByLibrary.simpleMessage(
      "Debe incluír polo menos unha maiúscula",
    ),
    "internalError": MessageLookupByLibrary.simpleMessage("Erro interno"),
    "invalidCredentials": MessageLookupByLibrary.simpleMessage(
      "Credenciais incorrectas",
    ),
    "invalidCups": MessageLookupByLibrary.simpleMessage("CUPS incorrecto"),
    "invalidEmail": MessageLookupByLibrary.simpleMessage(
      "Correo electrónico incorrecto",
    ),
    "invalidName": MessageLookupByLibrary.simpleMessage("Nome incorrecto"),
    "invalidPhone": MessageLookupByLibrary.simpleMessage(
      "Número de teléfono incorrecto",
    ),
    "minLength": m0,
    "minutes": MessageLookupByLibrary.simpleMessage("minutos"),
    "mismatchedEmail": MessageLookupByLibrary.simpleMessage(
      "Os correos electrónicos non coinciden",
    ),
    "mismatchedPasswords": MessageLookupByLibrary.simpleMessage(
      "Os contrasinais non coinciden",
    ),
    "needFieldsRequired": MessageLookupByLibrary.simpleMessage(
      "Faltan campos obrigatorios",
    ),
    "nieInvalid": MessageLookupByLibrary.simpleMessage("O NIE non é válido"),
    "nifInvalid": MessageLookupByLibrary.simpleMessage("O NIF non é válido"),
    "nonExistentUserAndPassword": MessageLookupByLibrary.simpleMessage(
      "Non existe ningún usuario rexistrado con este correo electrónico.",
    ),
    "notSupported": MessageLookupByLibrary.simpleMessage("Non admitido"),
    "operationNotAllowed": MessageLookupByLibrary.simpleMessage(
      "Operación non permitida",
    ),
    "pageAppStatus": MessageLookupByLibrary.simpleMessage(
      "---------Estado da aplicación---------",
    ),
    "pageAppStatus_descClose": MessageLookupByLibrary.simpleMessage(
      "Estamos traballando para reabrir a aplicación o antes posible.",
    ),
    "pageAppStatus_descMaintenance": MessageLookupByLibrary.simpleMessage(
      "Estamos resolvendo problemas técnicos. A aplicación volverá estar dispoñible en breve.",
    ),
    "pageAppStatus_titleClose": MessageLookupByLibrary.simpleMessage(
      "Aplicación pechada temporalmente",
    ),
    "pageAppStatus_titleMaintenance": MessageLookupByLibrary.simpleMessage(
      "En mantemento",
    ),
    "pageNotConnection": MessageLookupByLibrary.simpleMessage(
      "---------Sen conexión---------",
    ),
    "pageNotConnection_desc": MessageLookupByLibrary.simpleMessage(
      "Revisa a túa conexión a internet e ténteo de novo",
    ),
    "pageNotConnection_title": MessageLookupByLibrary.simpleMessage(
      "Non tes conexión a internet",
    ),
    "pageSplash": MessageLookupByLibrary.simpleMessage(
      "---------Pantalla de carga---------",
    ),
    "pageSplashReload": MessageLookupByLibrary.simpleMessage("Recargar"),
    "pageSplashUpdate": MessageLookupByLibrary.simpleMessage("Actualizar"),
    "pageSplashUpdateAvailable": MessageLookupByLibrary.simpleMessage(
      "Actualización dispoñible",
    ),
    "pageSplashUpdateAvailableDesc": MessageLookupByLibrary.simpleMessage(
      "Hai unha nova versión da aplicación dispoñible. Actualiza para gozar das últimas funcionalidades e melloras.",
    ),
    "pageSplash_progress1": MessageLookupByLibrary.simpleMessage(
      "Comprobando actualizacións",
    ),
    "pageSplash_progress2": MessageLookupByLibrary.simpleMessage(
      "Comprobando conexión",
    ),
    "pageSplash_progress3": MessageLookupByLibrary.simpleMessage(
      "Cargando datos",
    ),
    "pageSplash_progress4": MessageLookupByLibrary.simpleMessage(
      "Preparando contorno",
    ),
    "pages": MessageLookupByLibrary.simpleMessage(
      "---------==========PÁXINAS=========---------",
    ),
    "passwordRequired": MessageLookupByLibrary.simpleMessage(
      "O contrasinal debe ter polo menos un número, unha letra maiúscula e unha minúscula.",
    ),
    "powerIsLess": MessageLookupByLibrary.simpleMessage(
      "O valor está por debaixo do mínimo permitido",
    ),
    "powerIsMore": MessageLookupByLibrary.simpleMessage(
      "O valor supera o máximo permitido",
    ),
    "powerIsNotValid": MessageLookupByLibrary.simpleMessage(
      "O valor non é válido",
    ),
    "problemWithSaveFile": MessageLookupByLibrary.simpleMessage(
      "Houbo un problema ao gardar o ficheiro",
    ),
    "requiredProduct": MessageLookupByLibrary.simpleMessage(
      "Produto requirido",
    ),
    "serverError": MessageLookupByLibrary.simpleMessage("Erro do servidor"),
    "sesionExpired": MessageLookupByLibrary.simpleMessage("Sesión expirada"),
    "signupError": MessageLookupByLibrary.simpleMessage(
      "Non foi posíbel completar o rexistro. Se xa tes unha conta, intenta iniciar sesión.",
    ),
    "time": MessageLookupByLibrary.simpleMessage(
      "-----------==========TEMPO=========-----------",
    ),
    "time_days": m1,
    "time_hours": m2,
    "time_lessThanOneMinute": MessageLookupByLibrary.simpleMessage(
      "Menos dun minuto",
    ),
    "time_minutes": m3,
    "time_months": m4,
    "time_oneDay": MessageLookupByLibrary.simpleMessage("1 día"),
    "time_oneHour": MessageLookupByLibrary.simpleMessage("1 hora"),
    "time_oneMinute": MessageLookupByLibrary.simpleMessage("1 minuto"),
    "time_oneMonth": MessageLookupByLibrary.simpleMessage("1 mes"),
    "time_oneYear": MessageLookupByLibrary.simpleMessage("1 ano"),
    "time_years": m5,
    "tooLong": MessageLookupByLibrary.simpleMessage("Demasiado longo"),
    "tooShort": MessageLookupByLibrary.simpleMessage("Demasiado curto"),
    "unauthorized": MessageLookupByLibrary.simpleMessage("Non autorizado"),
    "unknownError": MessageLookupByLibrary.simpleMessage("Erro descoñecido"),
    "weakPassword": MessageLookupByLibrary.simpleMessage("Contrasinal feble"),
  };
}
