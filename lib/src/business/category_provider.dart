import 'dart:io';

import 'package:chuck/src/models/joke.dart';
import 'package:chuck/src/models/categories.dart';
import 'package:chuck/src/services/api/dio/jokes_api_dio.dart';
import 'package:chuck/src/services/api/jokes_api.dart';
import 'package:chuck/src/services/api/result.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class CategoryProvider extends ChangeNotifier {

  // Joke? _joke;
  // Joke? get joke => _joke;
  // set joke(Joke? value) {
  //   _joke = value;
  //   notifyListeners();
  // }

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


  // String _selectedCategory = '';
  // String get selectedCategory => _selectedCategory;
  // set selectedCategory(String value) {
  //   _selectedCategory = value;
  //
  //   notifyListeners();
  // }

  /// SearchForAJoke
  /// This searches for jokes from the api and either sets the results or an error message if there's a failure
  Future<void> getCategoriesSearch() async {
    _errorMessage = ''; //reset the error message
    final JokesApi chuckNorrisApi = JokesApiDio();
    final result = await chuckNorrisApi.getJokeCategories();
    final value = switch (result) {
      Success(value: final jokeResult) => jokeCategories = jokeResult,
      Failure(exception: final exception) => _handleFailure(exception),
    };
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
