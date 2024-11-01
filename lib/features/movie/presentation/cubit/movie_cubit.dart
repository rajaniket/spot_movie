import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spot_movie/features/movie/presentation/cubit/movie_state.dart';
import '../../domain/entities/movie_entity.dart';
import '../../domain/usecases/get_movies_use_case.dart';

class MovieCubit extends Cubit<MovieState> {
  MovieCubit({required this.fetchMovies}) : super(MovieInitial());

  final GetMoviesUseCase fetchMovies;

  List<MovieEntity> _movies = [];

  Future<void> getMovies() async {
    emit(MovieLoading());
    try {
      _movies = await fetchMovies();
      emit(MovieLoaded(const []));
    } catch (e) {
      emit(MovieError('Failed to load movies'));
    }
  }

  Future<List<MovieEntity>> searchMovies(String query) async {
    if (query.length < 2) {
      return [];
    }

    // Split the query into keywords and convert to lower case
    final keywords =
        query.toLowerCase().split(RegExp(r'\s+')); // Split by whitespace

    // Create a list of results with a score based on keyword matches
    final results = _movies
        .map((movie) {
          // Filter out movies with null or empty location
          if (movie.locations == null || movie.locations!.isEmpty) {
            return null;
          }
          // Count matches
          var score = 0;
          for (final keyword in keywords) {
            if (movie.title.toLowerCase().contains(keyword)) {
              score++;
            }
          }
          // Return the movie with its score if it matches any keyword
          return score > 0 ? MapEntry(movie, score) : null;
        })
        .whereType<MapEntry<MovieEntity, int>>()
        .toList()
      ..sort(
        (a, b) => b.value.compareTo(a.value),
      ); // Sort the results based on the score (highest first)

    // Take the top 5 results
    final topResults = results.take(5).map((entry) => entry.key).toList();

    return topResults;
  }
}
