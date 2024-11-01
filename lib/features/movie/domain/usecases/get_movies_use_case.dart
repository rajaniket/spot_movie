import '../entities/movie_entity.dart';
import '../repositories/movie_repository.dart';

class GetMoviesUseCase {
  const GetMoviesUseCase({required this.movieRepository});
  final MovieRepository movieRepository;

  Future<List<MovieEntity>> call() => movieRepository.fetchMovies();
}
