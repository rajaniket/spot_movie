import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:spot_movie/features/movie/domain/entities/movie_entity.dart';

class MovieMarkerEntity extends Equatable {
  const MovieMarkerEntity({
    required this.movieEntity,
    required this.marker,
  });
  final MovieEntity? movieEntity;
  final Marker? marker;

  @override
  List<Object?> get props {
    return [
      marker,
      movieEntity,
    ];
  }
}
