import 'package:chuck/src/models/joke_search_results.dart';
import 'package:chuck/src/services/api/dio/jokes_api_dio.dart';
import 'package:chuck/src/services/api/jokes_api.dart';
import 'package:chuck/src/services/api/result.dart';
import 'package:flutter/foundation.dart';

class JokeSearchProvider extends ChangeNotifier {
  bool _searchPerformed = false; //used to hold whether a search has been run yet, if not, we won't show 'no results found'
  bool get searchPerformed => _searchPerformed;

  set searchPerformed(bool value) {
    _searchPerformed = value;
    notifyListeners();
  }

  bool _busy = false;

  set busy(bool value) {
    _busy = value;
    notifyListeners();
  }

  bool get busy => _busy;

  JokeSearchResults? _jokeSearchResults;

  JokeSearchResults? get jokeSearchResults => _jokeSearchResults;

  set jokeSearchResults(JokeSearchResults? value) {
    _jokeSearchResults = value;
    notifyListeners();
  }

  String _errorMessage = '';

  String get errorMessage => _errorMessage;

  set errorMessage(String value) {
    _errorMessage = value;
    notifyListeners();
  }

  /// SearchForAJoke
  /// This searches for jokes from the api and either sets the results or an error message if there's a failure
  Future<void> jokeSearch(String searchString) async {
    if (searchString.length < 3) {
      //this would probably be a separate validation method if things were more complicated
      errorMessage = 'Search must be longer than 2 characters';
    } else {
      busy = true;
      _jokeSearchResults = null; //reset the results
      _errorMessage = ''; //reset the error message
      final JokesApi chuckNorrisApi = JokesApiDio();
      final result = await chuckNorrisApi.getSearchJokeResults(searchString: searchString);
      busy = false;
      _searchPerformed = true; //at least one search has now been performed
      final value = switch (result) {
        Success(value: final jokeQueryResult) => jokeSearchResults = jokeQueryResult,
        Failure(exception: final exception) => _handleFailure(exception),
      };
      if (kDebugMode) {
        print('jokeSearch $value');
      }
    }
  }

  /// Handle the failure by setting a fake joke to replace the real one
  /// Also location to handle exception logging/reporting of errors
  _handleFailure(Exception exception) {
    //todo for a real app would need to consider how to report that there's failures, maybe crashlytics or to an analytics package
    if (kDebugMode) {
      print('error exception type: $exception');
    }
    errorMessage = 'Unable to perform a search at this time, try again later';
  }
}
