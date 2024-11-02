import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:spot_movie/features/movie/domain/entities/movie_entity.dart';
import 'package:spot_movie/features/movie/domain/usecases/get_movies_use_case.dart';
import 'package:spot_movie/features/movie/presentation/cubit/movie_cubit.dart';

class MockGetMoviesUseCase extends Mock implements GetMoviesUseCase {}

void main() {
  late MovieCubit movieCubit;
  late MockGetMoviesUseCase mockGetMoviesUseCase;

  setUp(() {
    mockGetMoviesUseCase = MockGetMoviesUseCase();
    movieCubit = MovieCubit(getMoviesUseCase: mockGetMoviesUseCase);
  });

  group('MovieCubit', () {
    test('initial state should be loading', () {
      expect(movieCubit.state.isLoading, true);
      expect(movieCubit.state.movies, null);
    });

    test('getMovies emits movies when successful', () async {
      // Mock response for the use case
      final movieList = [
        const MovieEntity(title: 'Movie 1', locations: 'Location 1'),
        const MovieEntity(title: 'Movie 2', locations: 'Location 2'),
      ];

      // Set up the mock to return a Future with the movie list
      when(mockGetMoviesUseCase.call()).thenAnswer((_) async => movieList);

      // Call the method to fetch movies
      await movieCubit.getMovies();

      // Expect the loading to be false and movies to be the returned list
      expect(movieCubit.state.isLoading, false);
      expect(movieCubit.state.movies, movieList);
    });
  });
}
