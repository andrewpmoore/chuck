
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

  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  int currentPageIndex = 0;


  @override
  Widget build(BuildContext context) {

    //get the orientation to determine whether to show a NavigationBar or NavigationRail
    final orientation = MediaQuery.of(context).orientation;

    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      appBar: AppBar(
        title: Text(context.loc!.homeTitle),
        actions: [
          IconButton(
            tooltip: context.loc!.settings,
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
      bottomNavigationBar: orientation==Orientation.portrait ? NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            //set the current index page and refresh state
            currentPageIndex = index;
          });
        },
        indicatorColor: context.colorScheme.secondaryContainer,
        selectedIndex: currentPageIndex,
        destinations: <Widget>[
          NavigationDestination(
            icon: const Icon(Icons.home_outlined),
            label: context.loc!.home,
          ),
          NavigationDestination(
            icon: const Icon(LucideIcons.search),
            label: context.loc!.search,
          ),
          NavigationDestination(
            icon: const Icon(LucideIcons.grid),
            label: context.loc!.categories,
          ),
        ],
      ) : null,
        body: Row(children: [
          if (orientation==Orientation.landscape) NavigationRail(
            selectedIndex: currentPageIndex,
            // groupAlignment: groupAlignment,
            onDestinationSelected: (int index) {
              setState(() {
                currentPageIndex = index;
              });
            },
            labelType: NavigationRailLabelType.all,
            destinations: <NavigationRailDestination>[
              NavigationRailDestination(
                icon: const Icon(Icons.home_outlined),
                label: Text(context.loc!.home),
              ),
              NavigationRailDestination(
                icon: const Icon(LucideIcons.search),
                label: Text(context.loc!.search),
              ),
              NavigationRailDestination(
                icon: const Icon(LucideIcons.grid),
                label: Text(context.loc!.categories),
              ),
            ],
          ),
          if (orientation==Orientation.landscape) VerticalDivider(width: 1, color: context.colorScheme.primaryContainer),
            Expanded(
            child: IndexedStack(index: currentPageIndex, children: const [
              RandomJokeScreen(),
              JokeSearchScreen(),
              JokeCategoryScreen(),
            ]),
          )

        ],),
    );
  }
}


