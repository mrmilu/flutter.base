// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `--------Extensions--------`
  String get extensions {
    return Intl.message(
      '--------Extensions--------',
      name: 'extensions',
      desc: '',
      args: [],
    );
  }

  /// `Vacío`
  String get empty {
    return Intl.message('Vacío', name: 'empty', desc: '', args: []);
  }

  /// `CUPS inválido`
  String get invalidCups {
    return Intl.message(
      'CUPS inválido',
      name: 'invalidCups',
      desc: '',
      args: [],
    );
  }

  /// `Correo electrónico inválido`
  String get invalidEmail {
    return Intl.message(
      'Correo electrónico inválido',
      name: 'invalidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Teléfono inválido`
  String get invalidPhone {
    return Intl.message(
      'Teléfono inválido',
      name: 'invalidPhone',
      desc: '',
      args: [],
    );
  }

  /// `Demasiado largo`
  String get tooLong {
    return Intl.message('Demasiado largo', name: 'tooLong', desc: '', args: []);
  }

  /// `Nombre inválido`
  String get invalidName {
    return Intl.message(
      'Nombre inválido',
      name: 'invalidName',
      desc: '',
      args: [],
    );
  }

  /// `Apellido inválido`
  String get invalidSurname {
    return Intl.message(
      'Apellido inválido',
      name: 'invalidSurname',
      desc: '',
      args: [],
    );
  }

  /// `Demasiado corto`
  String get tooShort {
    return Intl.message(
      'Demasiado corto',
      name: 'tooShort',
      desc: '',
      args: [],
    );
  }

  /// `Error en la configuración de la aplicación.`
  String get appSettingsError {
    return Intl.message(
      'Error en la configuración de la aplicación.',
      name: 'appSettingsError',
      desc: '',
      args: [],
    );
  }

  /// `No se ha podido completar el registro. Si ya tienes una cuenta, intenta iniciar sesión.`
  String get signupError {
    return Intl.message(
      'No se ha podido completar el registro. Si ya tienes una cuenta, intenta iniciar sesión.',
      name: 'signupError',
      desc: '',
      args: [],
    );
  }

  /// `La contraseña debe tener al menos un número y al menos una letra mayúscula y una minúscula.`
  String get passwordRequired {
    return Intl.message(
      'La contraseña debe tener al menos un número y al menos una letra mayúscula y una minúscula.',
      name: 'passwordRequired',
      desc: '',
      args: [],
    );
  }

  /// `Las contraseñas no coinciden`
  String get mismatchedPasswords {
    return Intl.message(
      'Las contraseñas no coinciden',
      name: 'mismatchedPasswords',
      desc: '',
      args: [],
    );
  }

  /// `Los correos electrónicos no coinciden`
  String get mismatchedEmail {
    return Intl.message(
      'Los correos electrónicos no coinciden',
      name: 'mismatchedEmail',
      desc: '',
      args: [],
    );
  }

  /// `No existe ningún usuario registrado con este correo electrónico.`
  String get nonExistentUserAndPassword {
    return Intl.message(
      'No existe ningún usuario registrado con este correo electrónico.',
      name: 'nonExistentUserAndPassword',
      desc: '',
      args: [],
    );
  }

  /// `Error del servidor`
  String get serverError {
    return Intl.message(
      'Error del servidor',
      name: 'serverError',
      desc: '',
      args: [],
    );
  }

  /// `Error interno`
  String get internalError {
    return Intl.message(
      'Error interno',
      name: 'internalError',
      desc: '',
      args: [],
    );
  }

  /// `No autorizado`
  String get unauthorized {
    return Intl.message(
      'No autorizado',
      name: 'unauthorized',
      desc: '',
      args: [],
    );
  }

  /// `Sesión expirada`
  String get sesionExpired {
    return Intl.message(
      'Sesión expirada',
      name: 'sesionExpired',
      desc: '',
      args: [],
    );
  }

  /// `El correo electrónico ya está en uso`
  String get emailAlreadyInUser {
    return Intl.message(
      'El correo electrónico ya está en uso',
      name: 'emailAlreadyInUser',
      desc: '',
      args: [],
    );
  }

  /// `El correo electrónico o la contraseña son inválidos`
  String get emailOrPasswordInvalid {
    return Intl.message(
      'El correo electrónico o la contraseña son inválidos',
      name: 'emailOrPasswordInvalid',
      desc: '',
      args: [],
    );
  }

  /// `Operación no permitida`
  String get operationNotAllowed {
    return Intl.message(
      'Operación no permitida',
      name: 'operationNotAllowed',
      desc: '',
      args: [],
    );
  }

  /// `Ya estás registrado en Datadis`
  String get alreadyRegisteredInDatadis {
    return Intl.message(
      'Ya estás registrado en Datadis',
      name: 'alreadyRegisteredInDatadis',
      desc: '',
      args: [],
    );
  }

  /// `Contraseña débil`
  String get weakPassword {
    return Intl.message(
      'Contraseña débil',
      name: 'weakPassword',
      desc: '',
      args: [],
    );
  }

  /// `minutos`
  String get minutes {
    return Intl.message('minutos', name: 'minutes', desc: '', args: []);
  }

  /// `Las credenciales son diferentes`
  String get differentCredentials {
    return Intl.message(
      'Las credenciales son diferentes',
      name: 'differentCredentials',
      desc: '',
      args: [],
    );
  }

  /// `Credenciales inválidas`
  String get invalidCredentials {
    return Intl.message(
      'Credenciales inválidas',
      name: 'invalidCredentials',
      desc: '',
      args: [],
    );
  }

  /// `Cancelado por el usuario`
  String get cancelledByUser {
    return Intl.message(
      'Cancelado por el usuario',
      name: 'cancelledByUser',
      desc: '',
      args: [],
    );
  }

  /// `Producto requerido`
  String get requiredProduct {
    return Intl.message(
      'Producto requerido',
      name: 'requiredProduct',
      desc: '',
      args: [],
    );
  }

  /// `Error desconocido`
  String get unknownError {
    return Intl.message(
      'Error desconocido',
      name: 'unknownError',
      desc: '',
      args: [],
    );
  }

  /// `No se pudo obtener el documento, intenténtalo de nuevo más tarde`
  String get getDocumentError {
    return Intl.message(
      'No se pudo obtener el documento, intenténtalo de nuevo más tarde',
      name: 'getDocumentError',
      desc: '',
      args: [],
    );
  }

  /// `No soportado`
  String get notSupported {
    return Intl.message(
      'No soportado',
      name: 'notSupported',
      desc: '',
      args: [],
    );
  }

  /// `Cancelar`
  String get cancel {
    return Intl.message('Cancelar', name: 'cancel', desc: '', args: []);
  }

  /// `Debe contener al menos {minLength} caracteres`
  String minLength(Object minLength) {
    return Intl.message(
      'Debe contener al menos $minLength caracteres',
      name: 'minLength',
      desc: '',
      args: [minLength],
    );
  }

  /// `Debe incluir al menos una mayúscula`
  String get includeUppercase {
    return Intl.message(
      'Debe incluir al menos una mayúscula',
      name: 'includeUppercase',
      desc: '',
      args: [],
    );
  }

  /// `Debe incluir al menos una minúscula`
  String get includeLowercase {
    return Intl.message(
      'Debe incluir al menos una minúscula',
      name: 'includeLowercase',
      desc: '',
      args: [],
    );
  }

  /// `Debe incluir al menos un carácter especial`
  String get includeDigit {
    return Intl.message(
      'Debe incluir al menos un carácter especial',
      name: 'includeDigit',
      desc: '',
      args: [],
    );
  }

  /// `El IBAN es demasiado largo`
  String get ibanTooLong {
    return Intl.message(
      'El IBAN es demasiado largo',
      name: 'ibanTooLong',
      desc: '',
      args: [],
    );
  }

  /// `El IBAN es demasiado corto`
  String get ibanTooShort {
    return Intl.message(
      'El IBAN es demasiado corto',
      name: 'ibanTooShort',
      desc: '',
      args: [],
    );
  }

  /// `El IBAN no es válido`
  String get ibanInvalid {
    return Intl.message(
      'El IBAN no es válido',
      name: 'ibanInvalid',
      desc: '',
      args: [],
    );
  }

  /// `El NIF no es válido`
  String get nifInvalid {
    return Intl.message(
      'El NIF no es válido',
      name: 'nifInvalid',
      desc: '',
      args: [],
    );
  }

  /// `El NIE no es válido`
  String get nieInvalid {
    return Intl.message(
      'El NIE no es válido',
      name: 'nieInvalid',
      desc: '',
      args: [],
    );
  }

  /// `El archivo no existe`
  String get fileNotFound {
    return Intl.message(
      'El archivo no existe',
      name: 'fileNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Hubo un problema al guardar el archivo`
  String get problemWithSaveFile {
    return Intl.message(
      'Hubo un problema al guardar el archivo',
      name: 'problemWithSaveFile',
      desc: '',
      args: [],
    );
  }

  /// `Faltan campos requeridos`
  String get needFieldsRequired {
    return Intl.message(
      'Faltan campos requeridos',
      name: 'needFieldsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Revisa la dirección, no está referenciada catastralmente`
  String get addressNotReferencedCatastral {
    return Intl.message(
      'Revisa la dirección, no está referenciada catastralmente',
      name: 'addressNotReferencedCatastral',
      desc: '',
      args: [],
    );
  }

  /// `El CUPS no es contratable`
  String get cupsNotContratable {
    return Intl.message(
      'El CUPS no es contratable',
      name: 'cupsNotContratable',
      desc: '',
      args: [],
    );
  }

  /// `No se ha encontrado información del CUPS`
  String get cupsNotInfo {
    return Intl.message(
      'No se ha encontrado información del CUPS',
      name: 'cupsNotInfo',
      desc: '',
      args: [],
    );
  }

  /// `El CUPS no es válido`
  String get cupsNotValid {
    return Intl.message(
      'El CUPS no es válido',
      name: 'cupsNotValid',
      desc: '',
      args: [],
    );
  }

  /// `El contrato está bloqueado y no puede ser modificado`
  String get contractIsBlocked {
    return Intl.message(
      'El contrato está bloqueado y no puede ser modificado',
      name: 'contractIsBlocked',
      desc: '',
      args: [],
    );
  }

  /// `El valor es inferior al mínimo permitido`
  String get powerIsLess {
    return Intl.message(
      'El valor es inferior al mínimo permitido',
      name: 'powerIsLess',
      desc: '',
      args: [],
    );
  }

  /// `El valor es superior al máximo permitido`
  String get powerIsMore {
    return Intl.message(
      'El valor es superior al máximo permitido',
      name: 'powerIsMore',
      desc: '',
      args: [],
    );
  }

  /// `El valor no es válido`
  String get powerIsNotValid {
    return Intl.message(
      'El valor no es válido',
      name: 'powerIsNotValid',
      desc: '',
      args: [],
    );
  }

  /// `Error al dar de alta en Datadis`
  String get errorAltaDatadis {
    return Intl.message(
      'Error al dar de alta en Datadis',
      name: 'errorAltaDatadis',
      desc: '',
      args: [],
    );
  }

  /// `Error al cargar el archivo, vuelve a intentarlo`
  String get errorUploadFileOCR {
    return Intl.message(
      'Error al cargar el archivo, vuelve a intentarlo',
      name: 'errorUploadFileOCR',
      desc: '',
      args: [],
    );
  }

  /// `-----------==========TIME=========-----------`
  String get time {
    return Intl.message(
      '-----------==========TIME=========-----------',
      name: 'time',
      desc: '',
      args: [],
    );
  }

  /// `Menos de un minuto`
  String get time_lessThanOneMinute {
    return Intl.message(
      'Menos de un minuto',
      name: 'time_lessThanOneMinute',
      desc: '',
      args: [],
    );
  }

  /// `1 minuto`
  String get time_oneMinute {
    return Intl.message('1 minuto', name: 'time_oneMinute', desc: '', args: []);
  }

  /// `{value} minutos`
  String time_minutes(Object value) {
    return Intl.message(
      '$value minutos',
      name: 'time_minutes',
      desc: '',
      args: [value],
    );
  }

  /// `1 hora`
  String get time_oneHour {
    return Intl.message('1 hora', name: 'time_oneHour', desc: '', args: []);
  }

  /// `{value} horas`
  String time_hours(Object value) {
    return Intl.message(
      '$value horas',
      name: 'time_hours',
      desc: '',
      args: [value],
    );
  }

  /// `1 día`
  String get time_oneDay {
    return Intl.message('1 día', name: 'time_oneDay', desc: '', args: []);
  }

  /// `{value} días`
  String time_days(Object value) {
    return Intl.message(
      '$value días',
      name: 'time_days',
      desc: '',
      args: [value],
    );
  }

  /// `1 mes`
  String get time_oneMonth {
    return Intl.message('1 mes', name: 'time_oneMonth', desc: '', args: []);
  }

  /// `{value} meses`
  String time_months(Object value) {
    return Intl.message(
      '$value meses',
      name: 'time_months',
      desc: '',
      args: [value],
    );
  }

  /// `1 año`
  String get time_oneYear {
    return Intl.message('1 año', name: 'time_oneYear', desc: '', args: []);
  }

  /// `{value} años`
  String time_years(Object value) {
    return Intl.message(
      '$value años',
      name: 'time_years',
      desc: '',
      args: [value],
    );
  }

  /// `---------==========PAGES=========---------`
  String get pages {
    return Intl.message(
      '---------==========PAGES=========---------',
      name: 'pages',
      desc: '',
      args: [],
    );
  }

  /// `---------Page Not Connection---------`
  String get pageNotConnection {
    return Intl.message(
      '---------Page Not Connection---------',
      name: 'pageNotConnection',
      desc: '',
      args: [],
    );
  }

  /// `No tienes conexión a internet`
  String get pageNotConnection_title {
    return Intl.message(
      'No tienes conexión a internet',
      name: 'pageNotConnection_title',
      desc: '',
      args: [],
    );
  }

  /// `Por favor, revisa tu conexión a internet y vuelve a intentarlo`
  String get pageNotConnection_desc {
    return Intl.message(
      'Por favor, revisa tu conexión a internet y vuelve a intentarlo',
      name: 'pageNotConnection_desc',
      desc: '',
      args: [],
    );
  }

  /// `---------Page App Status---------`
  String get pageAppStatus {
    return Intl.message(
      '---------Page App Status---------',
      name: 'pageAppStatus',
      desc: '',
      args: [],
    );
  }

  /// `App cerrada temporalmente`
  String get pageAppStatus_titleClose {
    return Intl.message(
      'App cerrada temporalmente',
      name: 'pageAppStatus_titleClose',
      desc: '',
      args: [],
    );
  }

  /// `En mantenimiento`
  String get pageAppStatus_titleMaintenance {
    return Intl.message(
      'En mantenimiento',
      name: 'pageAppStatus_titleMaintenance',
      desc: '',
      args: [],
    );
  }

  /// `Estamos trabajando y estudiando para volver a abrir la aplicación lo antes posible.`
  String get pageAppStatus_descClose {
    return Intl.message(
      'Estamos trabajando y estudiando para volver a abrir la aplicación lo antes posible.',
      name: 'pageAppStatus_descClose',
      desc: '',
      args: [],
    );
  }

  /// `Estamos resolviendo problemas técnicos. Volveremos a abrir la aplicación lo antes posible.`
  String get pageAppStatus_descMaintenance {
    return Intl.message(
      'Estamos resolviendo problemas técnicos. Volveremos a abrir la aplicación lo antes posible.',
      name: 'pageAppStatus_descMaintenance',
      desc: '',
      args: [],
    );
  }

  /// `---------Page Splash---------`
  String get pageSplash {
    return Intl.message(
      '---------Page Splash---------',
      name: 'pageSplash',
      desc: '',
      args: [],
    );
  }

  /// `Actualización disponible`
  String get pageSplashUpdateAvailable {
    return Intl.message(
      'Actualización disponible',
      name: 'pageSplashUpdateAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Una nueva versión de la aplicación está disponible. Actualice para disfrutar de las últimas funciones y mejoras.`
  String get pageSplashUpdateAvailableDesc {
    return Intl.message(
      'Una nueva versión de la aplicación está disponible. Actualice para disfrutar de las últimas funciones y mejoras.',
      name: 'pageSplashUpdateAvailableDesc',
      desc: '',
      args: [],
    );
  }

  /// `Actualizar`
  String get pageSplashUpdate {
    return Intl.message(
      'Actualizar',
      name: 'pageSplashUpdate',
      desc: '',
      args: [],
    );
  }

  /// `Recargar`
  String get pageSplashReload {
    return Intl.message(
      'Recargar',
      name: 'pageSplashReload',
      desc: '',
      args: [],
    );
  }

  /// `Comprobando actualizaciones`
  String get pageSplash_progress1 {
    return Intl.message(
      'Comprobando actualizaciones',
      name: 'pageSplash_progress1',
      desc: '',
      args: [],
    );
  }

  /// `Comprobando conexión`
  String get pageSplash_progress2 {
    return Intl.message(
      'Comprobando conexión',
      name: 'pageSplash_progress2',
      desc: '',
      args: [],
    );
  }

  /// `Cargando datos`
  String get pageSplash_progress3 {
    return Intl.message(
      'Cargando datos',
      name: 'pageSplash_progress3',
      desc: '',
      args: [],
    );
  }

  /// `Preparando entorno`
  String get pageSplash_progress4 {
    return Intl.message(
      'Preparando entorno',
      name: 'pageSplash_progress4',
      desc: '',
      args: [],
    );
  }

  /// `---------Extras---------`
  String get extras_section {
    return Intl.message(
      '---------Extras---------',
      name: 'extras_section',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'es'),
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
