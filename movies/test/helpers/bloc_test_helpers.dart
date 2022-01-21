import 'package:core/core.dart'
    show
        GetMovieDetail,
        GetMovieRecommendations,
        GetNowPlayingMovies,
        GetPopularMovies,
        GetWatchlistMovies,
        SaveWatchlistMovie,
        RemoveWatchlistMovie,
        GetWatchListStatusMovie,
        GetTopRatedMovies;
import 'package:mockito/annotations.dart';

@GenerateMocks([
  GetMovieDetail,
  GetMovieRecommendations,
  GetNowPlayingMovies,
  GetPopularMovies,
  GetTopRatedMovies,
  GetWatchListStatusMovie,
  GetWatchlistMovies,
  SaveWatchlistMovie,
  RemoveWatchlistMovie,
])
void main() {}
