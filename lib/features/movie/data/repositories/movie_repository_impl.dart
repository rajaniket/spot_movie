import 'package:injectable/injectable.dart';
import '../../domain/entities/movie_entity.dart';
import '../../domain/repositories/movie_repository.dart';
import '../data_sources/movie_local_data_source.dart';
import '../data_sources/movie_remote_data_source.dart';

@Injectable(as: MovieRepository)
class MovieRepositoryImpl implements MovieRepository {
  const MovieRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });
  final MovieRemoteDataSource remoteDataSource;
  final MovieLocalDataSource localDataSource;

  @override
  Future<List<MovieEntity>> fetchMovies() async {
    if (await localDataSource.isCacheExpired()) {
      final movies = await remoteDataSource.fetchMovies();
      await localDataSource.cacheMovies(movies);
      return movies;
    } else {
      return localDataSource.getCachedMovies();
    }
  }
}
