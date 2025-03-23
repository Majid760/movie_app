import 'package:hive_flutter/hive_flutter.dart';

import '../models/movie_model.dart';

abstract class AppLocalDataSource {
  Future<void> cacheMovies(List<MovieModel> movies);
  Future<List<MovieModel>> getCachedMovies();
  Future<bool> isCacheValid();
}

class AppLocalDataSourceImpl implements AppLocalDataSource {
  static const String _boxName = 'moviesBox';
  static const String _cacheKey = 'cached_movies';
  static const String _cacheTimeKey = 'cache_timestamp';

  late Box _moviesBox;

  /// Initialize Hive (must be called before using this class)
  Future<void> init() async {
    await Hive.initFlutter();
    _moviesBox = await Hive.openBox(_boxName);
  }

  @override
  Future<void> cacheMovies(List<MovieModel> movies) async {
    await _moviesBox.put(_cacheKey, movies.map((e) => e.toJson()).toList());
    await _moviesBox.put(_cacheTimeKey, DateTime.now().millisecondsSinceEpoch);
  }

  @override
  Future<List<MovieModel>> getCachedMovies() async {
    final jsonList = _moviesBox.get(_cacheKey) as List<dynamic>?;
    if (jsonList == null) return [];
    return jsonList.map((json) => MovieModel.fromJson(Map<String, dynamic>.from(json))).toList();
  }

  @override
  Future<bool> isCacheValid() async {
    final cachedTime = _moviesBox.get(_cacheTimeKey) as int?;
    if (cachedTime == null) return false;
    return DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(cachedTime)).inMinutes < 30;
  }
}
