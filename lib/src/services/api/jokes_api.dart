import 'package:chuck/src/models/joke.dart';
import 'package:chuck/src/models/joke_categories.dart';
import 'package:chuck/src/models/joke_search_results.dart';
import 'package:chuck/src/services/api/result.dart';

/// Abstraction of api calls to allow for changing implementations/testing
abstract class JokesApi {

  /// Get random jokes optionally passing in a category
  /// Returns a `Result` with either a Joke or a failure
  Future<Result<Joke, Exception>> getRandomJoke({String? category});


  /// Get jokes based on a required search string
  /// Returns a `Result` with either a joke list or a failure
  Future<Result<JokeSearchResults, Exception>> getSearchJokeResults({required String searchString});

  /// Get a list of all the joke categories
  /// Returns a `Result` with either a joke category list or a failure
  Future<Result<JokeCategories, Exception>> getJokeCategories();
}