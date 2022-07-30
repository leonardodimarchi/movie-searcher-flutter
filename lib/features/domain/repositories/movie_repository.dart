import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_searcher_flutter/core/errors/failures.dart';
import 'package:movie_searcher_flutter/features/domain/entities/movie_credits_entity.dart';
import 'package:movie_searcher_flutter/features/domain/entities/movie_detail_entity.dart';
import 'package:movie_searcher_flutter/features/domain/entities/movie_entity.dart';

abstract class MovieRepository {
  Future<Either<Failure, List<MovieEntity>>> getMovies(GetMoviesParams params);
  Future<Either<Failure, MovieDetailEntity>> getMovie(int id);
  Future<Either<Failure, MovieCreditsEntity>> getMovieCredits(int movieId);
  Future<Either<Failure, List<MovieEntity>>> searchMovies(SearchMovieParams params);
}

class SearchMovieParams extends Equatable {
  final String searchText;
  final int page;

  const SearchMovieParams({
    this.searchText = '',
    this.page = 1,
  });

  @override
  List<Object> get props => [searchText, page];
}

class GetMoviesParams extends Equatable {
  final GetMovieType type;
  final int page;

  const GetMoviesParams({
    this.type = GetMovieType.popular,
    this.page = 1,
  });

  @override
  List<Object> get props => [type, page];
}

enum GetMovieType {
  popular,
  topRated,
  upcoming,
}

extension ParseToString on GetMovieType {
  String toShortString() {
    // ignore: unnecessary_this
    return this.toString().split('.').last;
  }
}
