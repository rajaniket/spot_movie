import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spot_movie/core/services/storage_service.dart';
import 'package:spot_movie/features/movie/data/data_sources/movie_local_data_source.dart';
import 'package:spot_movie/features/movie/data/data_sources/movie_remote_data_source.dart';
import 'package:spot_movie/features/movie/data/repositories/movie_repository_impl.dart';
import 'package:spot_movie/features/movie/presentation/cubit/movie_cubit.dart';

import '../../domain/usecases/get_movies_use_case.dart';
import '../cubit/movie_state.dart';
import '../widgets/auto_complete_search_widget.dart';
import '../widgets/google_map_widget.dart';

class MovieView extends StatefulWidget {
  const MovieView({super.key});

  @override
  State<MovieView> createState() => _MovieViewState();
}

class _MovieViewState extends State<MovieView> {
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MovieCubit(
        fetchMovies: GetMoviesUseCase(
          movieRepository: MovieRepositoryImpl(
            remoteDataSource: MovieRemoteDataSourceImpl(Dio()),
            localDataSource: MovieLocalDataSourceImpl(
              sharedPreferencesStorageService:
                  SharedPreferencesStorageService(),
            ),
          ),
        ),
      )..getMovies(),
      child: BlocBuilder<MovieCubit, MovieState>(
        builder: (context, state) {
          return Scaffold(
            extendBodyBehindAppBar: true,
            backgroundColor: Colors.black.withOpacity(0.30),
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.black.withOpacity(0.30),
              centerTitle: true,
              title: const Text(
                'Spot Movie Location',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
              ),
            ),
            body: Stack(
              children: [
                GoogleMapWidget(
                  onMapCreated: context.read<MovieCubit>().setMapController,
                  markers: state.selectedMovie?.marker != null
                      ? {state.selectedMovie!.marker!}
                      : null,
                  onMyLocationTap: () {
                    context.read<MovieCubit>().getCurrentLocation(context);
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 15,
                    right: 15,
                    top: kToolbarHeight +
                        MediaQuery.of(context).padding.top +
                        20,
                  ),
                  child: AbsorbPointer(
                    absorbing:
                        !(state.movies != null && state.movies!.isNotEmpty),
                    child: Opacity(
                      opacity:
                          (state.movies != null && state.movies!.isNotEmpty)
                              ? 1
                              : 0.5,
                      child: AutoCompleteSearchWidget(
                        textController: textController,
                        suggestionsCallback: (query) async {
                          final movies = await context
                              .read<MovieCubit>()
                              .searchMovies(query);
                          return movies;
                        },
                        onClearTap: (controller) {
                          controller.clear();
                        },
                        onSelected: (movie) {
                          textController.text = movie.title;
                          context.read<MovieCubit>().onMovieSelect(
                                selectedMovie: movie,
                                context: context,
                              );
                        },
                      ),
                    ),
                  ),
                ),
                if (state.isLoading != null && state.isLoading!)
                  SizedBox.expand(
                    child: ColoredBox(
                      color: Colors.black38,
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: CircularProgressIndicator(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
