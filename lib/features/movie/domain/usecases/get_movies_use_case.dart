import 'package:injectable/injectable.dart';

import '../entities/movie_entity.dart';
import '../repositories/movie_repository.dart';

/// The GetMoviesUseCase class is responsible for retrieving movie data from the repository.

@Injectable()
class GetMoviesUseCase {
  const GetMoviesUseCase(this.movieRepository);
  final MovieRepository movieRepository;

  Future<List<MovieEntity>> call() => movieRepository.fetchMovies();
}
