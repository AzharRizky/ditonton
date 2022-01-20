import 'package:ditonton/domain/repositories/tv_show_repository.dart';

class GetWatchListStatusTVShow {
  final TVShowRepository repository;

  GetWatchListStatusTVShow(this.repository);

  Future<bool> execute(int id) async {
    return repository.isAddedToWatchlist(id);
  }
}
