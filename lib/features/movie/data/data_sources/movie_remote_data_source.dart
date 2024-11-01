import 'package:dio/dio.dart';
import '../models/movie_models.dart';

abstract class MovieRemoteDataSource {
  Future<List<MovieModel>> fetchMovies();
}

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  const MovieRemoteDataSourceImpl(this.client);
  final Dio client;

  @override
  Future<List<MovieModel>> fetchMovies() async {
    final response = await client
        .get<dynamic>('https://data.sfgov.org/resource/yitu-d5am.json');

    if (response.statusCode == 200) {
      final movies = (response.data as List)
          .map((e) => MovieModel.fromJson(e as Map<String, dynamic>))
          .toList();
      return movies;
    } else {
      throw Exception('Failed to load movies');
    }
  }
}
