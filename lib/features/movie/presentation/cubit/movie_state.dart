import 'package:equatable/equatable.dart';
import 'package:spot_movie/features/movie/domain/entities/movie_entity.dart';
import '../ui_entity/errors_enum.dart';
import '../ui_entity/map_marker.dart';

class MovieState extends Equatable {
  const MovieState({
    required this.movies,
    this.errorType,
    this.selectedMovie,
    this.isLoading,
  });

  final ErrorType? errorType;
  final MovieMarkerEntity? selectedMovie;
  final bool? isLoading;
  final List<MovieEntity>? movies;

  @override
  List<Object?> get props => [
        errorType,
        selectedMovie,
        isLoading,
        movies,
      ];

  MovieState copyWith({
    ErrorType? errorType,
    MovieMarkerEntity? selectedMovie,
    bool? isLoading,
    List<MovieEntity>? movies,
  }) {
    return MovieState(
      errorType: errorType ?? this.errorType,
      selectedMovie: selectedMovie ?? this.selectedMovie,
      isLoading: isLoading ?? this.isLoading,
      movies: movies ?? this.movies,
    );
  }
}
