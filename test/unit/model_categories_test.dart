import 'package:chuck/src/models/categories.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  group('Categories', () {
    test('fromJson should correctly deserialize JSON', () {
      // Define a sample JSON list of categories
      final jsonList = ["category1", "category2", "category3"];

      // Deserialize the JSON list into a Categories object
      final categories = Categories.fromJson(jsonList);

      // Check the deserialized values
      expect(categories.categories, jsonList);
    });
  });
}
