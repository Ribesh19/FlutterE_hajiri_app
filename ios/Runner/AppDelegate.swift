import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    //added
    GMSServices.provideAPIKey("AIzaSyDTWmTYiSVGA8EskTj-ORQbRAu1GrNZBpM")
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
