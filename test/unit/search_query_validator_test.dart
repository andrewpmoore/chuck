import 'package:chuck/src/business/search_provider.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  test('Search string less than 3 characters, returns error', (){
    var result = SearchValidator.validate('a');
    expect(result, 'Search must be longer than 2 characters');
  });


  test('Search string longer than 3 characters, return an empty string', (){
    var result = SearchValidator.validate('test');
    expect(result, '');
  });
}