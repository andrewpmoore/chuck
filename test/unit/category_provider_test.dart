import 'dart:convert';

import 'package:chuck/src/business/category_provider.dart';
import 'package:chuck/src/services/api/dio/jokes_api_dio.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';


void main() {



  group('CategoryProvider Tests', () {

    late Dio dio;
    late DioAdapter dioAdapter;

    setUp(() {
      TestWidgetsFlutterBinding.ensureInitialized();
      dio = Dio();
      dioAdapter = DioAdapter(dio: dio);
    });

    test('Search categories, getting back a successful response', () async {
      // mock the random joke api and return a success response
      dioAdapter.onGet('https://api.chucknorris.io/jokes/categories',(server) async => server.reply(200, jsonDecode(await rootBundle.loadString('assets/mocks/categories.json'))),);

      CategoryProvider categoryProvider = CategoryProvider(JokesApiDio(dio));
      await categoryProvider.getCategoriesSearch();
      expect(categoryProvider.jokeCategories, isNotNull);
      expect(categoryProvider.jokeCategories?.categories.length, 16);
      expect(categoryProvider.errorMessage, '');
    });



    test('Search for jokes, getting back a failure', () async {
      // mock the random joke api and return a failure
      dioAdapter.onGet('https://api.chucknorris.io/jokes/categories',(server) async => server.reply(500, null),);

      CategoryProvider categoryProvider = CategoryProvider(JokesApiDio(dio));
      await categoryProvider.getCategoriesSearch();
      expect(categoryProvider.jokeCategories, isNull);
      expect(categoryProvider.errorMessage, 'Unable to obtain categories, try again later');

    });

  });
}