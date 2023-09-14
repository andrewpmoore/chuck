import 'package:chuck/src/models/categories.dart';
import 'package:chuck/src/services/api/jokes_api_interface.dart';
import 'package:chuck/src/services/api/result.dart';
import 'package:flutter/foundation.dart';

class CategoryProvider extends ChangeNotifier {

  JokesApi jokesApi;

  CategoryProvider(this.jokesApi);

  Categories? _jokeCategories;
  Categories? get jokeCategories => _jokeCategories;
  set jokeCategories(Categories? value) {
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
    _errorMessage = ''; //reset the error message
    final result = await jokesApi.getJokeCategories();
    final value = switch (result) {
      Success(value: final jokeResult) => jokeCategories = jokeResult,
      Failure(exception: final exception) => _handleFailure(exception),
    };
  }

  /// Handle the failure by setting a fake joke to replace the real one
  /// Also location to handle exception logging/reporting of errors
  _handleFailure(Exception exception) {
    //todo for a real app would need to consider how to report that there's failures, maybe crashlytics or to an analytics package
    //print('error exception type: $exception');
    errorMessage = 'Unable to obtain categories, try again later';
  }


}
