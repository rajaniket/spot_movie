import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

class MovieEntity extends Equatable {
  const MovieEntity({
    required this.title,
    required this.locations,
    this.releaseYear,
    this.productionCompany,
    this.distributor,
    this.director,
    this.writer,
    this.actor1,
    this.actor2,
    this.actor3,
  });

  final String title;

  @JsonKey(name: 'locations')
  final String? locations;

  @JsonKey(name: 'release_year')
  final String? releaseYear;

  @JsonKey(name: 'production_company')
  final String? productionCompany;

  @JsonKey(name: 'distributor')
  final String? distributor;

  @JsonKey(name: 'director')
  final String? director;

  @JsonKey(name: 'writer')
  final String? writer;

  @JsonKey(name: 'actor_1')
  final String? actor1;

  @JsonKey(name: 'actor_2')
  final String? actor2;

  @JsonKey(name: 'actor_3')
  final String? actor3;

  @override
  List<Object?> get props => [
        title,
        locations,
        releaseYear,
        productionCompany,
        distributor,
        director,
        writer,
        actor1,
        actor2,
        actor3,
      ];

  String getMultilineString() {
    final details = <String>[];
    if (locations != null) details.add('Location: $locations');
    if (releaseYear != null) details.add('Release Year: $releaseYear');
    if (productionCompany != null) {
      details.add('Production Company: $productionCompany');
    }
    if (director != null) details.add('Director: $director');
    if (actor1 != null) details.add('Actor 1: $actor1');

    final val = details.join('\n');
    return val;
  }

  @override
  bool get stringify => true;
}
