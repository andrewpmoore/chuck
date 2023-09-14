import 'package:chuck/src/models/joke.dart';
import 'package:chuck/src/models/search_results.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SearchResults', () {
    test('fromJson should correctly deserialize JSON', () {
      // Define a sample JSON string for search results
      const jsonString = '''
        {
          "total": 3,
          "result": [
            {
              "categories": ["category1"],
              "created_at": "2023-09-14T12:00:00Z",
              "icon_url": "https://example.com/icon1.png",
              "id": "1",
              "updated_at": "2023-09-14T12:30:00Z",
              "url": "https://example.com/joke1",
              "value": "Joke 1"
            },
            {
              "categories": ["category2"],
              "created_at": "2023-09-14T13:00:00Z",
              "icon_url": "https://example.com/icon2.png",
              "id": "2",
              "updated_at": "2023-09-14T13:30:00Z",
              "url": "https://example.com/joke2",
              "value": "Joke 2"
            },
            {
              "categories": [],
              "created_at": "2023-09-14T14:00:00Z",
              "icon_url": null,
              "id": "3",
              "updated_at": null,
              "url": null,
              "value": "Joke 3"
            }
          ]
        }
      ''';

      // Deserialize the JSON string into a SearchResults object
      final searchResults = SearchResults.fromRawJson(jsonString);

      // Check the deserialized values
      expect(searchResults.total, 3);
      expect(searchResults.result!.length, 3); // Check the number of jokes in the result

      // Check values of the first joke in the result
      expect(searchResults.result![0].categories, ["category1"]);
      expect(searchResults.result![0].createdAt, DateTime.parse("2023-09-14T12:00:00Z"));
      expect(searchResults.result![0].iconUrl, "https://example.com/icon1.png");
      expect(searchResults.result![0].id, "1");
      expect(searchResults.result![0].updatedAt, DateTime.parse("2023-09-14T12:30:00Z"));
      expect(searchResults.result![0].url, "https://example.com/joke1");
      expect(searchResults.result![0].value, "Joke 1");
    });

    test('toJson should correctly serialize to JSON', () {
      // Create a sample SearchResults object
      final searchResults = SearchResults(
        total: 2,
        result: [
          Joke(
            categories: ["category1"],
            createdAt: DateTime.parse("2023-09-14T12:00:00Z"),
            iconUrl: "https://example.com/icon1.png",
            id: "1",
            updatedAt: DateTime.parse("2023-09-14T12:30:00Z"),
            url: "https://example.com/joke1",
            value: "Joke 1",
          ),
          Joke(
            categories: ["category2"],
            createdAt: DateTime.parse("2023-09-14T13:00:00Z"),
            iconUrl: "https://example.com/icon2.png",
            id: "2",
            updatedAt: DateTime.parse("2023-09-14T13:30:00Z"),
            url: "https://example.com/joke2",
            value: "Joke 2",
          ),
        ],
      );

      // Serialize the SearchResults object to JSON
      final json = searchResults.toJson();

      // Define the expected JSON map
      final expectedJson = {
        "total": 2,
        "result": [
          {
            "categories": ["category1"],
            "created_at": "2023-09-14T12:00:00.000Z",
            "icon_url": "https://example.com/icon1.png",
            "id": "1",
            "updated_at": "2023-09-14T12:30:00.000Z",
            "url": "https://example.com/joke1",
            "value": "Joke 1",
          },
          {
            "categories": ["category2"],
            "created_at": "2023-09-14T13:00:00.000Z",
            "icon_url": "https://example.com/icon2.png",
            "id": "2",
            "updated_at": "2023-09-14T13:30:00.000Z",
            "url": "https://example.com/joke2",
            "value": "Joke 2",
          },
        ],
      };

      // Check if the serialized JSON matches the expected JSON
      expect(json, expectedJson);
    });
  });
}
