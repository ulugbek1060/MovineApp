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
  final List<MovieItem> nowPlayingMovies;
  final bool isLoading;
  final Object? error;

  const NowPlayingMoviesState(
      {required this.nowPlayingMovies, required this.isLoading, this.error});

  NowPlayingMoviesState.initial()
      : this(nowPlayingMovies: [], isLoading: false, error: null);

  NowPlayingMoviesState copyWith({
    List<MovieItem>? nowPlayingMovies,
    bool? isLoading,
    Object? error,
  }) {
    return NowPlayingMoviesState(
      nowPlayingMovies: nowPlayingMovies ?? this.nowPlayingMovies,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [nowPlayingMovies, isLoading, error];
}

class PopularMoviesState extends Equatable {
  final List<MovieItem> popularMovies;
  final bool isLoading;
  final Object? error;

  const PopularMoviesState(
      {required this.popularMovies, required this.isLoading, this.error});

  PopularMoviesState.initial()
      : this(popularMovies: [], isLoading: false, error: null);

  PopularMoviesState copyWith({
    List<MovieItem>? popularMovies,
    bool? isLoading,
    Object? error,
  }) {
    return PopularMoviesState(
      popularMovies: popularMovies ?? this.popularMovies,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [popularMovies, isLoading, error];
}

class TopRatedMoviesState extends Equatable {
  final List<MovieItem> topRatedMovies;
  final bool isLoading;
  final Object? error;

  const TopRatedMoviesState(
      {required this.topRatedMovies, required this.isLoading, this.error});

  TopRatedMoviesState.initial()
      : this(topRatedMovies: [], isLoading: false, error: null);

  TopRatedMoviesState copyWith({
    List<MovieItem>? topRatedMovies,
    bool? isLoading,
    Object? error,
  }) {
    return TopRatedMoviesState(
      topRatedMovies: topRatedMovies ?? this.topRatedMovies,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [topRatedMovies, isLoading, error];
}

class UpcomingMoviesState extends Equatable {
  final List<MovieItem> upcomingMovies;
  final bool isLoading;
  final Object? error;

  const UpcomingMoviesState(
      {required this.upcomingMovies, required this.isLoading, this.error});

  UpcomingMoviesState.initial()
      : this(upcomingMovies: [], isLoading: false, error: null);

  UpcomingMoviesState copyWith({
    List<MovieItem>? upcomingMovies,
    bool? isLoading,
    Object? error,
  }) {
    return UpcomingMoviesState(
      upcomingMovies: upcomingMovies ?? this.upcomingMovies,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [upcomingMovies, isLoading, error];
}
