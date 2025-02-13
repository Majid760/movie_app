import '../../domain/entities/movies_entity.dart';
import 'movie_model.dart';

class MoviesModel extends MoviesEntity {
  MoviesModel({
    required DatesModel super.dates,
    required super.page,
    required super.totalResults,
    required super.totalPages,
    required List<MovieModel> results,
  }) : super(results: results);

  factory MoviesModel.fromJson(Map<String, dynamic> json) {
    return MoviesModel(
      dates: DatesModel.fromJson(json['dates'] ?? {"maximum": "", "minimum": ""}),
      page: json['page'],
      totalResults: json['total_results'],
      totalPages: json['total_pages'],
      results: (json['results'] as List).map((e) => MovieModel.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dates': (dates as DatesModel).toJson(),
      'page': page,
      'results': results.map((e) => (e as MovieModel).toJson()).toList(),
    };
  }
}

class DatesModel extends DatesEntity {
  DatesModel({
    required super.maximum,
    required super.minimum,
  });

  factory DatesModel.fromJson(Map<String, dynamic> json) {
    return DatesModel(
      maximum: json['maximum'],
      minimum: json['minimum'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'maximum': maximum,
      'minimum': minimum,
    };
  }
}
