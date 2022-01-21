import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart'
    show DrawerItem, Movie, TVShow, baseImageUrl, kRichBlack;
import 'package:flutter/material.dart';

class CardImageFull extends StatelessWidget {
  const CardImageFull({
    Key? key,
    required this.activeDrawerItem,
    required this.routeNameDestination,
    this.movie,
    this.tvShow,
  }) : super(key: key);

  final Movie? movie;
  final TVShow? tvShow;
  final DrawerItem activeDrawerItem;
  final String routeNameDestination;

  @override
  Widget build(BuildContext context) {
    final id =
        activeDrawerItem == DrawerItem.movie ? movie?.id : tvShow?.id as int;
    final posterPath = activeDrawerItem == DrawerItem.movie
        ? movie?.posterPath
        : tvShow?.posterPath as String;

    return Container(
      padding: const EdgeInsets.all(8),
      child: Material(
        color: kRichBlack,
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(
              context,
              routeNameDestination,
              arguments: id,
            );
          },
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            child: CachedNetworkImage(
              imageUrl: '$baseImageUrl$posterPath',
              placeholder: (context, url) => const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
        ),
      ),
    );
  }
}
