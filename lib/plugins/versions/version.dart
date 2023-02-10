import 'package:flutter/cupertino.dart';
import 'package:isolate_background/plugins/versions/version_android.dart';
import 'package:isolate_background/plugins/versions/version_ios.dart';

abstract class Version {
  /// Constructs a Platform.
  Version();

  static late Version _instance;

  /// The default instance
  static Version get instance => _instance;


  static set instance(Version instance) {
    debugPrint("VERSION_SET: $instance");
    _instance = instance;
  }

  Future<VersionAndroid> androidVersion() {
    throw UnimplementedError('androidVersion() has not been implemented.');
  }

  Future<VersionIOS> iOSVersion() {
    throw UnimplementedError('iOSVersion() has not been implemented.');
  }

  Future<String> getAppVersionName() {
    throw UnimplementedError();
  }

  Future<String> getAppVersionBuild() {
    throw UnimplementedError();
  }
}