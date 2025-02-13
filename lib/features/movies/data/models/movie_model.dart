// lib/data/models/movie_model.dart
import 'package:movie_app_assessment/features/movies/domain/entities/movie_entity.dart';

import '../../../../core/network/network_config.dart';

class MovieModel extends MovieEntity {
  MovieModel({
    required super.adult,
    required super.backdropPath,
    required super.genreIds,
    required super.id,
    required super.originalLanguage,
    required super.originalTitle,
    required super.overview,
    required super.popularity,
    required super.posterPath,
    required super.releaseDate,
    required super.title,
    required super.video,
    required super.voteAverage,
    required super.voteCount,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      adult: (json['adult'] ?? true) as bool,
      backdropPath: (json['backdrop_path'] ?? '') as String,
      genreIds: List<int>.from((json['genre_ids'] ?? []) as List),
      id: (json['id'] ?? 0) as int,
      originalLanguage: (json['original_language'] ?? '') as String,
      originalTitle: (json['original_title'] ?? '') as String,
      overview: (json['overview'] ?? '') as String,
      popularity: ((json['popularity'] ?? 0) as num).toDouble(),
      posterPath: NetworkConfigs.imageDomain + (json['poster_path'] ?? ''),
      releaseDate: (json['release_date'] ?? '') as String,
      title: (json['title'] ?? '') as String,
      video: (json['video'] ?? false) as bool,
      voteAverage: (json['vote_average'] as num).toDouble(),
      voteCount: (json['vote_count'] ?? 0) as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'adult': adult,
      'backdrop_path': backdropPath,
      'genre_ids': genreIds,
      'id': id,
      'original_language': originalLanguage,
      'original_title': originalTitle,
      'overview': overview,
      'popularity': popularity,
      'poster_path': posterPath,
      'release_date': releaseDate,
      'title': title,
      'video': video,
      'vote_average': voteAverage,
      'vote_count': voteCount,
    };
  }
}
