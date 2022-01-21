import 'package:core/core.dart'
    show
        CardImageFull,
        DrawerItem,
        SubHeading,
        TVShow,
        failedToFetchDataMessage,
        kHeading6,
        nowPlayingHeadingText,
        popularHeadingText,
        topRatedHeadingText;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_shows/src/presentation/bloc/now_playing_tv_shows/now_playing_tv_shows_bloc.dart';
import 'package:tv_shows/src/presentation/bloc/popular_tv_shows/popular_tv_shows_bloc.dart';
import 'package:tv_shows/src/presentation/bloc/top_rated_tv_shows/top_rated_tv_shows_bloc.dart';
import 'package:tv_shows/src/presentation/pages/popular_tv_shows_page.dart';
import 'package:tv_shows/src/presentation/pages/top_rated_tv_shows_page.dart';
import 'package:tv_shows/src/presentation/pages/tv_show_detail_page.dart';

class HomeTVShowPage extends StatefulWidget {
  const HomeTVShowPage({Key? key}) : super(key: key);

  @override
  _HomeTVShowPageState createState() => _HomeTVShowPageState();
}

class _HomeTVShowPageState extends State<HomeTVShowPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<NowPlayingTVShowsBloc>().add(OnNowPlayingTVShowsCalled());
      context.read<PopularTVShowsBloc>().add(OnPopularTVShowsCalled());
      context.read<TopRatedTVShowsBloc>().add(OnTopRatedTVShowsCalled());
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
            BlocBuilder<NowPlayingTVShowsBloc, NowPlayingTVShowsState>(
              key: const Key('now_playing_tv_shows'),
              builder: (context, state) {
                if (state is NowPlayingTVShowsLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is NowPlayingTVShowsHasData) {
                  return TVShowList(
                    tvShows: state.result,
                    description: 'now_playing_tv_shows',
                  );
                } else {
                  return const Text(
                    failedToFetchDataMessage,
                    key: Key('error_message'),
                  );
                }
              },
            ),
            const SizedBox(height: 8.0),
            SubHeading(
              title: popularHeadingText,
              onTap: () =>
                  Navigator.pushNamed(context, PopularTVShowsPage.routeName),
            ),
            BlocBuilder<PopularTVShowsBloc, PopularTVShowsState>(
              key: const Key('popular_tv_shows'),
              builder: (context, state) {
                if (state is PopularTVShowsLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is PopularTVShowsHasData) {
                  return TVShowList(
                    tvShows: state.result,
                    description: 'popular_tv_shows',
                  );
                } else {
                  return const Text(
                    failedToFetchDataMessage,
                    key: Key('error_message'),
                  );
                }
              },
            ),
            SubHeading(
              title: topRatedHeadingText,
              onTap: () =>
                  Navigator.pushNamed(context, TopRatedTVShowsPage.routeName),
            ),
            const SizedBox(height: 8.0),
            BlocBuilder<TopRatedTVShowsBloc, TopRatedTVShowsState>(
              key: const Key('top_rated_tv_shows'),
              builder: (context, state) {
                if (state is TopRatedTVShowsLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is TopRatedTVShowsHasData) {
                  return TVShowList(
                    tvShows: state.result,
                    description: 'top_rated_tv_shows',
                  );
                } else {
                  return const Text(
                    failedToFetchDataMessage,
                    key: Key('error_message'),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class TVShowList extends StatelessWidget {
  final List<TVShow> tvShows;
  final String description;

  const TVShowList({
    Key? key,
    required this.tvShows,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final _tvShow = tvShows[index];
          return CardImageFull(
            key: Key("$description-$index"),
            activeDrawerItem: DrawerItem.tvShow,
            routeNameDestination: TVShowDetailPage.routeName,
            tvShow: _tvShow,
          );
        },
        itemCount: tvShows.length,
      ),
    );
  }
}
