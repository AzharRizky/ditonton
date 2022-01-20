import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/drawer_item_enum.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/pages/tv_show_detail_page.dart';
import 'package:ditonton/presentation/provider/watchlist_tv_show_notifier.dart';
import 'package:ditonton/presentation/widgets/content_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WatchlistTVShowsPage extends StatefulWidget {
  @override
  _WatchlistTVShowsPageState createState() => _WatchlistTVShowsPageState();
}

class _WatchlistTVShowsPageState extends State<WatchlistTVShowsPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<WatchlistTVShowNotifier>(context, listen: false)
            .fetchWatchlistTVShows());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 12.0),
      child: Consumer<WatchlistTVShowNotifier>(
        builder: (context, data, child) {
          if (data.watchlistState == RequestState.Loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (data.watchlistState == RequestState.Loaded) {
            if (data.watchlistTVShows.isEmpty)
              return Center(
                child: Text(WACHLIST_TV_SHOW_EMPTY_MESSAGE, style: kBodyText),
              );

            return ListView.builder(
              itemBuilder: (context, index) {
                final tvShow = data.watchlistTVShows[index];

                return ContentCardList(
                  activeDrawerItem: DrawerItem.TVShow,
                  routeName: TVShowDetailPage.ROUTE_NAME,
                  tvShow: tvShow,
                );
              },
              itemCount: data.watchlistTVShows.length,
            );
          } else {
            return Center(
              key: Key('error_message'),
              child: Text(data.message),
            );
          }
        },
      ),
    );
  }
}
