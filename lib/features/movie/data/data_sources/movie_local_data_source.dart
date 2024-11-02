import 'dart:convert';
import 'package:injectable/injectable.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/services/storage_service/storage_service.dart';
import '../models/movie_models.dart';

abstract class MovieLocalDataSource {
  Future<void> cacheMovies(List<MovieModel> movies);
  Future<List<MovieModel>> getCachedMovies();
  Future<bool> isCacheExpired();
}

@Injectable(as: MovieLocalDataSource)
class MovieLocalDataSourceImpl implements MovieLocalDataSource {
  const MovieLocalDataSourceImpl(this.sharedPreferencesStorageService);
  final StorageService sharedPreferencesStorageService;

  /// Caches a list of movies in the local storage.
  @override
  Future<void> cacheMovies(List<MovieModel> movies) async {
    final data = jsonEncode(movies.map((movie) => movie.toJson()).toList());
    await sharedPreferencesStorageService.set(
      SharedPreferencesKeys.cachedMovies,
      data,
    );
    await sharedPreferencesStorageService.set(
      SharedPreferencesKeys.cacheTime,
      DateTime.now().millisecondsSinceEpoch,
    );
  }

  /// Retrieves the cached movies from local storage.
  @override
  Future<List<MovieModel>> getCachedMovies() async {
    final data = await sharedPreferencesStorageService
        .get<String?>(SharedPreferencesKeys.cachedMovies);
    if (data != null) {
      return (jsonDecode(data) as List)
          .map((e) => MovieModel.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    return [];
  }

  /// Checks if the cache has expired based on the cache time.
  @override
  Future<bool> isCacheExpired() async {
    final cacheTime = await sharedPreferencesStorageService
        .get<int?>(SharedPreferencesKeys.cacheTime);
    if (cacheTime == null) return true;
    final difference = DateTime.now()
        .difference(DateTime.fromMillisecondsSinceEpoch(cacheTime));
    return difference.inHours >= 1;
  }
}
