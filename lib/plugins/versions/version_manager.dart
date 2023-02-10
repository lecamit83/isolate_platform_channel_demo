import 'dart:io';

import 'package:isolate_background/plugins/versions/version.dart';
import 'package:isolate_background/plugins/versions/version_android.dart';
import 'package:isolate_background/plugins/versions/version_ios.dart';

class VersionManager {
  VersionManager() {
    if(Platform.isAndroid) {
      Version.instance = VersionAndroid();
    } else if(Platform.isIOS) {
      Version.instance = VersionIOS();
    }
  }

  static Version get _platform {
    return Version.instance;
  }

  Future<String> getAppVersionName() async => _platform.getAppVersionName();
  Future<String> getAppVersionBuild() async => _platform.getAppVersionBuild();
}