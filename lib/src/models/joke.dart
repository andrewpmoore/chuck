import 'dart:convert';

/// Joke model
/// Represents the data coming from from the API


class Joke {
  List<String>? categories;
  DateTime? createdAt;
  String? iconUrl;
  String? id;
  DateTime? updatedAt;
  String? url;
  String? value;

  Joke({
    this.categories,
    this.createdAt,
    this.iconUrl,
    this.id,
    this.updatedAt,
    this.url,
    this.value,
  });

  Joke copyWith({
    List<String>? categories,
    DateTime? createdAt,
    String? iconUrl,
    String? id,
    DateTime? updatedAt,
    String? url,
    String? value,
  }) =>
      Joke(
        categories: categories ?? this.categories,
        createdAt: createdAt ?? this.createdAt,
        iconUrl: iconUrl ?? this.iconUrl,
        id: id ?? this.id,
        updatedAt: updatedAt ?? this.updatedAt,
        url: url ?? this.url,
        value: value ?? this.value,
      );

  factory Joke.fromRawJson(String str) => Joke.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Joke.fromJson(Map<String, dynamic> json) => Joke(
    categories: json["categories"] == null ? [] : List<String>.from(json["categories"]!.map((x) => x)),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    iconUrl: json["icon_url"],
    id: json["id"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    url: json["url"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "categories": categories == null ? [] : List<dynamic>.from(categories!.map((x) => x)),
    "created_at": createdAt?.toIso8601String(),
    "icon_url": iconUrl,
    "id": id,
    "updated_at": updatedAt?.toIso8601String(),
    "url": url,
    "value": value,
  };
}
