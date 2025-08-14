import 'package:flutter/material.dart';

import '../../domain/types/app_status_type.dart';
import '../l10n/generated/l10n.dart';
import '../utils/styles/colors/colors_context.dart';

class AppStatusPage extends StatelessWidget {
  const AppStatusPage({super.key, required this.status});
  final AppStatusType status;

  @override
  Widget build(BuildContext context) {
    if (status == AppStatusType.open) {
      return const SizedBox.shrink();
    }
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: context.colors.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/find_my_car_logo.png",
              fit: BoxFit.fitHeight,
              width: size.width * 0.6,
            ),
            const SizedBox(height: 70),
            Text(
              _getStatusTitle(context, status),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: size.width * 0.65,
              child: Text(
                _getStatusDescription(context, status),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: size.height * 0.2),
          ],
        ),
      ),
    );
  }

  String _getStatusTitle(BuildContext context, AppStatusType status) {
    return status.map(
      open: () => '',
      close: () => S.of(context).pageAppStatus_titleClose,
      maintenance: () => S.of(context).pageAppStatus_titleMaintenance,
    );
  }

  String _getStatusDescription(BuildContext context, AppStatusType status) {
    return status.map(
      open: () => '',
      close: () => S.of(context).pageAppStatus_descClose,
      maintenance: () => S.of(context).pageAppStatus_descMaintenance,
    );
  }
}
