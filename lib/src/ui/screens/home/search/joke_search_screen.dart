import 'package:chuck/main.dart';
import 'package:chuck/src/business/search_provider.dart';
import 'package:chuck/src/ui/resources/ui_constants.dart';
import 'package:chuck/src/ui/resources/ui_extensions/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';

class JokeSearchScreen extends StatelessWidget {
  const JokeSearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SearchProvider(jokesApi),
      child: _JokeSearch(),
    );
  }
}

/// basic structure of search page with the search field at the top and the results at the bottom
class _JokeSearch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        gapH16,
        _SearchFieldView(),
        gapH16,
        _SearchResults(),
      ],
    );
  }
}

class _SearchFieldView extends StatefulWidget {
  const _SearchFieldView({Key? key}) : super(key: key);

  @override
  State<_SearchFieldView> createState() => _SearchFieldViewState();
}

class _SearchFieldViewState extends State<_SearchFieldView> {
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        gapW16,
        Expanded(
          child: TextField(
            controller: textEditingController,
            textInputAction: TextInputAction.search,
            onSubmitted: (String value) async {
              _performSearch();
            },
            maxLength: 120,
            autocorrect: true,
            decoration: InputDecoration(
              hintText: context.loc!.searchPrompt,
              filled: true,
              counterText: '',
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
              // prefixIcon: const Icon(
              //   LucideIcons.search,
              //   size: 20,
              // ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: context.colorScheme.onBackground.withOpacity(0.2), width: 1),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: context.colorScheme.onBackground.withOpacity(0.2), width: 1),
              ),
            ),
          ),
        ),
        FloatingActionButton(
          onPressed: () {
            _performSearch();
          },
          mini: true,
          tooltip: context.loc!.search,
          elevation: 0,
          child: const Icon(LucideIcons.search),
        ),
        gapW16,
      ],
    );
  }

  ///Handle calling the provider to make the call from either the search button on the keyboard or pressing the search button
  void _performSearch() {
    hideKeyboard(context);
    context.read<SearchProvider>().jokeSearch(textEditingController.text);
  }

  /// hide the keyboard when a search is run
  void hideKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }
}

class _SearchResults extends StatefulWidget {
  const _SearchResults({Key? key}) : super(key: key);

  @override
  State<_SearchResults> createState() => _SearchResultsState();
}

class _SearchResultsState extends State<_SearchResults> {
  @override
  Widget build(BuildContext context) {
    // return context.read<JokeSearchProvider>().busy ? const Center(child: CircularProgressIndicator.adaptive(),) : const Text('results here');
    SearchProvider provider = Provider.of<SearchProvider>(context);
    if (provider.busy) {
      return const Center(child: CircularProgressIndicator.adaptive());
    } else if (!provider.searchPerformed) {
      return const SizedBox();
    } else if (provider.errorMessage.isNotEmpty) {
      return Text(provider.errorMessage);
    } else if (provider.searchPerformed && provider.jokeSearchResults?.total == 0) {
      return Text(context.loc!.noResultsFound);
    } else {
      return Expanded(
        child: ListView.builder(
            itemCount: provider.jokeSearchResults?.total ?? 0,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  provider.jokeSearchResults!.result![index].value ?? '',
                  style: context.style.bodyMedium,
                ),
                leading: Text(
                  '${index + 1}.',
                  style: context.style.bodyMedium,
                ),
              );
            }),
      );
    }
  }
}
