import 'package:equatable/equatable.dart';
import 'package:spot_movie/features/movie/domain/entities/movie_entity.dart';
import '../ui_entity/errors_enum.dart';
import '../ui_entity/map_marker.dart';

/// Represents the state of the Movie feature.
class MovieState extends Equatable {
  const MovieState({
    required this.movies,
    this.errorType,
    this.selectedMovie,
    this.isLoading,
    this.time,
  });

  final ErrorType? errorType; // Holds any error that may occur.
  final MovieMarkerEntity? selectedMovie; // Currently selected movie's marker.
  final bool? isLoading; // Indicates loading state.
  final List<MovieEntity>? movies; // List of movies.
  final DateTime? time; // Used to manage duplicate states.

  @override
  List<Object?> get props => [
        errorType,
        selectedMovie,
        isLoading,
        movies,
        time,
      ];

  /// Creates a copy of the current state with new properties.
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
