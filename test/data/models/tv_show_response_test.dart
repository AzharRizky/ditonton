import 'dart:convert';

import 'package:ditonton/data/models/tv_show_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../json_reader.dart';

void main() {
  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/on_the_air.json'));
      // act
      final result = TVShowResponse.fromJson(jsonMap);
      // assert
      expect(result, testTVShowResponse);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = testTVShowResponse.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            "backdrop_path": "/oC9SgtJTDCEpWnTBtVGoAvjl5hb.jpg",
            "first_air_date": "2006-09-18",
            "genre_ids": [10767],
            "id": 1991,
            "name": "Rachael Ray",
            "origin_country": ["US"],
            "original_language": "en",
            "original_name": "Rachael Ray",
            "overview":
                "Rachael Ray, also known as The Rachael Ray Show, is an American talk show starring Rachael Ray that debuted in syndication in the United States and Canada on September 18, 2006. It is filmed at Chelsea Television Studios in New York City. The show's 8th season premiered on September 9, 2013, and became the last Harpo show in syndication to switch to HD with a revamped studio. In January 2012, CBS Television Distribution announced a two-year renewal for the show, taking it through the 2013–14 season.",
            "popularity": 1765.863,
            "poster_path": "/dsAJhCLYX1fiNRoiiJqR6Up4aJ.jpg",
            "vote_average": 5.8,
            "vote_count": 29
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
