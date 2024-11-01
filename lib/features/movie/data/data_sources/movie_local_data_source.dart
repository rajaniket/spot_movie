import 'dart:convert';
import '../../../../core/services/storage_service.dart';
import '../models/movie_models.dart';

abstract class MovieLocalDataSource {
  Future<void> cacheMovies(List<MovieModel> movies);
  Future<List<MovieModel>> getCachedMovies();
  Future<bool> isCacheExpired();
}

class MovieLocalDataSourceImpl implements MovieLocalDataSource {
  const MovieLocalDataSourceImpl({
    required this.sharedPreferencesStorageService,
  });
  final StorageService sharedPreferencesStorageService;

  @override
  Future<void> cacheMovies(List<MovieModel> movies) async {
    final data = jsonEncode(movies.map((movie) => movie.toJson()).toList());
    await sharedPreferencesStorageService.set('cached_movies', data);
    await sharedPreferencesStorageService.set(
      'cache_time',
      DateTime.now().millisecondsSinceEpoch,
    );
  }

  @override
  Future<List<MovieModel>> getCachedMovies() async {
    final data =
        await sharedPreferencesStorageService.get<String?>('cached_movies');
    if (data != null) {
      return (jsonDecode(data) as List)
          .map((e) => MovieModel.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    return [];
  }

  @override
  Future<bool> isCacheExpired() async {
    final cacheTime =
        await sharedPreferencesStorageService.get<int?>('cache_time');
    if (cacheTime == null) return true;
    final difference = DateTime.now()
        .difference(DateTime.fromMillisecondsSinceEpoch(cacheTime));
    return difference.inHours >= 24;
  }
}
