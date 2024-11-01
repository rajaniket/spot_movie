import 'package:equatable/equatable.dart';

import '../../domain/entities/movie_entity.dart';

abstract class MovieState extends Equatable {}

class MovieInitial extends MovieState {
  @override
  List<Object?> get props => [];
}

class MovieLoading extends MovieState {
  @override
  List<Object?> get props => [];
}

class MovieLoaded extends MovieState {
  MovieLoaded(this.movies);
  final List<MovieEntity> movies;

  @override
  List<Object?> get props => [movies];
}

class MovieError extends MovieState {
  MovieError(this.message);
  final String message;

  @override
  List<Object?> get props => [message];
}
