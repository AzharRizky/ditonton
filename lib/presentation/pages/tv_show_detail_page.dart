import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/formatting_utils.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_show_detail.dart';
import 'package:ditonton/presentation/provider/tv_show_detail_notifier.dart';
import 'package:ditonton/presentation/widgets/scrollable_sheet_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class TVShowDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/detail-tvshow';

  TVShowDetailPage({Key? key, required this.id}) : super(key: key);

  final int id;

  @override
  _TVShowDetailPageState createState() => _TVShowDetailPageState();
}

class _TVShowDetailPageState extends State<TVShowDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<TVShowDetailNotifier>(context, listen: false)
          .fetchTVShowDetail(widget.id);
      Provider.of<TVShowDetailNotifier>(context, listen: false)
          .loadWatchlistStatus(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Consumer<TVShowDetailNotifier>(
          builder: (ctx, provider, child) {
            if (provider.tvShowState == RequestState.Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (provider.tvShowState == RequestState.Loaded) {
              final tvShow = provider.tvShowDetail;
              return DetailContent(tvShow, provider);
            } else {
              return Center(child: Text(provider.message));
            }
          },
        ),
      ),
    );
  }
}

class DetailContent extends StatelessWidget {
  final TVShowDetail tvShow;
  final TVShowDetailNotifier provider;

  DetailContent(this.tvShow, this.provider);

  @override
  Widget build(BuildContext context) {
    return ScrollableSheetContainer(
      backgroundUrl: '$BASE_IMAGE_URL${tvShow.posterPath}',
      scrollableContents: [
        Text(
          tvShow.name,
          style: kHeading5,
        ),
        ElevatedButton(
          onPressed: () async {
            if (!provider.isAddedToWatchlist) {
              await provider.addWatchlist(tvShow);
            } else {
              await provider.removeFromWatchlist(tvShow);
            }

            final message = provider.watchlistMessage;

            if (message == WATCHLIST_ADD_SUCCESS_MESSAGE ||
                message == WATCHLIST_REMOVE_SUCCESS_MESSAGE) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(message)));
            } else {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Text(message),
                    );
                  });
            }
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              provider.isAddedToWatchlist ? Icon(Icons.check) : Icon(Icons.add),
              SizedBox(width: 6.0),
              Text('Watchlist'),
              SizedBox(width: 4.0),
            ],
          ),
        ),
        Text(
          getFormattedGenres(tvShow.genres),
        ),
        Text(
          tvShow.episodeRunTime.isNotEmpty
              ? getFormattedDurationFromList(tvShow.episodeRunTime)
              : 'N/A',
        ),
        Row(
          children: [
            RatingBarIndicator(
              rating: tvShow.voteAverage / 2,
              itemCount: 5,
              itemBuilder: (context, index) => Icon(
                Icons.star,
                color: kMikadoYellow,
              ),
              itemSize: 24,
            ),
            Text('${tvShow.voteAverage}')
          ],
        ),
        SizedBox(height: 12.0),
        Text(
          'Total Episodes: ' + tvShow.numberOfEpisodes.toString(),
        ),
        Text(
          'Total Seasons: ' + tvShow.numberOfSeasons.toString(),
        ),
        SizedBox(height: 16),
        Text(
          'Overview',
          style: kHeading6,
        ),
        Text(
          tvShow.overview.isNotEmpty ? tvShow.overview : "-",
        ),
        SizedBox(height: 16),
        Text(
          'Recommendations',
          style: kHeading6,
        ),
        provider.tvShowRecommendations.isNotEmpty
            ? Container(
                margin: EdgeInsets.only(top: 8.0),
                height: 150,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final tvShowRecoms = provider.tvShowRecommendations[index];
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.pushReplacementNamed(
                            context,
                            TVShowDetailPage.ROUTE_NAME,
                            arguments: tvShowRecoms.id,
                          );
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                          child: CachedNetworkImage(
                            imageUrl:
                                '$BASE_IMAGE_URL${tvShowRecoms.posterPath}',
                            placeholder: (context, url) => Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 12.0),
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: provider.tvShowRecommendations.length,
                ),
              )
            : Text('No recommendations found'),
        SizedBox(height: 16),
        Text(
          'Seasons',
          style: kHeading6,
        ),
        tvShow.seasons.isNotEmpty
            ? Container(
                height: 150,
                margin: EdgeInsets.only(top: 8.0),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (ctx, index) {
                    final season = tvShow.seasons[index];

                    return Padding(
                      padding: EdgeInsets.all(4.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                        child: Stack(
                          children: [
                            season.posterPath == null
                                ? Container(
                                    width: 96.0,
                                    decoration: BoxDecoration(
                                      color: kGrey,
                                    ),
                                    child: Center(
                                      child: Text(
                                        'No Image',
                                        style: TextStyle(color: kRichBlack),
                                      ),
                                    ),
                                  )
                                : CachedNetworkImage(
                                    imageUrl:
                                        '$BASE_IMAGE_URL${season.posterPath}',
                                    placeholder: (context, url) => Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  ),
                            Positioned.fill(
                              child: Container(
                                color: kRichBlack.withOpacity(0.65),
                              ),
                            ),
                            Positioned(
                              left: 8.0,
                              top: 4.0,
                              child: Text(
                                (index + 1).toString(),
                                style: kHeading5.copyWith(fontSize: 26.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: tvShow.seasons.length,
                ),
              )
            : Text('-'),
        SizedBox(
          height: 16.0,
        ),
      ],
    );
  }
}
