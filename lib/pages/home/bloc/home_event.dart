part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class FetchUpcomingMoviesEvent extends HomeEvent {}

class FetchNowPlayingMoviesEvent extends HomeEvent {}

class FetchPopularMoviesEvent extends HomeEvent {}

class FetchTopRatedMoviesEvent extends HomeEvent {}
