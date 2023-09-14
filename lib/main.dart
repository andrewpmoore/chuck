import 'package:chuck/src/business/settings_provider.dart';
import 'package:chuck/src/services/api/dio/jokes_api_dio.dart';
import 'package:chuck/src/services/api/jokes_api_interface.dart';
import 'package:chuck/src/services/settings_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'src/app.dart';


final JokesApi jokesApi = JokesApiDio(Dio());

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  // Set up the SettingsController, which will glue user settings to multiple
  // Flutter Widgets.
  final settingsController = SettingsProvider(SettingsService());

  // Load the user's preferred theme while the splash screen is displayed.
  // This prevents a sudden theme change when the app is first displayed.
  await settingsController.loadSettings();




  // Run the app and pass in the SettingsController. The app listens to the
  // SettingsController for changes, then passes it further down to the
  // SettingsView.
  runApp(MyApp(settingsController: settingsController));
}
