import 'package:isolate_background/plugins/versions/version.dart';

class VersionAndroid extends Version {
  @override
  Future<String> getAppVersionName() {
    throw UnimplementedError();
  }

  @override
  Future<String> getAppVersionBuild() {
    throw UnimplementedError();
  }
}