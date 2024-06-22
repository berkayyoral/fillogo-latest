import UIKit
import OneSignalFramework
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      GeneratedPluginRegistrant.register(with: self);
      GMSServices.provideAPIKey("AIzaSyAFFLTo2huCvR-HiQTkDIpjJ5Yb-b-erN8");
    OneSignal.Debug.setLogLevel(.LL_VERBOSE)
        
        // OneSignal initialization
    OneSignal.initialize("ef065656-adab-4c84-b66e-245e0bdba8c6", withLaunchOptions: launchOptions)
        
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
