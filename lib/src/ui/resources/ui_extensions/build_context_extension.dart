import 'package:chuck/src/ui/resources/ui_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';



extension BuildContextExtensions on BuildContext {
  AppLocalizations? get loc => AppLocalizations.of(this);
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  TextTheme get style => Theme.of(this).textTheme;

  /// Check if the device is in dark mode
  bool get isDeviceInDarkMode {
    final brightness = MediaQuery.of(this).platformBrightness;
    return brightness == Brightness.dark;
  }

  /// Check if the app is in dark mode
  bool get isAppInDarkMode {
    return Theme.of(this).brightness == Brightness.dark;
  }


  bool isCompactScreen() {
    return MediaQuery.of(this).size.width <= compactSize;
  }

  bool isMediumScreen() {
    return isCompactScreen() == false && MediaQuery.of(this).size.width <= mediumSize;
  }

  bool isExpandedScreen() {
    return MediaQuery.of(this).size.width > mediumSize;
  }

  /// return a `ScreenSize` for handling size logic
  ScreenSize getScreenSize(){
    if (isCompactScreen()){
      return ScreenSize.compact;
    } else if (isMediumScreen()){
      return ScreenSize.medium;
    } else{
      return ScreenSize.expanded;
    }
  }


}
