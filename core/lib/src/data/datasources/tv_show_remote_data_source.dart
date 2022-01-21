import 'dart:convert';

import 'package:core/src/common/constants.dart';
import 'package:core/src/common/exception.dart';
import 'package:core/src/data/models/tv_show_detail_model.dart';
import 'package:core/src/data/models/tv_show_model.dart';
import 'package:core/src/data/models/tv_show_response.dart';
import 'package:http/http.dart' as http;

abstract class TVShowRemoteDataSource {
  Future<List<TVShowModel>> getNowPlayingTVShows();

  Future<List<TVShowModel>> getPopularTVShows();

  Future<List<TVShowModel>> getTopRatedTVShows();

  Future<TVShowDetailResponse> getTVShowDetail(int id);

  Future<List<TVShowModel>> getTVShowRecommendations(int id);

  Future<List<TVShowModel>> searchTVShows(String query);
}

class TVShowRemoteDataSourceImpl implements TVShowRemoteDataSource {
  final http.Client client;

  TVShowRemoteDataSourceImpl({required this.client});

  @override
  Future<List<TVShowModel>> getNowPlayingTVShows() async {
    final response =
        await client.get(Uri.parse('$baseUrl/tv/on_the_air?$apiKey'));

    if (response.statusCode == 200) {
      return TVShowResponse.fromJson(json.decode(response.body)).tvShowList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TVShowModel>> getPopularTVShows() async {
    final response = await client.get(Uri.parse('$baseUrl/tv/popular?$apiKey'));

    if (response.statusCode == 200) {
      return TVShowResponse.fromJson(json.decode(response.body)).tvShowList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TVShowDetailResponse> getTVShowDetail(int id) async {
    final response = await client.get(Uri.parse('$baseUrl/tv/$id?$apiKey'));

    if (response.statusCode == 200) {
      return TVShowDetailResponse.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TVShowModel>> getTVShowRecommendations(int id) async {
    final response =
        await client.get(Uri.parse('$baseUrl/tv/$id/recommendations?$apiKey'));

    if (response.statusCode == 200) {
      return TVShowResponse.fromJson(json.decode(response.body)).tvShowList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TVShowModel>> getTopRatedTVShows() async {
    final response =
        await client.get(Uri.parse('$baseUrl/tv/top_rated?$apiKey'));

    if (response.statusCode == 200) {
      return TVShowResponse.fromJson(json.decode(response.body)).tvShowList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TVShowModel>> searchTVShows(String query) async {
    final response =
        await client.get(Uri.parse('$baseUrl/search/tv?$apiKey&query=$query'));

    if (response.statusCode == 200) {
      return TVShowResponse.fromJson(json.decode(response.body)).tvShowList;
    } else {
      throw ServerException();
    }
  }
}
