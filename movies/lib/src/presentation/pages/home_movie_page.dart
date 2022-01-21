import 'package:core/core.dart'
    show
        CardImageFull,
        DrawerItem,
        Movie,
        SubHeading,
        failedToFetchDataMessage,
        kHeading6,
        nowPlayingHeadingText,
        popularHeadingText,
        topRatedHeadingText;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/src/presentation/bloc/now_playing_movies/now_playing_movies_bloc.dart';
import 'package:movies/src/presentation/bloc/popular_movies/popular_movies_bloc.dart';
import 'package:movies/src/presentation/bloc/top_rated_movies/top_rated_movies_bloc.dart';
import 'package:movies/src/presentation/pages/movie_detail_page.dart';
import 'package:movies/src/presentation/pages/popular_movies_page.dart';
import 'package:movies/src/presentation/pages/top_rated_movies_page.dart';

class HomeMoviePage extends StatefulWidget {
  const HomeMoviePage({Key? key}) : super(key: key);

  @override
  _HomeMoviePageState createState() => _HomeMoviePageState();
}

class _HomeMoviePageState extends State<HomeMoviePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<NowPlayingMoviesBloc>().add(OnNowPlayingMoviesCalled());
      context.read<PopularMoviesBloc>().add(OnPopularMoviesCalled());
      context.read<TopRatedMoviesBloc>().add(OnTopRatedMoviesCalled());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              nowPlayingHeadingText,
              style: kHeading6,
            ),
            BlocBuilder<NowPlayingMoviesBloc, NowPlayingMoviesState>(
              builder: (context, state) {
                if (state is NowPlayingMoviesLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is NowPlayingMoviesHasData) {
                  final data = state.result;
                  return MovieList(
                    movies: data,
                    description: 'now_playing_movies',
                  );
                } else if (state is NowPlayingMoviesError) {
                  return const Text(
                    failedToFetchDataMessage,
                    key: Key('error_message'),
                  );
                } else {
                  return Container();
                }
              },
            ),
            const SizedBox(height: 8.0),
            SubHeading(
              key: const Key('see_more_popular_movies'),
              title: popularHeadingText,
              onTap: () =>
                  Navigator.pushNamed(context, PopularMoviesPage.routeName),
            ),
            BlocBuilder<PopularMoviesBloc, PopularMoviesState>(
              builder: (context, state) {
                if (state is PopularMoviesLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is PopularMoviesHasData) {
                  final data = state.result;
                  return MovieList(
                    movies: data,
                    description: 'popular_movies',
                  );
                } else if (state is PopularMoviesError) {
                  return const Text(
                    failedToFetchDataMessage,
                    key: Key('error_message'),
                  );
                } else {
                  return Container();
                }
              },
            ),
            const SizedBox(height: 8.0),
            SubHeading(
              key: const Key('see_more_top_rated_movies'),
              title: topRatedHeadingText,
              onTap: () =>
                  Navigator.pushNamed(context, TopRatedMoviesPage.routeName),
            ),
            BlocBuilder<TopRatedMoviesBloc, TopRatedMoviesState>(
              builder: (context, state) {
                if (state is TopRatedMoviesLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is TopRatedMoviesHasData) {
                  final data = state.result;
                  return MovieList(
                    movies: data,
                    description: 'top_rated_movies',
                  );
                } else if (state is TopRatedMoviesError) {
                  return const Text(
                    failedToFetchDataMessage,
                    key: Key('error_message'),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class MovieList extends StatelessWidget {
  final List<Movie> movies;
  final String description;

  const MovieList({Key? key, required this.movies, required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return CardImageFull(
            key: Key("$description-$index"),
            activeDrawerItem: DrawerItem.movie,
            routeNameDestination: MovieDetailPage.routeName,
            movie: movie,
          );
        },
        itemCount: movies.length,
      ),
    );
  }
}
