import 'dart:convert';

import 'package:chuck/src/models/joke.dart';

/// Model of search results
/// Essentially just a list around the `Joke` class
class JokeSearchResults {
  int? total;
  List<Joke>? result;

  JokeSearchResults({
    this.total,
    this.result,
  });

  JokeSearchResults copyWith({
    int? total,
    List<Joke>? result,
  }) =>
      JokeSearchResults(
        total: total ?? this.total,
        result: result ?? this.result,
      );

  factory JokeSearchResults.fromRawJson(String str) => JokeSearchResults.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory JokeSearchResults.fromJson(Map<String, dynamic> json) => JokeSearchResults(
    total: json["total"],
    result: json["result"] == null ? [] : List<Joke>.from(json["result"]!.map((x) => Joke.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "total": total,
    "result": result == null ? [] : List<dynamic>.from(result!.map((x) => x.toJson())),
  };
}

