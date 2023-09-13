
import 'package:chuck/src/ui/resources/ui_extensions/build_context_extension.dart';
import 'package:chuck/src/ui/screens/settings/settings_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons/lucide_icons.dart';

/// Displays a list of SampleItems.
class HomeView extends StatelessWidget {

  static const routeName = '/';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.loc!.homeTitle),
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.settings2),
            onPressed: () {
              // Navigate to the settings page. If the user leaves and returns
              // to the app after it has been killed while running in the
              // background, the navigation stack is restored.
              HapticFeedback.selectionClick();
              Navigator.restorablePushNamed(context, SettingsView.routeName);
            },
          ),
        ],
      ),

      body: Text('Home page'),
    );
  }
}
