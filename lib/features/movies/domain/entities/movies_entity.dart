import 'movie_entity.dart';

class MoviesEntity {
  final DatesEntity dates;
  final int page;
  final int totalResults;
  final int totalPages;
  final List<MovieEntity> results;

  MoviesEntity({
    required this.dates,
    required this.page,
    required this.totalResults,
    required this.totalPages,
    required this.results,
  });
}

class DatesEntity {
  final String maximum;
  final String minimum;

  DatesEntity({
    required this.maximum,
    required this.minimum,
  });
}
