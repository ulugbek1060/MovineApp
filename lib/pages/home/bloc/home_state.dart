part of 'home_bloc.dart';

class HomeState extends Equatable {
  final UpcomingMoviesState upcomingState;
  final NowPlayingMoviesState nowPlayingState;
  final PopularMoviesState popularState;
  final TopRatedMoviesState topRatedState;

  const HomeState({
    required this.nowPlayingState,
    required this.popularState,
    required this.topRatedState,
    required this.upcomingState,
  });

  HomeState.initial()
      : this(
          nowPlayingState: NowPlayingMoviesState.initial(),
          popularState: PopularMoviesState.initial(),
          topRatedState: TopRatedMoviesState.initial(),
          upcomingState: UpcomingMoviesState.initial(),
        );

  HomeState copyWith({
    NowPlayingMoviesState? nowPlayingState,
    PopularMoviesState? popularState,
    TopRatedMoviesState? topRatedState,
    UpcomingMoviesState? upcomingState,
  }) {
    return HomeState(
      nowPlayingState: nowPlayingState ?? this.nowPlayingState,
      popularState: popularState ?? this.popularState,
      topRatedState: topRatedState ?? this.topRatedState,
      upcomingState: upcomingState ?? this.upcomingState,
    );
  }

  @override
  List<Object?> get props => [
        nowPlayingState,
        popularState,
        topRatedState,
        upcomingState,
      ];
}

class NowPlayingMoviesState extends Equatable {
  final List<MovieItem> movies;
  final Status status;
  final Object? error;

  const NowPlayingMoviesState(
      {required this.movies, required this.status, this.error});

  NowPlayingMoviesState.initial()
      : this(movies: [], status: Status.empty, error: null);

  NowPlayingMoviesState copyWith({
    List<MovieItem>? movies,
    Status? status,
    Object? error,
  }) {
    return NowPlayingMoviesState(
      movies: movies ?? this.movies,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [movies, status, error];
}

class PopularMoviesState extends Equatable {
  final List<MovieItem> movies;
  final Status status;
  final Object? error;

  const PopularMoviesState(
      {required this.movies, required this.status, this.error});

  PopularMoviesState.initial()
      : this(movies: [], status: Status.empty, error: null);

  PopularMoviesState copyWith({
    List<MovieItem>? movies,
    Status? status,
    Object? error,
  }) {
    return PopularMoviesState(
      movies: movies ?? this.movies,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [movies, status, error];
}

class TopRatedMoviesState extends Equatable {
  final List<MovieItem> movies;
  final Status status;
  final Object? error;

  const TopRatedMoviesState(
      {required this.movies, required this.status, this.error});

  TopRatedMoviesState.initial()
      : this(movies: [], status: Status.empty, error: null);

  TopRatedMoviesState copyWith({
    List<MovieItem>? movies,
    Status? status,
    Object? error,
  }) {
    return TopRatedMoviesState(
      movies: movies ?? this.movies,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [movies, status, error];
}

class UpcomingMoviesState extends Equatable {
  final List<MovieItem> movies;
  final Status status;
  final Object? error;

  const UpcomingMoviesState(
      {required this.movies, required this.status, this.error});

  UpcomingMoviesState.initial()
      : this(movies: [], status: Status.empty, error: null);

  UpcomingMoviesState copyWith({
    List<MovieItem>? movies,
    Status? status,
    Object? error,
  }) {
    return UpcomingMoviesState(
      movies: movies ?? this.movies,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [movies, status, error];
}
