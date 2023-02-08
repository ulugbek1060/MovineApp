part of 'register_bloc.dart';

class RegisterState extends Equatable {
  final bool isLoading;
  final Object? error;
  final List<GenreItem> genres;

  const RegisterState(
      {required this.isLoading, this.error, required this.genres});

  RegisterState.initial() : this(isLoading: false, genres: [], error: null);

  RegisterState copyWith({
    bool? isLoading,
    Object? error,
    List<GenreItem>? genres,
  }) {
    return RegisterState(
      isLoading: isLoading ?? this.isLoading,
      genres: genres ?? this.genres,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [isLoading, genres, error];
}
