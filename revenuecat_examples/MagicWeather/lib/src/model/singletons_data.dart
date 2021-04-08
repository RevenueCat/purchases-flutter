import 'weather_data.dart';

class AppData {
  static final AppData _appData = AppData._internal();

  bool entitlementIsActive = false;
  String appUserID = '';
  WeatherData currentData = WeatherData.testCold;

  factory AppData() {
    return _appData;
  }
  AppData._internal();
}

final appData = AppData();
