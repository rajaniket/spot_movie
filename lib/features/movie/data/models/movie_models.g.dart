// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieModel _$MovieModelFromJson(Map<String, dynamic> json) => MovieModel(
      title: json['title'] as String,
      locations: json['locations'] as String?,
      releaseYear: json['release_year'] as String?,
      productionCompany: json['production_company'] as String?,
      distributor: json['distributor'] as String?,
      director: json['director'] as String?,
      writer: json['writer'] as String?,
      actor1: json['actor_1'] as String?,
      actor2: json['actor_2'] as String?,
      actor3: json['actor_3'] as String?,
    );

Map<String, dynamic> _$MovieModelToJson(MovieModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'locations': instance.locations,
      'release_year': instance.releaseYear,
      'production_company': instance.productionCompany,
      'distributor': instance.distributor,
      'director': instance.director,
      'writer': instance.writer,
      'actor_1': instance.actor1,
      'actor_2': instance.actor2,
      'actor_3': instance.actor3,
    };
