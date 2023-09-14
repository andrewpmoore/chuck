import 'dart:convert';

import 'package:chuck/src/business/joke_provider.dart';
import 'package:chuck/src/models/joke.dart';
import 'package:chuck/src/services/api/dio/jokes_api_dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';


void main() {



  group('JokeProvider Tests', () {

    late Dio dio;
    late DioAdapter dioAdapter;

    setUp(() {
      TestWidgetsFlutterBinding.ensureInitialized();
      dio = Dio();
      dioAdapter = DioAdapter(dio: dio);
    });

    test('fetch a joke, getting back a successful response', () async {
      // mock the random joke api and return a success response
      dioAdapter.onGet('https://api.chucknorris.io/jokes/random',(server) async => server.reply(200, jsonDecode(await rootBundle.loadString('assets/mocks/random_success.json'))),);

      JokeProvider jokeProvider = JokeProvider(JokesApiDio(dio));
      await jokeProvider.fetchAJoke();
      expect(jokeProvider.joke, isA<Joke>());
      expect(jokeProvider.joke!.isFake, isFalse);
      expect(jokeProvider.busy, isFalse);

    });



    test('fetch a joke, getting back a failure', () async {
      // mock the random joke api and return a failure
      dioAdapter.onGet('https://api.chucknorris.io/jokes/random',(server) async => server.reply(500, null),);

      JokeProvider jokeProvider = JokeProvider(JokesApiDio(dio));
      await jokeProvider.fetchAJoke();
      expect(jokeProvider.joke!.isFake, isTrue);
      expect(jokeProvider.busy, isFalse);
    });


    test('fetch a joke for a specific category, getting back a successful response', () async {
      // mock the random joke api and return a success response
      dioAdapter.onGet('https://api.chucknorris.io/jokes/random?query=dev',(server) async => server.reply(200, jsonDecode(await rootBundle.loadString('assets/mocks/random_success_category_dev.json'))),);

      JokeProvider jokeProvider = JokeProvider(JokesApiDio(dio));
      await jokeProvider.fetchAJoke(category: 'dev');
      expect(jokeProvider.joke, isA<Joke>());
      expect(jokeProvider.joke!.isFake, isFalse);
      expect(jokeProvider.busy, isFalse);

    });



    test('fetch a joke for a specific category, getting back a failure response', () async {
      // mock the random joke api and return a failure
      dioAdapter.onGet('https://api.chucknorris.io/jokes/random?query=dev',(server) async => server.reply(500, null),);

      JokeProvider jokeProvider = JokeProvider(JokesApiDio(dio));
      await jokeProvider.fetchAJoke(category: 'dev');
      expect(jokeProvider.joke!.isFake, isTrue);
      expect(jokeProvider.busy, isFalse);
    });

  });
}