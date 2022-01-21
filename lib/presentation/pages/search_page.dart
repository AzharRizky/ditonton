import 'package:core/core.dart'
    show ContentCardList, DrawerItem, Movie, TVShow, kBodyText, kHeading6;
import 'package:ditonton/presentation/bloc/search/search_movies_bloc.dart';
import 'package:ditonton/presentation/bloc/search/search_tv_shows_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/movies.dart' show MovieDetailPage;
import 'package:tv_shows/tv_shows.dart' show TVShowDetailPage;

class SearchPage extends StatelessWidget {
  static const routeName = '/search';

  SearchPage({
    Key? key,
    required this.activeDrawerItem,
  }) : super(key: key);

  final DrawerItem activeDrawerItem;
  late final String _title;

  @override
  Widget build(BuildContext context) {
    _title = activeDrawerItem == DrawerItem.movie ? "Movie" : "TV Show";

    return Scaffold(
      appBar: AppBar(
        title: Text('Search $_title\s'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onSubmitted: (query) {
                if (activeDrawerItem == DrawerItem.movie)
                  context
                      .read<SearchMoviesBloc>()
                      .add(OnQueryMoviesChange(query));
                else
                  context
                      .read<SearchTVShowsBloc>()
                      .add(OnQueryTVShowsChange(query));
              },
              decoration: InputDecoration(
                hintText: 'Search title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            SizedBox(height: 16),
            Text(
              'Search Result',
              style: kHeading6,
            ),
            _buildSearchResults(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchResults() {
    if (activeDrawerItem == DrawerItem.movie) {
      return BlocBuilder<SearchMoviesBloc, SearchMoviesState>(
        key: const Key('search_movies'),
        builder: (context, state) {
          if (state is SearchMoviesLoading) {
            return Container(
              margin: EdgeInsets.only(top: 32.0),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is SearchMoviesHasData) {
            final movies = state.result;
            return _buildMovieCardList(movies);
          } else if (state is SearchMoviesEmpty) {
            return _buildMovieCardList([]);
          } else if (state is SearchMoviesError) {
            return _buildErrorMessage();
          } else {
            return Container();
          }
        },
      );
    } else {
      return BlocBuilder<SearchTVShowsBloc, SearchTVShowsState>(
        key: const Key('search_tv_shows'),
        builder: (context, state) {
          if (state is SearchTVShowsLoading) {
            return Container(
              margin: EdgeInsets.only(top: 32.0),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is SearchTVShowsHasData) {
            final tvShows = state.result;
            return _buildTVShowCardList(tvShows);
          } else if (state is SearchTVShowsEmpty) {
            return _buildTVShowCardList([]);
          } else if (state is SearchTVShowsError) {
            return _buildErrorMessage();
          } else {
            return Container();
          }
        },
      );
    }
  }

  Widget _buildMovieCardList(List<Movie> movies) {
    if (movies.isEmpty) return _buildErrorMessage();

    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemBuilder: (context, index) {
          final movie = movies[index];
          return ContentCardList(
            movie: movie,
            activeDrawerItem: activeDrawerItem,
            routeName: MovieDetailPage.routeName,
            tvShow: null,
          );
        },
        itemCount: movies.length,
      ),
    );
  }

  Widget _buildTVShowCardList(List<TVShow> tvShows) {
    if (tvShows.isEmpty) return _buildErrorMessage();

    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemBuilder: (context, index) {
          final tvShow = tvShows[index];
          return ContentCardList(
            tvShow: tvShow,
            activeDrawerItem: activeDrawerItem,
            routeName: TVShowDetailPage.routeName,
            movie: null,
          );
        },
        itemCount: tvShows.length,
      ),
    );
  }

  Widget _buildErrorMessage() => Container(
        key: const Key('error_message'),
        margin: EdgeInsets.only(top: 32.0),
        child: Center(
          child: Text(
            '$_title\s not found!',
            style: kBodyText,
          ),
        ),
      );
}
