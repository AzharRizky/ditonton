library core;

// -> END SSL PINNING

export './src/common/constants.dart';
export './src/common/drawer_item_enum.dart';
export './src/common/exception.dart';
export './src/common/failure.dart';
export './src/common/formatting_utils.dart';
export './src/common/mapper/list_mapper.dart';

// --------- COMMON
// -> MAPPER
export './src/common/mapper/mapper.dart';
export './src/common/mapper/nullable_input_list_mapper.dart';
export './src/common/mapper/nullable_output_list_mapper.dart';
export './src/common/ssl_pinning/http_ssl_pinning.dart';

// -> SSL PINNING
export './src/common/ssl_pinning/shared.dart';
export './src/common/state_enum.dart';

// --------- DATA
// -> DATA SOURCES
// --> DB
export './src/data/datasources/db/database_helper.dart';
// --> END DB

export './src/data/datasources/movie_local_data_source.dart';
export './src/data/datasources/movie_remote_data_source.dart';
export './src/data/datasources/tv_show_local_data_source.dart';
export './src/data/datasources/tv_show_remote_data_source.dart';

// -> MODELS
export './src/data/models/genre_model.dart';
export './src/data/models/movie_detail_model.dart';
export './src/data/models/movie_model.dart';
export './src/data/models/movie_response.dart';
export './src/data/models/movie_table.dart';
export './src/data/models/season_model.dart';
export './src/data/models/tv_show_detail_model.dart';
export './src/data/models/tv_show_model.dart';
export './src/data/models/tv_show_response.dart';
export './src/data/models/tv_show_table.dart';

// -> REPOSITORIES
export './src/data/repositories/movie_repository_impl.dart';
export './src/data/repositories/tv_show_repository_impl.dart';

// --------- DOMAIN
// -> ENTITIES
export './src/domain/entities/genre.dart';
export './src/domain/entities/movie.dart';
export './src/domain/entities/movie_detail.dart';
export './src/domain/entities/season.dart';
export './src/domain/entities/tv_show.dart';
export './src/domain/entities/tv_show_detail.dart';

// -> REPOSITORIES
export './src/domain/repositories/movie_repository.dart';
export './src/domain/repositories/tv_show_repository.dart';

// -> USECASES
// --> MOVIE
export './src/domain/usecases/movie/get_movie_detail.dart';
export './src/domain/usecases/movie/get_movie_detail.dart';
export './src/domain/usecases/movie/get_movie_recommendations.dart';
export './src/domain/usecases/movie/get_now_playing_movies.dart';
export './src/domain/usecases/movie/get_popular_movies.dart';
export './src/domain/usecases/movie/get_top_rated_movies.dart';
export './src/domain/usecases/movie/get_watchlist_movies.dart';
export './src/domain/usecases/movie/get_watchlist_status_movie.dart';
export './src/domain/usecases/movie/search_movies.dart';
export './src/domain/usecases/tv_show/get_now_playing_tv_shows.dart';
export './src/domain/usecases/tv_show/get_popular_tv_shows.dart';
export './src/domain/usecases/tv_show/get_top_rated_tv_shows.dart';

// --> TV SHOW
export './src/domain/usecases/tv_show/get_tv_show_detail.dart';
export './src/domain/usecases/tv_show/get_tv_show_detail.dart';
export './src/domain/usecases/tv_show/get_tv_show_recommendations.dart';
export './src/domain/usecases/tv_show/get_watchlist_status_tv_show.dart';
export './src/domain/usecases/tv_show/get_watchlist_tv_shows.dart';
export './src/domain/usecases/tv_show/search_tv_shows.dart';

// --------- PRESENTATION
export './src/presentation/widgets/card_image_full.dart';
export './src/presentation/widgets/content_card_list.dart';
export './src/presentation/widgets/scrollable_sheet_container.dart';
export './src/presentation/widgets/sub_heading.dart';
export 'src/domain/usecases/movie/remove_watchlist_movie.dart';
export 'src/domain/usecases/movie/save_watchlist_movie.dart';
export 'src/domain/usecases/tv_show/remove_watchlist_tv_show.dart';
export 'src/domain/usecases/tv_show/save_watchlist_tv_show.dart';

// --------- UTILS
export './src/common/utils.dart';
// --------- END UTILS

// --------- END PRESENTATION
