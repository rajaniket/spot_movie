import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:spot_movie/core/widgets/app_dialog.dart';
import 'package:spot_movie/features/movie/presentation/cubit/movie_state.dart';
import 'package:spot_movie/features/movie/presentation/ui_entity/map_marker.dart';
import '../../domain/entities/movie_entity.dart';
import '../../domain/usecases/get_movies_use_case.dart';
import '../ui_entity/errors_enum.dart';

/// The MovieCubit manages the state for the movie feature,
/// including fetching movies, handling movie selection,
/// and interacting with the map.
class MovieCubit extends Cubit<MovieState> {
  // Constructor for MovieCubit, takes a use case to fetch movies.
  MovieCubit({required this.getMoviesUseCase})
      : super(
          const MovieState(
            movies: null,
            isLoading: true,
          ),
        );

  final GetMoviesUseCase getMoviesUseCase;

  // List to hold movie entities.
  List<MovieEntity> _movies = [];
  GoogleMapController? _mapController;

  /// Sets the Google Map controller for map interactions.
  void setMapController(GoogleMapController controller) {
    _mapController = controller;
  }

  /// Fetches the list of movies and emits the loading state.
  Future<void> getMovies() async {
    emit(
      MovieState(
        movies: _movies,
        isLoading: true,
      ),
    );
    try {
      // Call the use case to get movies.
      _movies = await getMoviesUseCase();
      emit(
        MovieState(
          isLoading: false,
          movies: _movies,
        ),
      );
    } catch (e) {
      // Handle errors and emit the appropriate state.
      emit(
        MovieState(
          movies: _movies,
          isLoading: false,
          errorType: ErrorType.unknownError,
          time: DateTime.now(),
        ),
      );
    }
  }

  /// Handles movie selection and updates the map location.
  Future<void> onMovieSelect({
    required MovieEntity selectedMovie,
    required BuildContext context,
  }) async {
    try {
      // Fetch the locations based on the movie's address.
      final locations = await locationFromAddress(
        '${selectedMovie.locations!},San Francisco',
      );
      if (locations.isNotEmpty) {
        // If locations found, animate the map to the selected movie's location.
        final location = locations.first;
        final targetLocation = LatLng(location.latitude, location.longitude);
        await _mapController?.animateCamera(
          CameraUpdate.newLatLngZoom(
            targetLocation,
            15,
          ),
        );
        // Emit state with the selected movie's marker.
        emit(
          MovieState(
            movies: _movies,
            selectedMovie: MovieMarkerEntity(
              marker: Marker(
                markerId: MarkerId(UniqueKey().toString()),
                position: targetLocation,
                infoWindow: InfoWindow(
                  title: selectedMovie.title,
                  snippet: selectedMovie.getMultilineString(),
                ),
              ),
              movieEntity: selectedMovie,
            ),
          ),
        );

        return;
      }
      // If no locations found, emit state with an error type.
      emit(
        MovieState(
          movies: _movies,
          errorType: ErrorType.noLocationInfoError,
          selectedMovie: MovieMarkerEntity(
            marker: null,
            movieEntity: selectedMovie,
          ),
          time: DateTime.now(),
        ),
      );
    } catch (e) {
      // Handle exceptions and emit an error state.
      emit(
        MovieState(
          movies: _movies,
          errorType: ErrorType.noLocationInfoError,
          selectedMovie: MovieMarkerEntity(
            marker: null,
            movieEntity: selectedMovie,
          ),
          time: DateTime.now(),
        ),
      );
    }
  }

  /// Fetches the user's current location and updates the map.
  Future<void> getCurrentLocation(BuildContext context) async {
    try {
      LocationPermission permission;
      permission = await Geolocator.requestPermission();
      // Check for location permissions.
      if (permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always) {
        // If permission granted, get the current position.
        final position = await Geolocator.getCurrentPosition();
        final currentLocation = LatLng(position.latitude, position.longitude);
        await _mapController
            ?.animateCamera(CameraUpdate.newLatLngZoom(currentLocation, 15));
        // Emit state with the current location's marker.
        emit(
          MovieState(
            movies: _movies,
            selectedMovie: MovieMarkerEntity(
              marker: Marker(
                markerId: MarkerId(UniqueKey().toString()),
                position: currentLocation,
                infoWindow: const InfoWindow(
                  title: 'Your location',
                ),
              ),
              movieEntity: null,
            ),
          ),
        );
      } else {
        // Handle case where location permissions are denied.
        if (context.mounted) {
          await customDialog(
            context: context,
            title: "Location aren't allowed",
            content: 'We will need your location to give you better experience',
            yesButtonText: 'Allow',
            onYesPress: () async {
              final status = await Permission.location.request();
              // Open app settings if permission is denied or permanently denied.
              if (status.isDenied || status.isPermanentlyDenied) {
                await openAppSettings();
              }
              if (context.mounted) {
                await getCurrentLocation(context);
              }
              if (context.mounted) Navigator.pop(context);
            },
          );
        }
      }
    } catch (e) {
      // Do nothing in case of an error.
    }
  }

  /// Searches for movies based on a query and returns matching movies.
  Future<List<MovieEntity>> searchMovies(String query) async {
    // Return empty if query length is less than 2.
    if (query.length < 2) {
      return [];
    }

    // Split the query into keywords and convert to lower case.
    final keywords =
        query.toLowerCase().split(RegExp(r'\s+')); // Split by whitespace

    // Create a list of results with a score based on keyword matches.
    final results = _movies
        .map((movie) {
          // Filter out movies with null or empty location.
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
