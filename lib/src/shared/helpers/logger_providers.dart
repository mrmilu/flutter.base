// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class ProvidersLogger extends ProviderObserver {
//   const ProvidersLogger();

//   /// A provider was initialized, and the value exposed is [value].
//   @override
//   void didAddProvider(
//     ProviderBase provider,
//     Object? value,
//     ProviderContainer container,
//   ) {
//     debugPrint(
//       '''
// {
//   Provider ADDED ===
//   "provider": "${provider.name ?? provider.runtimeType}",
//   "value": "$value"
// }''',
//     );
//   }

//   @override
//   void didUpdateProvider(
//     ProviderBase provider,
//     Object? previousValue,
//     Object? newValue,
//     ProviderContainer container,
//   ) {
//     debugPrint(
//       '''
// {
//   Provider UPDATED ===
//   "provider": "${provider.name ?? provider.runtimeType}",
//   "newValue": "$newValue"
// }''',
//     );
//   }

//   /// A provider was disposed
//   @override
//   void didDisposeProvider(
//     ProviderBase provider,
//     ProviderContainer containers,
//   ) {
//     debugPrint(
//       '''
// {
//   Provider DISPOSED ===
//   "provider": "${provider.name ?? provider.runtimeType}"
// }''',
//     );
//   }
// }
