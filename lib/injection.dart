import 'package:core/core.dart';
import 'package:ditonton/presentation/bloc/search/search_movies_bloc.dart';
import 'package:ditonton/presentation/bloc/search/search_tv_shows_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:movies/movies.dart'
    show
        MovieDetailBloc,
        MovieRecommendationsBloc,
        NowPlayingMoviesBloc,
        PopularMoviesBloc,
        TopRatedMoviesBloc,
        WatchlistMoviesBloc;
import 'package:tv_shows/tv_shows.dart'
    show
        NowPlayingTVShowsBloc,
        PopularTVShowsBloc,
        TVShowDetailBloc,
        TVShowRecommendationsBloc,
        TopRatedTVShowsBloc,
        WatchlistTVShowsBloc;

final locator = GetIt.instance;

void init() {
  // bloc
  locator.registerFactory(() => NowPlayingMoviesBloc(locator()));
  locator.registerFactory(() => PopularMoviesBloc(locator()));
  locator.registerFactory(() => MovieRecommendationsBloc(locator()));
  locator.registerFactory(() => TopRatedMoviesBloc(locator()));
  locator.registerFactory(() => MovieDetailBloc(locator()));
  locator.registerFactory(() => WatchlistMoviesBloc(
        locator(),
        locator(),
        locator(),
        locator(),
      ));

  locator.registerFactory(() => NowPlayingTVShowsBloc(locator()));
  locator.registerFactory(() => PopularTVShowsBloc(locator()));
  locator.registerFactory(() => TVShowRecommendationsBloc(locator()));
  locator.registerFactory(() => TopRatedTVShowsBloc(locator()));
  locator.registerFactory(() => TVShowDetailBloc(locator()));
  locator.registerFactory(() => WatchlistTVShowsBloc(
        locator(),
        locator(),
        locator(),
        locator(),
      ));

  locator.registerFactory(() => SearchMoviesBloc(locator()));
  locator.registerFactory(() => SearchTVShowsBloc(locator()));

  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetNowPlayingTVShows(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetPopularTVShows(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedTVShows(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetTVShowDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => GetTVShowRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => SearchTVShows(locator()));
  locator.registerLazySingleton(() => GetWatchListStatusMovie(locator()));
  locator.registerLazySingleton(() => GetWatchListStatusTVShow(locator()));
  locator.registerLazySingleton(() => SaveWatchlistMovie(locator()));
  locator.registerLazySingleton(() => SaveWatchlistTVShow(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistMovie(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistTVShow(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));
  locator.registerLazySingleton(() => GetWatchlistTVShows(locator()));

  // repositories
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<TVShowRepository>(
    () => TVShowRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TVShowRemoteDataSource>(
      () => TVShowRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));
  locator.registerLazySingleton<TVShowLocalDataSource>(
      () => TVShowLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  locator.registerLazySingleton(() => HttpSSLPinning.client);
}
