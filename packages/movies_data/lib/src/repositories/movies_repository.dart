import 'package:movies_api/movies_api.dart';
import 'package:movies_data/movies_data.dart';
import 'package:movies_data/src/models/models.dart';
import 'package:movies_data/src/api/movie_api_impl.dart';

const topRated = 'top_rated';
const upcoming = 'upcoming';
const latest = 'latest';
const nowPlaying = 'now_playing';
const popular = 'popular';
const imageUrl = 'https://image.tmdb.org/t/p/w500';
const originalImageUrl = 'https://image.tmdb.org/t/p/original';

enum MovieType { TOP_RATED, UPCOMING, LATEST, NOW_PLAYING, POPULAR }

extension GetMovieType on MovieType {
  String get getType {
    switch (this) {
      case MovieType.TOP_RATED:
        return 'top_rated';
      case MovieType.UPCOMING:
        return 'upcoming';
      case MovieType.LATEST:
        return 'latest';
      case MovieType.NOW_PLAYING:
        return 'now_playing';
      case MovieType.POPULAR:
        return 'popular';
    }
  }

  String get getTypeText {
    switch (this) {
      case MovieType.TOP_RATED:
        return 'Top rated';
      case MovieType.UPCOMING:
        return 'Upcoming';
      case MovieType.LATEST:
        return 'Latest';
      case MovieType.NOW_PLAYING:
        return 'Now playing';
      case MovieType.POPULAR:
        return 'Popular';
    }
  }
}

class MoviesRepository {
  final MovieApi movieApiService = MovieApiServiceImpl();

  Future<MoviesList> getMoviesByType({
    required int page,
    required MovieType type,
  }) async {
    try {
      final result = await movieApiService.getMovieByType(
        type: type.getType,
        page: page,
      );

      final movies = result.results!.map(
        (element) => MovieItem(
          id: element.id.toString(),
          title: element.title.toString(),
          rate: element.voteAverage.toString(),
          posterPath: imageUrl + element.posterPath.toString(),
          backdropPath: originalImageUrl + element.backdropPath.toString(),
        ),
      );

      return MoviesList(movies: movies.toList(), page: result.page);
    } catch (error) {
      throw error;
    }
  }

  Future<MoviesList> getMoviesByQuery({
    String? query,
    required int page,
  }) async {
    try {
      await Future.delayed(Duration(seconds: 2));

      final result = await movieApiService.getMoviesByQuery(
        query: query,
        page: page,
      );

      final movies = result.results!.map(
        (element) => MovieItem(
          id: element.id.toString(),
          title: element.title.toString(),
          rate: element.voteAverage.toString(),
          posterPath: imageUrl + element.posterPath.toString(),
          backdropPath: originalImageUrl + element.backdropPath.toString(),
        ),
      );

      return MoviesList(movies: movies.toList(), page: result.page);
    } catch (error) {
      throw error;
    }
  }

  Future<MoviesList> discoverMovies({
    required int page,
    String? genreId,
    String? language,
    String? year,
  }) async {
    try {
      final result = await movieApiService.discoverMovies(
        page: page,
        genreId: genreId,
        language: language,
        year: year,
      );

      final movies = result.results!.map(
        (element) => MovieItem(
          id: element.id.toString(),
          title: element.title.toString(),
          rate: element.voteAverage.toString(),
          posterPath: imageUrl + element.posterPath.toString(),
          backdropPath: originalImageUrl + element.backdropPath.toString(),
        ),
      );

      return MoviesList(movies: movies.toList(), page: result.page);
    } catch (error) {
      throw error;
    }
  }

  Future<MovieDetail> getMovieDetail(String movieId) async {
    try {
      final movie = await movieApiService.getMovieDetail(movieId: movieId);
      return MovieDetail(
        id: movie.id.toString(),
        title: movie.originalTitle.toString(),
        poserPath: imageUrl + movie.posterPath.toString(),
        backdropPath: originalImageUrl + movie.backdropPath.toString(),
        quality: '4k',
        duration: movie.runtime.toString(),
        rating: movie.voteAverage.toString(),
        releaseData: movie.releaseDate.toString(),
        genres: movie.genres!.map((e) => e.name.toString()).toList(),
        overview: movie.overview.toString(),
        language: movie.originalLanguage.toString(),
      );
    } catch (error) {
      throw error;
    }
  }

  Future<List<GenreItem>> getGenres() async {
    try {
      final result = await movieApiService.getAllGenres();

      return result.genres!
          .map((e) => GenreItem(id: e.id, name: e.name))
          .toList();
    } catch (error) {
      throw error;
    }
  }

  Future<MoviesList> getSimilarMovies({
    required String movieId,
    int? page,
  }) async {
    try {
      final result = await movieApiService.getSimilarMovies(
        movieId: movieId,
        page: page,
      );

      final movies = result.results!.map(
        (element) => MovieItem(
          id: element.id.toString(),
          title: element.title.toString(),
          rate: element.voteAverage.toString(),
          posterPath: imageUrl + element.posterPath.toString(),
          backdropPath: originalImageUrl + element.backdropPath.toString(),
        ),
      );

      return MoviesList(movies: movies.toList(), page: result.page);
    } catch (error) {
      throw error;
    }
  }

  Future<Videos> getVideosByMovieId({required String movieId}) async {
    try {
      final videos = await movieApiService.getVideoDataById(movieId: movieId);
      return Videos(
        id: videos.id.toString(),
        videos: videos.results!
            .map((e) => VideoItem(
                  name: e.name.toString(),
                  id: e.id.toString(),
                  size: e.size.toString(),
                  key: e.key.toString(),
                ))
            .toList(),
      );
    } catch (error) {
      throw error;
    }
  }
}
