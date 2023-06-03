import 'package:package_info_plus/package_info_plus.dart';

class Appversions {
  getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo ;

  }

}