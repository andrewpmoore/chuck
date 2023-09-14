import 'package:chuck/main.dart';
import 'package:chuck/src/business/category_provider.dart';
import 'package:chuck/src/business/joke_provider.dart';
import 'package:chuck/src/models/joke.dart';
import 'package:chuck/src/ui/resources/ui_constants.dart';
import 'package:chuck/src/ui/resources/ui_extensions/build_context_extension.dart';
import 'package:chuck/src/ui/resources/ui_extensions/string_extensions.dart';
import 'package:chuck/src/ui/widgets/joke_display.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class JokeCategoryScreen extends StatelessWidget {
  const JokeCategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CategoryProvider(jokesApi),
        ),
        ChangeNotifierProvider(
          create: (context) => JokeProvider(jokesApi),
        ),
      ],
      child: const _JokeCategories(),
    );
  }
}


class _JokeCategories extends StatelessWidget {
  const _JokeCategories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        gapH16,
        _CategoryDropDown(),
        gapH16,
        Expanded(child: SingleChildScrollView(child: _JokeDisplay())),
      ],
    );
  }
}


class _CategoryDropDown extends StatefulWidget {
  const _CategoryDropDown({Key? key}) : super(key: key);

  @override
  State<_CategoryDropDown> createState() => _CategoryDropDownState();
}

class _CategoryDropDownState extends State<_CategoryDropDown> {


  // String dropdownValue = '';


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _getInitialCategories();
  }

  void _getInitialCategories() async {
    CategoryProvider categoryProvider = Provider.of<CategoryProvider>(context);
    JokeProvider randomProvider = Provider.of<JokeProvider>(context);
    if (randomProvider.joke!=null){
      return;
    }
    await categoryProvider.getCategoriesSearch();
    randomProvider.fetchAJoke(category: categoryProvider.jokeCategories?.categories.first);
  }


  @override
  Widget build(BuildContext context) {
    CategoryProvider provider = Provider.of<CategoryProvider>(context);
    if (provider.jokeCategories==null) {
      return const Center(child: CircularProgressIndicator.adaptive(),);
    }


    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Categories'),
        gapW16,
        DropdownMenu<String>(
          initialSelection: provider.jokeCategories!.categories.first,
          onSelected: (String? value) {
            // This is called when the user selects an item.
            JokeProvider provider = Provider.of<JokeProvider>(context, listen: false);
            provider.fetchAJoke(category: value);
          },
          dropdownMenuEntries: provider.jokeCategories!.categories.map<DropdownMenuEntry<String>>((String value) {
            return DropdownMenuEntry<String>(value: value, label: value.capitalize());
          }).toList(),
        ),
      ],
    );
  }



}


class _JokeDisplay extends StatelessWidget {
  const _JokeDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool busy = context.watch<JokeProvider>().busy;
    Joke? joke = context.watch<JokeProvider>().joke;
    if (busy){
      return const Center(child: CircularProgressIndicator.adaptive(),);
    }
    else {
      return JokeDisplay(joke: joke, key: ValueKey('${joke?.value ?? ''}_${context.isAppInDarkMode}'),);
    }

  }
}


