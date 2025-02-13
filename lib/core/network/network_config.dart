class NetworkConfigs {
  static const apiToken =
      "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzMzdkZTk2NWFhMTY5OWUyZjc4MGM2MjUyMGUxZDY5NSIsIm5iZiI6MTczOTM1OTUyMy44Niwic3ViIjoiNjdhYzg1MjNlMDlkNmM5MTkwYjBhMDBmIiwic2NvcGVzIjpbImFwaV9yZWFkIl0sInZlcnNpb24iOjF9.9ud-1fbgY9IOxXVv4pefa3l_XUKr308TW-wXAj-c-oM";

  static const String apiBaseUrl = 'https://api.themoviedb.org/3';
  static const apiKey = "337de965aa1699e2f780c62520e1d695";

  static const String imageDomain = 'https://image.tmdb.org/t/p/w600_and_h900_bestv2';

  static const String movie = '/movie';
  static const String upcomingMovies = '/$movie/upcoming';
  static const String movieCategories = '/genre/movie/list';
  static const String searchCategories = '/discover/movie?with_genres=';
  static const String searchMovies = '/search/movie?query=';
  static const String getMovieTrailer = movie;

  static const String search = '/search/$movie';
  static const header = {'Authorization': 'Bearer $apiToken', 'content-Type': 'application/json'};
}
