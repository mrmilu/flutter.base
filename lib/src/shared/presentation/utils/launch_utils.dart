import 'dart:io';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> launchEmailApp([BuildContext? context]) async {
  try {
    if (Platform.isIOS) {
      // En iOS, intenta abrir Mail app directamente
      const String iosMailUrl = 'message://';
      if (await canLaunchUrl(Uri.parse(iosMailUrl))) {
        await launchUrl(Uri.parse(iosMailUrl));
      } else {
        // Fallback: abre la app de Mail con un esquema alternativo
        const String iosMailAlt = 'x-apple-mail://';
        await launchUrl(Uri.parse(iosMailAlt));
      }
    } else if (Platform.isAndroid) {
      // En Android, abre la aplicación de email sin crear un correo nuevo
      const String androidEmailIntent = 'android-app://com.google.android.gm/';
      if (await canLaunchUrl(Uri.parse(androidEmailIntent))) {
        await launchUrl(Uri.parse(androidEmailIntent));
      } else {
        // Fallback: intenta con el intent genérico de email
        const String genericEmailIntent = 'mailto:';
        await launchUrl(Uri.parse(genericEmailIntent));
      }
    } else {
      // Para otras plataformas (web, desktop), usa mailto sin parámetros
      await launchUrl(Uri.parse('mailto:'));
    }
  } catch (e) {
    // Si falla todo, muestra un mensaje de error o maneja según sea necesario
    debugPrint('Error al abrir la aplicación de email: $e');
    // Fallback final: intenta con mailto básico
    await launchUrl(Uri.parse('mailto:'));
  }
}
