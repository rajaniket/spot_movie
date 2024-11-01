// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

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
  final String? locations;
  final String? releaseYear;
  final String? productionCompany;
  final String? distributor;
  final String? director;
  final String? writer;
  final String? actor1;
  final String? actor2;
  final String? actor3;

  @override
  List<Object?> get props {
    return [
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
  }
}
