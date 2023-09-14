import 'package:chuck/src/models/joke.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Joke', () {
    test('fromJson should correctly deserialize JSON', () {
      // Define a sample JSON string
      const jsonString = '''
        {
          "categories": ["category1", "category2"],
          "created_at": "2023-09-14T12:00:00Z",
          "icon_url": "https://example.com/icon.png",
          "id": "12345",
          "updated_at": "2023-09-14T12:30:00Z",
          "url": "https://example.com/joke",
          "value": "This is a joke"
        }
      ''';

      // Deserialize the JSON string into a Joke object
      final joke = Joke.fromRawJson(jsonString);

      // Check the deserialized values
      expect(joke.categories, ["category1", "category2"]);
      expect(joke.createdAt, DateTime.parse("2023-09-14T12:00:00Z"));
      expect(joke.iconUrl, "https://example.com/icon.png");
      expect(joke.id, "12345");
      expect(joke.updatedAt, DateTime.parse("2023-09-14T12:30:00Z"));
      expect(joke.url, "https://example.com/joke");
      expect(joke.value, "This is a joke");
      expect(joke.isFake, false); // Assuming isFake should be false by default
    });

    test('toJson should correctly serialize to JSON', () {
      // Create a sample Joke object
      final joke = Joke(
        categories: ["category1", "category2"],
        createdAt: DateTime.parse("2023-09-14T12:00:00Z"),
        iconUrl: "https://example.com/icon.png",
        id: "12345",
        updatedAt: DateTime.parse("2023-09-14T12:30:00Z"),
        url: "https://example.com/joke",
        value: "This is a joke",
      );

      // Serialize the Joke object to JSON
      final json = joke.toJson();

      // Define the expected JSON map
      final expectedJson = {
        "categories": ["category1", "category2"],
        "created_at": "2023-09-14T12:00:00.000Z",
        "icon_url": "https://example.com/icon.png",
        "id": "12345",
        "updated_at": "2023-09-14T12:30:00.000Z",
        "url": "https://example.com/joke",
        "value": "This is a joke",
      };

      // Check if the serialized JSON matches the expected JSON
      expect(json, expectedJson);
    });
  });
}
