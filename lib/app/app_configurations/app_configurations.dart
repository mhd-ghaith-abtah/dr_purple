import 'package:dr_purple/core/utils/constants.dart';

class AppConfigurations {
  static const String applicationName = "Dr. Purple";
  static const String playStorePackageName = "com.purple.dr";
  static const String appStoreBundleId = "com.purple.dr";
  static const String appStoreId = "";
  static const String appVersion = "1.0.0";

  /// endpoints URLs
  static const String baseUrl = "https://www.drpurple.somee.com/api/";

  /// headers
  static const Map<String, String> baseHeaders = {
    Constants.accept: "*/*",
    Constants.authorization: Constants.empty,
    Constants.contentType: Constants.applicationJson,
  };
}
