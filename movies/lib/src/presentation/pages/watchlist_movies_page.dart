import 'package:core/core.dart'
    show
        ContentCardList,
        DrawerItem,
        failedToFetchDataMessage,
        kBodyText,
        routeObserver,
        watchlistMovieEmptyMessage;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/movies.dart';

class WatchlistMoviesPage extends StatefulWidget {
  const WatchlistMoviesPage({Key? key}) : super(key: key);

  @override
  _WatchlistMoviesPageState createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistMoviesPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<WatchlistMoviesBloc>().add(OnFetchMovieWatchlist());
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    context.read<WatchlistMoviesBloc>().add(OnFetchMovieWatchlist());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 12.0),
      child: BlocBuilder<WatchlistMoviesBloc, WatchlistMoviesState>(
        builder: (context, watchlistState) {
          if (watchlistState is MovieWatchlistLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (watchlistState is MovieWatchlistHasData) {
            final watchlistMovies = watchlistState.result;
            return ListView.builder(
              itemBuilder: (context, index) {
                final movie = watchlistMovies[index];

                return ContentCardList(
                  activeDrawerItem: DrawerItem.movie,
                  routeName: MovieDetailPage.routeName,
                  movie: movie,
                  tvShow: null,
                );
              },
              itemCount: watchlistMovies.length,
            );
          } else if (watchlistState is MovieWatchlistEmpty) {
            return Center(
              child: Text(watchlistMovieEmptyMessage, style: kBodyText),
            );
          } else {
            return const Center(
              key: Key('error_message'),
              child: Text(failedToFetchDataMessage),
            );
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
