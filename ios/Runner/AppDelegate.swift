import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

     // Open URI-scheme for iOS 9 and above
  override func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
      NSLog("AppsFlyer [deep link]: Open URI-scheme for iOS 9 and above")
      AppsFlyerAttribution.shared()!.handleOpenUrl(url, sourceApplication: sourceApplication, annotation: annotation);
      return true
  }

     // Reports app open from deep link for iOS 10 or later
  override func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
      NSLog("AppsFlyer [deep link]: continue userActivity")
      AppsFlyerAttribution.shared()!.continueUserActivity(userActivity, restorationHandler:nil )
         return true
  }
  
  override func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
      NSLog("AppsFlyer [deep link]: Open URI-scheme options")
      AppsFlyerAttribution.shared()!.handleOpenUrl(url, options: options)
         return true
  }
}
