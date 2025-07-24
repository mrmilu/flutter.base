import 'dart:developer' as dev;

import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

enum CheckoutEvent {
  viewItemList,
  addToCart,
  beginCheckout,
  addShippingInfo,
  addPaymentInfo,
  purchase,
}

/// Helper class for Firebase Analytics operations
/// Provides a clean interface for analytics tracking with error handling
class MyAnalyticsHelper {
  static FirebaseAnalytics get _analytics => FirebaseAnalytics.instance;
  static bool _isInitialized = false;

  /// Initialize Firebase Analytics
  /// Should be called once during app startup
  static Future<void> initialize({bool enableInDebug = false}) async {
    try {
      // Only enable analytics in release mode or if explicitly enabled in debug
      bool appTrackingEnabled = false;
      final status =
          await AppTrackingTransparency.requestTrackingAuthorization();
      if (status == TrackingStatus.authorized ||
          status == TrackingStatus.notSupported) {
        appTrackingEnabled = true;
      }

      final shouldEnable = kReleaseMode ? appTrackingEnabled : enableInDebug;
      await _analytics.setAnalyticsCollectionEnabled(shouldEnable);

      _isInitialized = true;

      if (kDebugMode) {
        dev.log(
          'Analytics initialized - Collection enabled: $shouldEnable',
          name: 'MyAnalyticsHelper',
        );
      }
    } catch (e) {
      if (kDebugMode) {
        dev.log(
          'Failed to initialize analytics: $e',
          name: 'MyAnalyticsHelper',
          error: e,
        );
      }
    }
  }

  /// Set user ID for analytics
  /// [userId] User identifier (max 256 characters)
  static Future<void> setUserId(String? userId) async {
    if (!_isInitialized) return;

    try {
      await _analytics.setUserId(id: userId);

      if (kDebugMode) {
        dev.log(
          'User ID set: ${userId ?? 'null'}',
          name: 'MyAnalyticsHelper',
        );
      }
    } catch (e) {
      if (kDebugMode) {
        dev.log(
          'Failed to set user ID: $e',
          name: 'MyAnalyticsHelper',
          error: e,
        );
      }
    }
  }

  /// Clear user ID (useful for logout)
  static Future<void> clearUserId() async {
    await setUserId(null);
  }

  /// Log screen view
  static Future<void> logScreenView({
    required String screenName,
    String? screenClass,
  }) async {
    await _analytics.logScreenView(
      screenName: screenName,
      screenClass: screenClass,
    );
  }

  /// Log a custom event with optional parameters
  /// [name] Event name (max 40 characters)
  /// [parameters] Event parameters (max 25 parameters, keys max 40 chars, values max 100 chars)
  static Future<void> logEvent({
    required CheckoutEvent name,
  }) async {
    if (!_isInitialized) {
      if (kDebugMode) {
        dev.log(
          'Analytics not initialized. Call initialize() first.',
          name: 'MyAnalyticsHelper',
        );
      }
      return;
    }

    try {
      switch (name) {
        case CheckoutEvent.viewItemList:
          await _analytics.logViewItemList();
          break;
        case CheckoutEvent.addToCart:
          await _analytics.logAddToCart();
          break;
        case CheckoutEvent.beginCheckout:
          await _analytics.logBeginCheckout();
          break;
        case CheckoutEvent.addShippingInfo:
          await _analytics.logAddShippingInfo();
          break;
        case CheckoutEvent.addPaymentInfo:
          await _analytics.logAddPaymentInfo();
          break;
        case CheckoutEvent.purchase:
          await _analytics.logPurchase();
          break;
      }

      if (kDebugMode) {
        dev.log(
          'Event logged: $name}',
          name: 'MyAnalyticsHelper',
        );
      }
    } catch (e) {
      if (kDebugMode) {
        dev.log(
          'Failed to log event "$name": $e',
          name: 'MyAnalyticsHelper',
          error: e,
        );
      }
      await Sentry.addBreadcrumb(
        Breadcrumb(
          message: 'Failed to log event "$name"',
          data: {'error': e.toString()},
          level: SentryLevel.warning,
        ),
      );
    }
  }

  /// Check if analytics is initialized
  static bool get isInitialized => _isInitialized;

  /// Get Firebase Analytics instance for advanced usage
  static FirebaseAnalytics get instance => _analytics;

  // ECOMMERCE EVENTS - Google Analytics 4 Enhanced Ecommerce

  /// Log view_item_list event (cuando se llega a la página de productos)
  /// [itemListId] ID of the item list
  /// [itemListName] Name of the item list
  /// [items] List of items in the list
  static Future<void> logViewItemList() async {
    await logEvent(
      name: CheckoutEvent.viewItemList,
    );
  }

  /// Log add_to_cart event (cuando se selecciona un producto)
  /// [currency] Currency code (e.g., 'EUR', 'USD')
  /// [value] Total value of items added to cart
  /// [items] List of items added to cart
  static Future<void> logAddToCart() async {
    await logEvent(
      name: CheckoutEvent.addToCart,
    );
  }

  /// Log begin_checkout event (cuando se da a continuar tras meter datos personales)
  /// [currency] Currency code
  /// [value] Total value of items in checkout
  /// [items] List of items in checkout
  static Future<void> logBeginCheckout() async {
    await logEvent(
      name: CheckoutEvent.beginCheckout,
    );
  }

  /// Log add_shipping_info event (cuando se da a continuar tras meter CUPS + DIRECCION)
  /// [currency] Currency code
  /// [value] Total value of items
  /// [shippingTier] Shipping method selected
  /// [items] List of items
  static Future<void> logAddShippingInfo() async {
    await logEvent(
      name: CheckoutEvent.addShippingInfo,
    );
  }

  /// Log add_payment_info event (cuando se da a continuar tras meter DNI + IBAN)
  /// [currency] Currency code
  /// [value] Total value of items
  /// [paymentType] Payment method selected
  /// [items] List of items
  static Future<void> logAddPaymentInfo() async {
    await logEvent(
      name: CheckoutEvent.addPaymentInfo,
    );
  }

  /// Log purchase event (después de que el usuario firme el contrato)
  /// [transactionId] Unique transaction ID
  /// [currency] Currency code
  /// [value] Total value of the purchase
  /// [tax] Tax amount
  /// [shipping] Shipping cost
  /// [items] List of purchased items
  static Future<void> logPurchase() async {
    await logEvent(
      name: CheckoutEvent.purchase,
    );
  }
}
