import 'package:movies_api/movies_api.dart';
import 'package:movies_data/src/models/models.dart';
import 'package:movies_data/src/models/movie_item/movies_list.dart';
import 'package:movies_data/src/service/movie_api_service_impl.dart';

const topRated = 'top_rated';
const upcoming = 'upcoming';
const latest = 'latest';
const nowPlaying = 'now_playing';
const popular = 'popular';
const imageUrl = 'https://image.tmdb.org/t/p/w500/';

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
}

class MoviesRepository {
  final MovieApiService movieApiService = MovieApiServiceImpl();

  Future<MoviesList> getMoviesByType({
    required int page,
    required MovieType type,
  }) async {
    try {
      final movies = await movieApiService.getMovieByType(
        type: type.getType,
        page: page,
      );

      final convertedMovies = movies.results!.map(
        (element) => MovieItem(
          id: element.id.toString(),
          title: element.title.toString(),
          rate: element.voteAverage.toString(),
          language: element.originalLanguage.toString(),
          posterPath: imageUrl + element.posterPath.toString(),
        ),
      );

      return MoviesList(
        movies: convertedMovies.toList(),
        page: page,
        totalPages: movies.totalPages,
      );
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
        backdropPath: imageUrl + movie.backdropPath.toString(),
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
      final genresResult = await movieApiService.getAllGenres();

      return genresResult.genres!
          .map((e) => GenreItem(
                id: e.id,
                name: e.name,
              ))
          .toList();
    } catch (error) {
      throw error;
    }
  }

  Future<MoviesList> getSimilarMovies({
    required String movieId,
    required int page,
  }) async {
    try {
      final movies = await movieApiService.getSimilarMovies(
        movieId: movieId,
        page: page,
      );

      final convertedMovies = movies.results!.map(
        (element) => MovieItem(
          id: element.id.toString(),
          title: element.title.toString(),
          rate: element.voteAverage.toString(),
          language: element.originalLanguage.toString(),
          posterPath: imageUrl + element.posterPath.toString(),
        ),
      );

      return MoviesList(
        movies: convertedMovies.toList(),
        page: page,
        totalPages: movies.totalPages,
      );
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