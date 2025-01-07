import UIKit
import OneSignalFramework
import flutter_local_notifications
import Flutter
import GoogleMaps


@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    //  FlutterLocalNotificationsPlugin.setPluginRegistrantCallback { (registry) in
    //      GeneratedPluginRegistrant.register(with: registry)
    //  }
      GeneratedPluginRegistrant.register(with: self);
//       if #available(iOS 10.0, *) {
//   UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
// }
      GMSServices.provideAPIKey("AIzaSyB5n4c5gTUMY3NiWTXCcRhdKl82O7Z_Isw");//AIzaSyAFFLTo2huCvR-HiQTkDIpjJ5Yb-b-erN8 - AIzaSyCxZTC2Aw9oWeyck-hD4D4A7z5A1t-iKdA - AIzaSyCDWUImgRbLnMIz_gbUymkeTzufsqN-jME
    OneSignal.Debug.setLogLevel(.LL_VERBOSE)
     // OneSignal initialization
    OneSignal.initialize("ef065656-adab-4c84-b66e-245e0bdba8c6", withLaunchOptions: launchOptions)
       OneSignal.Notifications.requestPermission({ accepted in
         print("User accepted notifications: \(accepted)")
       }, fallbackToSettings: true)

    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
