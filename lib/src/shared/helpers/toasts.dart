import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

import '../presentation/utils/extensions/buildcontext_extensions.dart';
import '../presentation/utils/styles/colors.dart';

void showError(
  BuildContext context, {
  required String message,
  int duration = 2,
}) => Flushbar(
  message: message,
  margin: const EdgeInsets.all(20),
  borderRadius: BorderRadius.circular(4),
  backgroundColor: AppColors.specificSemanticError,
  icon: const Icon(
    Icons.error_outline,
    color: Colors.white,
  ),
  duration: Duration(
    seconds: duration,
  ),
)..show(context);

void showSuccess(BuildContext context, {required String message}) => Flushbar(
  message: message,
  margin: const EdgeInsets.all(20),
  borderRadius: BorderRadius.circular(20),
  icon: const Icon(
    Icons.done,
    size: 28.0,
    color: Colors.green,
  ),
  duration: const Duration(
    seconds: 3,
  ),
)..show(context);

void showInfo(BuildContext context, {required String message}) => Flushbar(
  message: message,
  margin: const EdgeInsets.all(20),
  borderRadius: BorderRadius.circular(20),
  icon: const Icon(
    Icons.info_outline,
    color: Colors.lightBlueAccent,
  ),
  duration: const Duration(
    seconds: 2,
  ),
)..show(context);

void showInfoWithButton(
  BuildContext context, {
  required String message,
  required VoidCallback onTap,
}) => Flushbar(
  message: message,
  margin: const EdgeInsets.all(20),
  borderRadius: BorderRadius.circular(20),
  icon: const Icon(
    Icons.info_outline,
    color: Colors.lightBlueAccent,
  ),
  duration: const Duration(
    seconds: 4,
  ),
  mainButton: TextButton(
    onPressed: onTap,
    child: Text(
      context.cl.translate('change'),
      style: const TextStyle(color: Colors.white),
    ),
  ),
)..show(context);

// void showToastCenter(BuildContext context, {required String message}) {
//   Widget toast = Text(
//     message,
//     style: const TextStyle(
//       color: Colors.white,
//       fontSize: 18,
//       fontWeight: FontWeight.bold,
//       shadows: [
//         Shadow(
//           blurRadius: 15.0,
//           color: Colors.black,
//           offset: Offset(2.0, 2.0),
//         ),
//       ],
//     ),
//   ).animate().slideY();

//   // To remove present shwoing toast
//   FToast().init(context).removeCustomToast();

//   // To clear the queue
//   FToast().init(context).removeQueuedCustomToasts();

//   FToast().init(context).showToast(
//         child: toast,
//         gravity: ToastGravity.CENTER,
//         toastDuration: const Duration(seconds: 2),
//       );
// }
