import 'dart:convert';

import 'package:chuck/src/models/joke.dart';

/// Model of search results
/// Essentially just a list around the `Joke` class
class SearchResults {
  int? total;
  List<Joke>? result;

  SearchResults({
    this.total,
    this.result,
  });

  SearchResults copyWith({
    int? total,
    List<Joke>? result,
  }) =>
      SearchResults(
        total: total ?? this.total,
        result: result ?? this.result,
      );

  factory SearchResults.fromRawJson(String str) => SearchResults.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SearchResults.fromJson(Map<String, dynamic> json) => SearchResults(
    total: json["total"],
    result: json["result"] == null ? [] : List<Joke>.from(json["result"]!.map((x) => Joke.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "total": total,
    "result": result == null ? [] : List<dynamic>.from(result!.map((x) => x.toJson())),
  };
}

