import 'package:core/core.dart'
    show
        ContentCardList,
        DrawerItem,
        failedToFetchDataMessage,
        kBodyText,
        routeObserver,
        watchlistTVShowEmptyMessage;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_shows/src/presentation/bloc/watchlist_tv_shows/watchlist_tv_shows_bloc.dart';

import 'tv_show_detail_page.dart';

class WatchlistTVShowsPage extends StatefulWidget {
  const WatchlistTVShowsPage({Key? key}) : super(key: key);

  @override
  _WatchlistTVShowsPageState createState() => _WatchlistTVShowsPageState();
}

class _WatchlistTVShowsPageState extends State<WatchlistTVShowsPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<WatchlistTVShowsBloc>().add(OnFetchTVShowWatchlist());
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    context.read<WatchlistTVShowsBloc>().add(OnFetchTVShowWatchlist());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 12.0),
      child: BlocBuilder<WatchlistTVShowsBloc, WatchlistTVShowsState>(
        builder: (context, watchlistState) {
          if (watchlistState is TVShowWatchlistLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (watchlistState is TVShowWatchlistHasData) {
            final watchlistTVShows = watchlistState.result;

            return ListView.builder(
              itemBuilder: (context, index) {
                final tvShow = watchlistTVShows[index];

                return ContentCardList(
                  activeDrawerItem: DrawerItem.tvShow,
                  routeName: TVShowDetailPage.routeName,
                  tvShow: tvShow,
                  movie: null,
                );
              },
              itemCount: watchlistTVShows.length,
            );
          } else if (watchlistState is TVShowWatchlistEmpty) {
            return Center(
              child: Text(watchlistTVShowEmptyMessage, style: kBodyText),
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
