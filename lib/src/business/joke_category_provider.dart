import 'package:chuck/src/models/joke_categories.dart';
import 'package:chuck/src/services/api/dio/jokes_api_dio.dart';
import 'package:chuck/src/services/api/jokes_api.dart';
import 'package:chuck/src/services/api/result.dart';
import 'package:flutter/foundation.dart';

class JokeCategoryProvider extends ChangeNotifier {
  bool _busy = false;

  set busy(bool value) {
    _busy = value;
    notifyListeners();
  }

  bool get busy => _busy;

  JokeCategories? _jokeCategories;

  JokeCategories? get jokeCategories => _jokeCategories;

  set jokeCategories(JokeCategories? value) {
    _jokeCategories = value;
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
  Future<void> getCategoriesSearch() async {
    busy = true;
    _errorMessage = ''; //reset the error message
    final JokesApi chuckNorrisApi = JokesApiDio();
    final result = await chuckNorrisApi.getJokeCategories();
    busy = false;
    final value = switch (result) {
      Success(value: final jokeResult) => jokeCategories = jokeResult,
      Failure(exception: final exception) => _handleFailure(exception),
    };
    if (kDebugMode) {
      print('getCategoriesSearch $value');
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
