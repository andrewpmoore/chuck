import 'dart:convert';

import 'package:chuck/src/models/joke.dart';
import 'package:chuck/src/models/joke_categories.dart';
import 'package:chuck/src/models/joke_search_results.dart';
import 'package:chuck/src/services/api/jokes_api.dart';
import 'package:chuck/src/services/api/result.dart';
import 'package:dio/dio.dart';

class JokesApiDio implements JokesApi {
  final Dio _dio = Dio();


  //todo could add checking for network connectivity before making the call as an improvement to these methods

  @override
  Future<Result<Joke, Exception>> getRandomJoke({String? category}) async {
      try {
        //if a category has been supplied then append it to the url, otherwise just make the call to 'random' without any query parameters
        String url = 'https://api.chucknorris.io/jokes/random${category!=null?'?query{$category}':''}';
        final response = await _dio.get(url);
        switch (response.statusCode){
          case 200:
            final data = json.decode(response.data);
            return Success(Joke.fromRawJson(data));
          default:
            return Failure(Exception(response.statusMessage));
        }
      } on Exception catch (e) {
        return Failure(e);
      }
  }

  @override
  Future<Result<JokeSearchResults, Exception>> getSearchJokeResults({required String searchString}) async {
    try {
      //create a url passing in the search string provided and handle errors coming back
      String url = 'https://api.chucknorris.io/jokes/search?query=$searchString';
      final response = await _dio.get(url);
      switch (response.statusCode){
        case 200:
          final data = json.decode(response.data);
          return Success(JokeSearchResults.fromRawJson(data));
        default:
          return Failure(Exception(response.statusMessage));
      }
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  @override
  Future<Result<JokeCategories, Exception>> getJokeCategories() async{
    try {
      //create a url passing in the search string provided and handle errors coming back
      final response = await _dio.get('https://api.chucknorris.io/jokes/categories');
      switch (response.statusCode){
        case 200:
          final List<dynamic> categoryList = response.data;
          final categories = JokeCategories.fromJson(categoryList);
          return Success(categories);
        default:
          return Failure(Exception(response.statusMessage));
      }
    } on Exception catch (e) {
      return Failure(e);
    }
  }




}