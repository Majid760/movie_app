import 'package:movie_app_assessment/core/network/network_config.dart';
import 'package:movie_app_assessment/features/movies/domain/entities/movie_detail_entity.dart';

import 'movie_model.dart';

class MovieDetailModel extends MovieDetailEntity {
  MovieDetailModel({
    required super.adult,
    required super.backdropPath,
    required super.budget,
    required super.genres,
    required super.homepage,
    required super.id,
    required super.imdbId,
    required super.originCountry,
    required super.originalLanguage,
    required super.originalTitle,
    required super.overview,
    required super.popularity,
    required super.posterPath,
    required super.productionCompanies,
    required super.productionCountries,
    required super.releaseDate,
    required super.revenue,
    required super.runtime,
    required super.spokenLanguages,
    required super.status,
    required super.tagline,
    required super.title,
    required super.video,
    required super.voteAverage,
    required super.voteCount,
  });

  /// Factory method to create a MovieModel from JSON
  factory MovieDetailModel.fromJson(Map<String, dynamic> json) {
    return MovieDetailModel(
      adult: json['adult'] ?? false,
      backdropPath: json['backdrop_path'],
      budget: json['budget'] ?? 0,
      genres: (json['genres'] as List<dynamic>?)?.map((e) => GenreEntity(id: e['id'], name: e['name'])).toList() ?? [],
      homepage: json['homepage'] ?? '',
      id: json['id'] ?? 0,
      imdbId: json['imdb_id'] ?? '',
      originCountry: (json['origin_country'] as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
      originalLanguage: json['original_language'] ?? '',
      originalTitle: json['original_title'] ?? '',
      overview: json['overview'] ?? '',
      popularity: (json['popularity'] as num?)?.toDouble() ?? 0.0,
      posterPath: NetworkConfigs.imageDomain + json['poster_path'],
      productionCompanies: (json['production_companies'] as List<dynamic>?)
              ?.map((e) => ProductionCompanyEntity(
                    id: e['id'],
                    logoPath: e['logo_path'],
                    name: e['name'],
                    originCountry: e['origin_country'],
                  ))
              .toList() ??
          [],
      productionCountries: (json['production_countries'] as List<dynamic>?)
              ?.map((e) => ProductionCountryEntity(
                    isoCode: e['iso_3166_1'],
                    name: e['name'],
                  ))
              .toList() ??
          [],
      releaseDate: json['release_date'] ?? '',
      revenue: json['revenue'] ?? 0,
      runtime: json['runtime'] ?? 0,
      spokenLanguages: (json['spoken_languages'] as List<dynamic>?)
              ?.map((e) => SpokenLanguageEntity(
                    englishName: e['english_name'],
                    isoCode: e['iso_639_1'],
                    name: e['name'],
                  ))
              .toList() ??
          [],
      status: json['status'] ?? '',
      tagline: json['tagline'] ?? '',
      title: json['title'] ?? '',
      video: json['video'] ?? false,
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0.0,
      voteCount: json['vote_count'] ?? 0,
    );
  }

  /// Convert MovieModel to JSON
  Map<String, dynamic> toJson() {
    return {
      "adult": adult,
      "backdrop_path": backdropPath,
      "budget": budget,
      "genres": genres.map((e) => {"id": e.id, "name": e.name}).toList(),
      "homepage": homepage,
      "id": id,
      "imdb_id": imdbId,
      "origin_country": originCountry,
      "original_language": originalLanguage,
      "original_title": originalTitle,
      "overview": overview,
      "popularity": popularity,
      "poster_path": posterPath,
      "production_companies": productionCompanies
          .map((e) => {
                "id": e.id,
                "logo_path": e.logoPath,
                "name": e.name,
                "origin_country": e.originCountry,
              })
          .toList(),
      "production_countries": productionCountries
          .map((e) => {
                "iso_3166_1": e.isoCode,
                "name": e.name,
              })
          .toList(),
      "release_date": releaseDate,
      "revenue": revenue,
      "runtime": runtime,
      "spoken_languages": spokenLanguages
          .map((e) => {
                "english_name": e.englishName,
                "iso_639_1": e.isoCode,
                "name": e.name,
              })
          .toList(),
      "status": status,
      "tagline": tagline,
      "title": title,
      "video": video,
      "vote_average": voteAverage,
      "vote_count": voteCount,
    };
  }

  static MovieDetailModel fromMovieModel(MovieModel model) {
    return MovieDetailModel(
      adult: model.adult,
      backdropPath: model.backdropPath,
      budget: 0,
      genres: model.genreIds.map((id) => GenreEntity(id: id, name: '')).toList(),
      homepage: '',
      id: model.id,
      imdbId: '',
      originCountry: [],
      originalLanguage: model.originalLanguage,
      originalTitle: model.originalTitle,
      overview: model.overview,
      popularity: model.popularity,
      posterPath: model.posterPath,
      productionCompanies: [],
      productionCountries: [],
      releaseDate: model.releaseDate,
      revenue: 0,
      runtime: 0,
      spokenLanguages: [],
      status: '',
      tagline: '',
      title: model.title,
      video: model.video,
      voteAverage: model.voteAverage,
      voteCount: model.voteCount,
    );
  }
}
