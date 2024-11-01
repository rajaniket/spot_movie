// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieModel _$MovieModelFromJson(Map<String, dynamic> json) => MovieModel(
      title: json['title'] as String,
      locations: json['locations'] as String?,
      releaseYear: json['releaseYear'] as String?,
      productionCompany: json['productionCompany'] as String?,
      distributor: json['distributor'] as String?,
      director: json['director'] as String?,
      writer: json['writer'] as String?,
      actor1: json['actor1'] as String?,
      actor2: json['actor2'] as String?,
      actor3: json['actor3'] as String?,
    );

Map<String, dynamic> _$MovieModelToJson(MovieModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'locations': instance.locations,
      'releaseYear': instance.releaseYear,
      'productionCompany': instance.productionCompany,
      'distributor': instance.distributor,
      'director': instance.director,
      'writer': instance.writer,
      'actor1': instance.actor1,
      'actor2': instance.actor2,
      'actor3': instance.actor3,
    };
