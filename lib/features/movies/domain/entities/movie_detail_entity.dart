class MovieDetailEntity {
  final bool adult;
  final String? backdropPath;
  final int budget;
  final List<GenreEntity> genres;
  final String homepage;
  final int id;
  final String imdbId;
  final List<String> originCountry;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String? posterPath;
  final List<ProductionCompanyEntity> productionCompanies;
  final List<ProductionCountryEntity> productionCountries;
  final String releaseDate;
  final int revenue;
  final int runtime;
  final List<SpokenLanguageEntity> spokenLanguages;
  final String status;
  final String tagline;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;

  MovieDetailEntity({
    required this.adult,
    required this.backdropPath,
    required this.budget,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.imdbId,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.productionCompanies,
    required this.productionCountries,
    required this.releaseDate,
    required this.revenue,
    required this.runtime,
    required this.spokenLanguages,
    required this.status,
    required this.tagline,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });
}

class GenreEntity {
  final int id;
  final String name;

  GenreEntity({
    required this.id,
    required this.name,
  });
}

class ProductionCompanyEntity {
  final int id;
  final String? logoPath;
  final String name;
  final String originCountry;

  ProductionCompanyEntity({
    required this.id,
    required this.logoPath,
    required this.name,
    required this.originCountry,
  });
}

class ProductionCountryEntity {
  final String isoCode;
  final String name;

  ProductionCountryEntity({
    required this.isoCode,
    required this.name,
  });
}

class SpokenLanguageEntity {
  final String englishName;
  final String isoCode;
  final String name;

  SpokenLanguageEntity({
    required this.englishName,
    required this.isoCode,
    required this.name,
  });
}
