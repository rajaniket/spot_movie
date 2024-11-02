import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:spot_movie/core/theme/app_colors.dart';
import 'package:spot_movie/features/movie/presentation/cubit/movie_cubit.dart';
import '../../../../core/widgets/app_dialog.dart';
import '../../domain/usecases/get_movies_use_case.dart';
import '../cubit/movie_state.dart';
import '../ui_entity/errors_enum.dart';
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
        getMoviesUseCase: GetIt.instance<GetMoviesUseCase>(),
      )..getMovies(),
      child: BlocConsumer<MovieCubit, MovieState>(
        listener: (context, state) async {
          if (state.errorType != null) {
            switch (state.errorType!) {
              case ErrorType.noLocationInfoError:
                await customDialog(
                  context: context,
                  title: state.errorType!.getTitle(),
                  content: state.errorType!.getDescription(),
                  noButtonText: 'Ok',
                  onNoPress: () async {
                    Navigator.pop(context);
                  },
                );
              case ErrorType.unknownError:
                await customDialog(
                  context: context,
                  title: state.errorType!.getTitle(),
                  content: state.errorType!.getDescription(),
                  yesButtonText: 'Retry',
                  onNoPress: () async {
                    Navigator.pop(context);
                  },
                  onYesPress: () {
                    context.read<MovieCubit>().getMovies();
                    Navigator.pop(context);
                  },
                );
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            extendBodyBehindAppBar: true,
            backgroundColor: AppColors.screenBackgroundColorDark,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: AppColors.screenBackgroundColorDark,
              centerTitle: true,
              title: const Text(
                'Spot Movie Location',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
              ),
            ),
            body: Stack(
              children: [
                // Google Map widget displaying movie locations.
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
                  // Prevent user interaction when there are no movies to display.
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
                // Display a loading indicator if movies are being fetched.
                if (state.isLoading != null && state.isLoading!)
                  SizedBox.expand(
                    child: ColoredBox(
                      color: AppColors.screenBackgroundColorDark,
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
