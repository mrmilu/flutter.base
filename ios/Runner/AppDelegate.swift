import Flutter
import UIKit
import AppsFlyerLib
import Firebase 

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {

  private func configureFirebase() {
    if FirebaseApp.app() == nil {
      FirebaseApp.configure()
    }
  }
  
  
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    configureFirebase()
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
    configureFirebase()
    GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)
  }

     // Open URI-scheme for iOS 9 and above
  override func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
      NSLog("AppsFlyer [deep link]: Open URI-scheme for iOS 9 and above")
      AppsFlyerLib.shared().handleOpen(url, sourceApplication: sourceApplication, withAnnotation: annotation)
      return true
  }

     // Reports app open from deep link for iOS 10 or later
  override func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
      NSLog("AppsFlyer [deep link]: continue userActivity")
      AppsFlyerLib.shared().continue(userActivity, restorationHandler: nil)
      return true
  }
  
  override func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
      NSLog("AppsFlyer [deep link]: Open URI-scheme options")
      AppsFlyerLib.shared().handleOpen(url, options: options)
      return true
  }
}

 