import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/movie_entity.dart';

part 'movie_models.g.dart';

@JsonSerializable()
class MovieModel extends MovieEntity {
  const MovieModel({
    required super.title,
    super.locations,
    super.releaseYear,
    super.productionCompany,
    super.distributor,
    super.director,
    super.writer,
    super.actor1,
    super.actor2,
    super.actor3,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) =>
      _$MovieModelFromJson(json);

  Map<String, dynamic> toJson() => _$MovieModelToJson(this);
}
