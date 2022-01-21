import 'package:core/core.dart' show ContentCardList, DrawerItem;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_shows/src/presentation/bloc/popular_tv_shows/popular_tv_shows_bloc.dart';
import 'package:tv_shows/src/presentation/pages/tv_show_detail_page.dart';

class PopularTVShowsPage extends StatefulWidget {
  static const routeName = '/popular-tvshow';

  const PopularTVShowsPage({Key? key}) : super(key: key);

  @override
  _PopularTVShowsPageState createState() => _PopularTVShowsPageState();
}

class _PopularTVShowsPageState extends State<PopularTVShowsPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => context.read<PopularTVShowsBloc>().add(OnPopularTVShowsCalled()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular TVShows'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularTVShowsBloc, PopularTVShowsState>(
          key: const Key('popular_page'),
          builder: (context, state) {
            if (state is PopularTVShowsLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is PopularTVShowsHasData) {
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
                child: Text((state as PopularTVShowsError).message),
              );
            }
          },
        ),
      ),
    );
  }
}
