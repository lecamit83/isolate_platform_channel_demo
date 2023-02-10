import 'package:flutter/services.dart';
import 'package:isolate_background/plugins/versions/version.dart';

class VersionIOS extends Version {
  final String _kGetVersionName = "getVersionName";
  final String _kGetVersionBuild = "getVersionNumber";
  final MethodChannel? _methodChannel;

  static VersionIOS? _instance;

  /// Initializes the plugin and starts listening for potential platform events.
  factory VersionIOS() {
    if (_instance == null) {
      const mChannel = MethodChannel('vn.micatek.tutorial/version');
      _instance = VersionIOS._(mChannel);
    }
    return _instance!;
  }

  VersionIOS._(this._methodChannel);

  @override
  Future<String> getAppVersionName() async {
    final String result = await _methodChannel!.invokeMethod(_kGetVersionName);
    return result;
  }

  @override
  Future<String> getAppVersionBuild() async {
    final String result = await _methodChannel!.invokeMethod(_kGetVersionBuild);
    return result;
  }
}
