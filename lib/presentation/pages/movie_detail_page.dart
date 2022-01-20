import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/formatting_utils.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/presentation/provider/movie_detail_notifier.dart';
import 'package:ditonton/presentation/widgets/scrollable_sheet_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class MovieDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/detail-movie';

  MovieDetailPage({required this.id});

  final int id;

  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<MovieDetailNotifier>(context, listen: false)
          .fetchMovieDetail(widget.id);
      Provider.of<MovieDetailNotifier>(context, listen: false)
          .loadWatchlistStatus(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Consumer<MovieDetailNotifier>(
          builder: (context, provider, child) {
            if (provider.movieState == RequestState.Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (provider.movieState == RequestState.Loaded) {
              final movie = provider.movie;
              return DetailContent(movie, provider);
            } else {
              return Center(
                child: Text(provider.message),
              );
            }
          },
        ),
      ),
    );
  }
}

class DetailContent extends StatelessWidget {
  final MovieDetail movie;
  final MovieDetailNotifier provider;

  DetailContent(this.movie, this.provider);

  @override
  Widget build(BuildContext context) {
    return ScrollableSheetContainer(
      backgroundUrl: '$BASE_IMAGE_URL${movie.posterPath}',
      scrollableContents: [
        Text(
          movie.title,
          style: kHeading5,
        ),
        ElevatedButton(
          onPressed: () async {
            if (!provider.isAddedToWatchlist) {
              await provider.addWatchlist(movie);
            } else {
              await provider.removeFromWatchlist(movie);
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
          getFormattedGenres(movie.genres),
        ),
        Text(
          getFormattedDuration(movie.runtime),
        ),
        Row(
          children: [
            RatingBarIndicator(
              rating: movie.voteAverage / 2,
              itemCount: 5,
              itemBuilder: (context, index) => Icon(
                Icons.star,
                color: kMikadoYellow,
              ),
              itemSize: 24,
            ),
            Text('${movie.voteAverage}')
          ],
        ),
        SizedBox(height: 16),
        Text(
          'Overview',
          style: kHeading6,
        ),
        Text(
          movie.overview.isNotEmpty ? movie.overview : "-",
        ),
        SizedBox(height: 16),
        Text(
          'Recommendations',
          style: kHeading6,
        ),
        provider.movieRecommendations.isNotEmpty
            ? Container(
                margin: EdgeInsets.only(top: 8.0),
                height: 150,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final movieRecoms = provider.movieRecommendations[index];
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.pushReplacementNamed(
                            context,
                            MovieDetailPage.ROUTE_NAME,
                            arguments: movieRecoms.id,
                          );
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                          child: CachedNetworkImage(
                            imageUrl:
                                '$BASE_IMAGE_URL${movieRecoms.posterPath}',
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
                  itemCount: provider.movieRecommendations.length,
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
