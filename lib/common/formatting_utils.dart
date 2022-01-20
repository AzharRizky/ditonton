import 'package:ditonton/domain/entities/genre.dart';

String getFormattedGenres(List<Genre> genres) {
  String result = '';
  for (var genre in genres) {
    result += genre.name + ', ';
  }

  if (result.isEmpty) {
    return result;
  }

  return result.substring(0, result.length - 2);
}

String getFormattedDurationFromList(List<int> runtimes) =>
    runtimes.map((runtime) => getFormattedDuration(runtime)).join(", ");

String getFormattedDuration(int runtime) {
  final int hours = runtime ~/ 60;
  final int minutes = runtime % 60;

  if (hours > 0) {
    return '${hours}h ${minutes}m';
  } else {
    return '${minutes}m';
  }
}
