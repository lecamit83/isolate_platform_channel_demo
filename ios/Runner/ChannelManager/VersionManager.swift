import Foundation

extension Bundle {
  var versionName: String? {
    return self.infoDictionary?["CFBundleShortVersionString"] as? String
  }

  var versionNumber: String? {
    return self.infoDictionary?["CFBundleVersion"] as? String
  }
}

class VersionManager {
  private let channelName: String = "vn.micatek.tutorial/version"
  private var channel: FlutterMethodChannel?

  static let shared: VersionManager = VersionManager()

  func register(with registra: FlutterBinaryMessenger) -> Void {
    channel = FlutterMethodChannel(name: channelName, binaryMessenger: registra)
    channel!.setMethodCallHandler(handler(call:result:))
  }

  func handler(call: FlutterMethodCall, result: FlutterResult) {
    switch(call.method) {
      case "getVersionName":
        result(Bundle.main.versionName)
        break
      case "getVersionNumber":
        result(Bundle.main.versionNumber)
        break
      default:
        result(FlutterMethodNotImplemented)
    }
  }
}
