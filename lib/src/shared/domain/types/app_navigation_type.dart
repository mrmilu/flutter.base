import 'package:flutter/material.dart';

import '../../../shared/helpers/extensions.dart';

enum AppNavigationType {
  home(iconPath: 'assets/icons/main_home.svg'),
  invoices(iconPath: 'assets/icons/main_invoices.svg'),
  efforts(iconPath: 'assets/icons/main_effors.svg'),
  ente(iconPath: 'assets/icons/main_ente.png');

  final String iconPath;
  const AppNavigationType({required this.iconPath});

  R map<R>({
    required R Function() home,
    required R Function() ente,
    required R Function() invoices,
    required R Function() efforts,
  }) {
    switch (this) {
      case AppNavigationType.home:
        return home();
      case AppNavigationType.ente:
        return ente();
      case AppNavigationType.invoices:
        return invoices();
      case AppNavigationType.efforts:
        return efforts();
    }
  }

  @override
  String toString() {
    switch (this) {
      case AppNavigationType.home:
        return 'Hogar';
      case AppNavigationType.ente:
        return 'Ente';
      case AppNavigationType.invoices:
        return 'Invoices';
      case AppNavigationType.efforts:
        return 'Efforts';
    }
  }

  static AppNavigationType fromString(String status) {
    switch (status) {
      case 'Hogar':
        return AppNavigationType.home;
      case 'Ente':
        return AppNavigationType.ente;
      case 'Invoices':
        return AppNavigationType.invoices;
      case 'Efforts':
        return AppNavigationType.efforts;
      default:
        return AppNavigationType.home;
    }
  }

  String toTranslate(BuildContext context) {
    switch (this) {
      case AppNavigationType.home:
        return context.cl.translate('navigation.home');
      case AppNavigationType.ente:
        return context.cl.translate('navigation.ente');
      case AppNavigationType.invoices:
        return context.cl.translate('navigation.invoices');
      case AppNavigationType.efforts:
        return context.cl.translate('navigation.efforts');
    }
  }

  int getIndexRouting() {
    switch (this) {
      case AppNavigationType.home:
        return 0;
      case AppNavigationType.invoices:
        return 1;
      case AppNavigationType.efforts:
        return 2;
      case AppNavigationType.ente:
        return 3;
    }
  }

  static List<AppNavigationType> getNavigationOptions({
    required bool isClient,
  }) {
    if (isClient) {
      // Mostrar todas las opciones si es cliente
      return AppNavigationType.values;
    } else {
      // Mostrar solo "home" y "ente" si no es cliente
      return [
        AppNavigationType.home,
        AppNavigationType.ente,
      ];
    }
  }
}
