import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/pages/detail/bloc/detail_movie_bloc.dart';
import 'package:movie_app/pages/detail/widgets/bottom_sheet_widget.dart';
import 'package:movies_data/movies_data.dart';
import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';

class DetailPage extends StatefulWidget {
  final String movieId;

  static Route<void> route(String movieId) {
    return MaterialPageRoute(
      builder: (context) => DetailPage(
        movieId: movieId,
      ),
    );
  }

  const DetailPage({super.key, required this.movieId});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late SolidController _controller;

  @override
  void initState() {
    super.initState();
    _controller = SolidController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return BlocProvider(
      create: (_) => DetailMovieBloc(
        moviesRepository: RepositoryProvider.of<MoviesRepository>(context),
      )..add(FetchedMovieDetailEvent(movieId: widget.movieId)),
      child: _movieDetailView(height: height, width: width),
    );
  }

  Widget _movieDetailView({required double height, required double width}) {
    return BlocBuilder<DetailMovieBloc, DetailMovieState>(
      builder: (context, state) {
        if (state.isLoading) {
          return Container(
            color: Theme.of(context).primaryColor,
            child: const Center(
              child: CircularProgressIndicator(color: Colors.white,),
            ),
          );
        }
        if (state.movie == null) {
          return Container(
            color: Theme.of(context).primaryColor,
          );
        }
        return Scaffold(
          backgroundColor: Theme.of(context).primaryColor,
          body: Stack(
            children: [
              StreamBuilder<double>(
                stream: _controller.heightStream,
                initialData: 0.0,
                builder: (_, snapshot) {
                  return AnimatedContainer(
                    curve: Curves.easeOut,
                    duration: const Duration(milliseconds: 100),
                    height: height * 0.65 - snapshot.data!,
                    width: double.infinity,
                    child: Image.network(
                      state.movie!.poserPath,
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
              Positioned(
                top: 30,
                left: 16,
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
          bottomSheet: BottomSheetWidget(
            height: height,
            width: width,
            controller: _controller,
            movie: state.movie!,
          ),
        );
      },
    );
  }
}
