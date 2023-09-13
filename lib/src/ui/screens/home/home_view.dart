
import 'package:chuck/src/ui/resources/ui_extensions/build_context_extension.dart';
import 'package:chuck/src/ui/screens/home/category/joke_category_screen.dart';
import 'package:chuck/src/ui/screens/home/random/random_joke_screen.dart';
import 'package:chuck/src/ui/screens/home/search/joke_search_screen.dart';
import 'package:chuck/src/ui/screens/settings/settings_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons/lucide_icons.dart';

/// Displays a list of SampleItems.
class HomeView extends StatefulWidget {

  static const routeName = '/';

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  int currentPageIndex = 0;


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
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          indicatorColor: context.colorScheme.secondaryContainer,
          selectedIndex: currentPageIndex,
          destinations: <Widget>[
            NavigationDestination(
              selectedIcon: const Icon(Icons.home),
              icon: const Icon(Icons.home_outlined),
              label: context.loc!.home,
            ),
            NavigationDestination(
              icon: const Icon(LucideIcons.search),
              label: context.loc!.search,
            ),
            NavigationDestination(
              selectedIcon: const Icon(LucideIcons.grid),
              icon: const Icon(LucideIcons.grid),
              label: context.loc!.categories,
            ),
          ],
        ),

      body: IndexedStack(index: currentPageIndex, children: const [
        RandomJokeScreen(),
        JokeSearchScreen(),
        JokeCategoryScreen(),
      ]),
    );
  }
}
