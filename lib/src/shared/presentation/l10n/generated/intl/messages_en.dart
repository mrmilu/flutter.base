// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  static String m0(minLength) =>
      "Must contain at least ${minLength} characters";

  static String m1(value) => "${value} days";

  static String m2(value) => "${value} hours";

  static String m3(value) => "${value} minutes";

  static String m4(value) => "${value} months";

  static String m5(value) => "${value} years";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "addressNotReferencedCatastral": MessageLookupByLibrary.simpleMessage(
      "Check the address, it is not cadastral referenced",
    ),
    "alreadyRegisteredInDatadis": MessageLookupByLibrary.simpleMessage(
      "You are already registered in Datadis",
    ),
    "appSettingsError": MessageLookupByLibrary.simpleMessage(
      "Error in app settings",
    ),
    "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
    "cancelledByUser": MessageLookupByLibrary.simpleMessage(
      "Cancelled by user",
    ),
    "contractIsBlocked": MessageLookupByLibrary.simpleMessage(
      "The contract is blocked and cannot be modified",
    ),
    "cupsNotContratable": MessageLookupByLibrary.simpleMessage(
      "The CUPS cannot be contracted",
    ),
    "cupsNotInfo": MessageLookupByLibrary.simpleMessage(
      "No CUPS information was found",
    ),
    "cupsNotValid": MessageLookupByLibrary.simpleMessage(
      "The CUPS is not valid",
    ),
    "differentCredentials": MessageLookupByLibrary.simpleMessage(
      "The credentials are different",
    ),
    "emailAlreadyInUser": MessageLookupByLibrary.simpleMessage(
      "The email address is already in use",
    ),
    "emailOrPasswordInvalid": MessageLookupByLibrary.simpleMessage(
      "Invalid email or password",
    ),
    "empty": MessageLookupByLibrary.simpleMessage("Empty"),
    "errorAltaDatadis": MessageLookupByLibrary.simpleMessage(
      "Error registering in Datadis",
    ),
    "errorUploadFileOCR": MessageLookupByLibrary.simpleMessage(
      "Error uploading the file, please try again",
    ),
    "extensions": MessageLookupByLibrary.simpleMessage(
      "--------Extensions--------",
    ),
    "extras_section": MessageLookupByLibrary.simpleMessage(
      "---------Extras---------",
    ),
    "fileNotFound": MessageLookupByLibrary.simpleMessage("File not found"),
    "getDocumentError": MessageLookupByLibrary.simpleMessage(
      "Unable to retrieve the document, please try again later",
    ),
    "ibanInvalid": MessageLookupByLibrary.simpleMessage(
      "The IBAN is not valid",
    ),
    "ibanTooLong": MessageLookupByLibrary.simpleMessage("IBAN is too long"),
    "ibanTooShort": MessageLookupByLibrary.simpleMessage("IBAN is too short"),
    "includeDigit": MessageLookupByLibrary.simpleMessage(
      "Must include at least one special character",
    ),
    "includeLowercase": MessageLookupByLibrary.simpleMessage(
      "Must include at least one lowercase letter",
    ),
    "includeUppercase": MessageLookupByLibrary.simpleMessage(
      "Must include at least one uppercase letter",
    ),
    "internalError": MessageLookupByLibrary.simpleMessage("Internal error"),
    "invalidCredentials": MessageLookupByLibrary.simpleMessage(
      "Invalid credentials",
    ),
    "invalidCups": MessageLookupByLibrary.simpleMessage("Invalid CUPS"),
    "invalidEmail": MessageLookupByLibrary.simpleMessage(
      "Invalid email address",
    ),
    "invalidName": MessageLookupByLibrary.simpleMessage("Invalid name"),
    "invalidPhone": MessageLookupByLibrary.simpleMessage(
      "Invalid phone number",
    ),
    "invalidSurname": MessageLookupByLibrary.simpleMessage("Invalid surname"),
    "minLength": m0,
    "minutes": MessageLookupByLibrary.simpleMessage("minutes"),
    "mismatchedEmail": MessageLookupByLibrary.simpleMessage(
      "Email addresses do not match",
    ),
    "mismatchedPasswords": MessageLookupByLibrary.simpleMessage(
      "Passwords do not match",
    ),
    "needFieldsRequired": MessageLookupByLibrary.simpleMessage(
      "Required fields are missing",
    ),
    "nieInvalid": MessageLookupByLibrary.simpleMessage("The NIE is not valid"),
    "nifInvalid": MessageLookupByLibrary.simpleMessage("The NIF is not valid"),
    "nonExistentUserAndPassword": MessageLookupByLibrary.simpleMessage(
      "There is no user registered with this email address.",
    ),
    "notSupported": MessageLookupByLibrary.simpleMessage("Not supported"),
    "operationNotAllowed": MessageLookupByLibrary.simpleMessage(
      "Operation not allowed",
    ),
    "pageAppStatus": MessageLookupByLibrary.simpleMessage(
      "---------Page App Status---------",
    ),
    "pageAppStatus_descClose": MessageLookupByLibrary.simpleMessage(
      "We are currently working to reopen the app as soon as possible.",
    ),
    "pageAppStatus_descMaintenance": MessageLookupByLibrary.simpleMessage(
      "We are fixing technical issues. The app will be available again shortly.",
    ),
    "pageAppStatus_titleClose": MessageLookupByLibrary.simpleMessage(
      "App temporarily closed",
    ),
    "pageAppStatus_titleMaintenance": MessageLookupByLibrary.simpleMessage(
      "Under maintenance",
    ),
    "pageNotConnection": MessageLookupByLibrary.simpleMessage(
      "---------Page No Connection---------",
    ),
    "pageNotConnection_desc": MessageLookupByLibrary.simpleMessage(
      "Please check your internet connection and try again",
    ),
    "pageNotConnection_title": MessageLookupByLibrary.simpleMessage(
      "No internet connection",
    ),
    "pageSplash": MessageLookupByLibrary.simpleMessage(
      "---------Page Splash---------",
    ),
    "pageSplashReload": MessageLookupByLibrary.simpleMessage("Reload"),
    "pageSplashUpdate": MessageLookupByLibrary.simpleMessage("Update"),
    "pageSplashUpdateAvailable": MessageLookupByLibrary.simpleMessage(
      "Update available",
    ),
    "pageSplashUpdateAvailableDesc": MessageLookupByLibrary.simpleMessage(
      "A new version of the app is available. Please update to enjoy the latest features and improvements.",
    ),
    "pageSplash_progress1": MessageLookupByLibrary.simpleMessage(
      "Checking for updates",
    ),
    "pageSplash_progress2": MessageLookupByLibrary.simpleMessage(
      "Checking connection",
    ),
    "pageSplash_progress3": MessageLookupByLibrary.simpleMessage(
      "Loading data",
    ),
    "pageSplash_progress4": MessageLookupByLibrary.simpleMessage(
      "Preparing environment",
    ),
    "pages": MessageLookupByLibrary.simpleMessage(
      "---------==========PAGES=========---------",
    ),
    "passwordRequired": MessageLookupByLibrary.simpleMessage(
      "The password must contain at least one number, one uppercase letter, and one lowercase letter.",
    ),
    "powerIsLess": MessageLookupByLibrary.simpleMessage(
      "The value is below the allowed minimum",
    ),
    "powerIsMore": MessageLookupByLibrary.simpleMessage(
      "The value is above the allowed maximum",
    ),
    "powerIsNotValid": MessageLookupByLibrary.simpleMessage(
      "The value is not valid",
    ),
    "problemWithSaveFile": MessageLookupByLibrary.simpleMessage(
      "There was a problem saving the file",
    ),
    "requiredProduct": MessageLookupByLibrary.simpleMessage("Product required"),
    "serverError": MessageLookupByLibrary.simpleMessage("Server error"),
    "sesionExpired": MessageLookupByLibrary.simpleMessage("Session expired"),
    "signupError": MessageLookupByLibrary.simpleMessage(
      "Registration could not be completed. If you already have an account, please try logging in.",
    ),
    "time": MessageLookupByLibrary.simpleMessage(
      "-----------==========TIME=========-----------",
    ),
    "time_days": m1,
    "time_hours": m2,
    "time_lessThanOneMinute": MessageLookupByLibrary.simpleMessage(
      "Less than a minute",
    ),
    "time_minutes": m3,
    "time_months": m4,
    "time_oneDay": MessageLookupByLibrary.simpleMessage("1 day"),
    "time_oneHour": MessageLookupByLibrary.simpleMessage("1 hour"),
    "time_oneMinute": MessageLookupByLibrary.simpleMessage("1 minute"),
    "time_oneMonth": MessageLookupByLibrary.simpleMessage("1 month"),
    "time_oneYear": MessageLookupByLibrary.simpleMessage("1 year"),
    "time_years": m5,
    "tooLong": MessageLookupByLibrary.simpleMessage("Too long"),
    "tooShort": MessageLookupByLibrary.simpleMessage("Too short"),
    "unauthorized": MessageLookupByLibrary.simpleMessage("Unauthorized"),
    "unknownError": MessageLookupByLibrary.simpleMessage("Unknown error"),
    "weakPassword": MessageLookupByLibrary.simpleMessage("Weak password"),
  };
}
