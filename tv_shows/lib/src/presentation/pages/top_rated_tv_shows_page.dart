import 'package:core/core.dart' show ContentCardList, DrawerItem;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_shows/src/presentation/bloc/top_rated_tv_shows/top_rated_tv_shows_bloc.dart';
import 'package:tv_shows/src/presentation/pages/tv_show_detail_page.dart';

class TopRatedTVShowsPage extends StatefulWidget {
  static const routeName = '/top-rated-tvshow';

  const TopRatedTVShowsPage({Key? key}) : super(key: key);

  @override
  _TopRatedTVShowsPageState createState() => _TopRatedTVShowsPageState();
}

class _TopRatedTVShowsPageState extends State<TopRatedTVShowsPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        BlocProvider.of<TopRatedTVShowsBloc>(context, listen: false)
            .add(OnTopRatedTVShowsCalled()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated TVShows'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TopRatedTVShowsBloc, TopRatedTVShowsState>(
          key: const Key('top_rated_tv_shows'),
          builder: (context, state) {
            if (state is TopRatedTVShowsLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TopRatedTVShowsHasData) {
              final tvShows = state.result;

              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvShow = tvShows[index];

                  return ContentCardList(
                    activeDrawerItem: DrawerItem.tvShow,
                    routeName: TVShowDetailPage.routeName,
                    tvShow: tvShow,
                    movie: null,
                  );
                },
                itemCount: tvShows.length,
              );
            } else {
              return Center(
                key: const Key('error_message'),
                child: Text((state as TopRatedTVShowsError).message),
              );
            }
          },
        ),
      ),
    );
  }
}
