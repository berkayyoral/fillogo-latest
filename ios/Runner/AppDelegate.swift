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
    OneSignal.initialize("43ddc771-f2eb-4ecf-bcc8-95434809b1dc", withLaunchOptions: launchOptions)
        
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
