import 'package:injectable/injectable.dart';

import '../../../../core/services/network_service/network_service.dart';
import '../models/movie_models.dart';

abstract class MovieRemoteDataSource {
  Future<List<MovieModel>> fetchMovies();
}

@Injectable(as: MovieRemoteDataSource)
class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  const MovieRemoteDataSourceImpl(this.networkService);
  final NetworkService networkService;

  /// Fetches movies from the specified remote endpoint.
  @override
  Future<List<MovieModel>> fetchMovies() async {
    final response = await networkService.getRequest(
      endpoint: 'https://data.sfgov.org/resource/yitu-d5am.json',
    );

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
