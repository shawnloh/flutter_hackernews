import 'package:news/src/resources/news_api_provider.dart';

import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

void main() {
  test('FetchTopIds returns a list of ids', () async {
    final newsApi = NewsApiProvider();
    final expectedIds = [123, 321, 456, 23232];
    newsApi.client = MockClient((request) async {
      return Response(json.encode(expectedIds), 200);
    });

    final ids = await newsApi.fetchTopIds();
    expect(ids, expectedIds);
  });

  test('FetchItem returns a item model', () async {
    final newsApi = NewsApiProvider();
    final expectedItem = {
      'id': 123,
    };
    newsApi.client = MockClient((request) async {
      return Response(json.encode(expectedItem), 200);
    });

    final returnedItem = await newsApi.fetchItem(999);
    expect(returnedItem.id, 123);
  });
}
