import 'dart:io';

import 'package:chuck/src/models/joke.dart';
import 'package:chuck/src/services/api/dio/jokes_api_dio.dart';
import 'package:chuck/src/services/api/jokes_api.dart';
import 'package:chuck/src/services/api/result.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class RandomJokeProvider extends ChangeNotifier {
  bool _busy = false;

  set busy(bool value) {
    _busy = value;
    notifyListeners();
  }

  bool get busy => _busy;

  Joke? _joke;

  Joke? get joke => _joke;

  set joke(Joke? value) {
    _joke = value;
    notifyListeners();
  }

  /// FetchAJoke
  /// This fetches a jokes from the api and either sets the joke or a fake joke if there's a failure
  Future<void> fetchAJoke() async {
    busy = true;
    final JokesApi chuckNorrisApi = JokesApiDio();
    final result = await chuckNorrisApi.getRandomJoke();
    busy = false;
    final value = switch (result) {
      Success(value: final jokeResult) => joke = jokeResult,
      Failure(exception: final exception) => _handleFailure(exception),
    };
    if (kDebugMode) {
      print('fetchAJoke $value');
    }
  }

  /// Handle the failure by setting a fake joke to replace the real one
  /// Also location to handle exception logging/reporting of errors
  _handleFailure(Exception exception) {
    //todo for a real app would need to consider how to report that there's failures, maybe crashlytics or to an analytics package
    if (kDebugMode) {
      print('error exception type: $exception');
    }

    //now check the types to determine the fake joke to show
    if ((exception is DioException) && (exception).error is SocketException) {
      //set a fake joke due to not having a connection
      joke = Joke(value: "It's not Chuck Norris, it's you! Chuck never fails");
    } else {
      //set a fake joke due to the api call not working
      joke = Joke(value: 'There seems to have been a system failure, Chuck Norris dares you to try again!');
    }
  }
}
